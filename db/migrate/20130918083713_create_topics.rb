class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :topic_group_id
      t.integer :order
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
