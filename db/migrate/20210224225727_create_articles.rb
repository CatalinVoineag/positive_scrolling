class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null:false
      t.string :url, null:false
      t.string :image_url, null:false
      t.string :type_of_article, null:false

      t.timestamps
    end
  end
end
