class AddUniqueIndexToShortUrl < ActiveRecord::Migration[6.0]
  def change
    add_index :short_urls, :short_code, unique: true
  end
end
