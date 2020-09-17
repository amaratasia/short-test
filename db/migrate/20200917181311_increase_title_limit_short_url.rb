class IncreaseTitleLimitShortUrl < ActiveRecord::Migration[6.0]
  def change
    change_column :short_urls, :title, :string, :limit => 200
  end
end
