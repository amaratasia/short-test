class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url
  validates :full_url, presence: true

    before_create do
      begin
        self.short_code = generate_hash
      end while self.class.exists?(short_code: short_code)
    end

    after_create do
      UpdateTitleJob.perform_later(id)
    end

  def update_title!
    response = HTTParty.get(full_url)
    return nil unless response.success?

    title = Nokogiri::HTML::Document.parse(response.body).title
    update_column(:title, title)
  end

  def object
    as_json(only: %i[title full_url short_code click_count])
  end

  def increment_visit!
    update_column(:click_count, click_count+1)
  end

  def self.top_urls
    order(:click_count).limit(100).as_json(only: %i[title full_url short_code click_count])
    # TO DO cache top 100
  end

  private

  def validate_full_url
    if (full_url =~ URI::regexp(%w[http https])).nil?
      self.errors.add(:full_url, 'is not a valid url')
    end
  end

  def generate_hash
    salt = SecureRandom.hex(5)
    url = Digest::SHA2.base64digest(full_url+salt)[0..7]
  end

end
