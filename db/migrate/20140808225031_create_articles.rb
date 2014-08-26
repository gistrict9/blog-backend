class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :preview_image_url
      t.text :description
      t.text :content
      t.belongs_to :user
      t.boolean :published
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end

    #Index
    add_index :articles, :title
    add_index :articles, :user_id
    add_index :articles, :published
    add_index :articles, :published_at
    add_index :articles, :slug
  end
end
