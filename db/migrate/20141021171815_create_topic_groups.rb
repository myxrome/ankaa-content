class CreateTopicGroups < ActiveRecord::Migration
  def change
    create_table :topic_groups do |t|
      t.integer :order
      t.boolean :active
      t.string :key
      t.string :name

      t.timestamps
    end

    add_index :topic_groups, [:key, :active]
    add_index :topic_groups, [:key, :updated_at]
  end
end
