class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :topic_id
      t.integer :order
      t.string :name
      t.string :displayed_name
      t.boolean :active

      t.timestamps
    end

    add_index :categories, [:topic_id, :order]
    add_index :categories, [:topic_id, :active]
  end
end
