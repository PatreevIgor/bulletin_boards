class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :user_name
      t.string :action
      t.text :object
      t.text :time

      t.timestamps
    end
  end
end
