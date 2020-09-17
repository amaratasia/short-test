class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url
  validates :full_url, presence: true

  def update_title!
  end

  private

  def validate_full_url
    if (full_url =~ URI::regexp(%w[http https])).nil?
      self.errors.add(:full_url, 'is not a valid url')
    end
  end

end
