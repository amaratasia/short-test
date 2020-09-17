class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url
  validates :full_url, presence: true

  before_create do
    begin
      self.short_code = generate_hash
    end while self.class.exists?(short_code: short_code)
  end

  def update_title!
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
