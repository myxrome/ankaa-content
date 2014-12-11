class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :topic_group_id
      t.integer :order
      t.string :name
      t.string :displayed_name
      t.boolean :active

      t.timestamps
    end

    add_index :topics, [:topic_group_id, :active, :updated_at]
    add_index :topics, [:topic_group_id, :order]
  end
end
