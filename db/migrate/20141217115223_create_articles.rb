class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :price
      t.string :category
      t.string :state
      t.string :creater

      t.timestamps
    end
  end
end
