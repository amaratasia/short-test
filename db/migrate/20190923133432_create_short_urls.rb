class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :title, :limit => 100
      t.string :full_url, :limit => 500, null: false
      t.string :short_code, :limit => 20, null: false
      t.integer :click_count, default: 0
      t.timestamps
    end
  end
end
