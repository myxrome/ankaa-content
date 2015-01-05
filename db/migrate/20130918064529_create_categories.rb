class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :topic_id
      t.integer :order
      t.boolean :active
      t.string :name
      t.string :displayed_name

      t.timestamps
    end

    add_index :categories, [:topic_id, :active]
    add_index :categories, [:topic_id, :updated_at]
  end
end
