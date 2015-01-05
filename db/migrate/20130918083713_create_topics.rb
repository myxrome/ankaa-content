class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :topic_group_id
      t.integer :order
      t.boolean :active
      t.string :name
      t.string :displayed_name

      t.timestamps
    end

    add_index :topics, [:topic_group_id, :active]
    add_index :topics, [:topic_group_id, :updated_at]
  end
end
