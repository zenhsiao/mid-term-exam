class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end
    add_column :messages,:category_id,:integer
    add_index :messages,:category_id

  end
end
