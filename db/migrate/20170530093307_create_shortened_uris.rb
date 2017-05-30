class CreateShortenedUris < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_uris do |t|
      t.text :original_uri
      t.string :shortened_relative_uri

      t.timestamps
    end
  end
end
