class CreateTopicGroups < ActiveRecord::Migration
  def change
    create_table :topic_groups do |t|
      t.integer :order
      t.string :name
      t.string :key
      t.boolean :active

      t.timestamps
    end
    add_index :topic_groups, :key, :unique => true
    add_index :topic_groups, [:key, :updated_at]
  end
end
