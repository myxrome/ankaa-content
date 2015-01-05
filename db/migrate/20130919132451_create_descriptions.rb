class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.integer :value_id
      t.integer :order
      t.boolean :active
      t.string :source
      t.string :caption
      t.text :text
      t.boolean :red
      t.boolean :bold

      t.timestamps
    end

    add_index :descriptions, [:value_id, :active]
    add_index :descriptions, [:value_id, :updated_at]
    add_index :descriptions, [:value_id, :source]
  end
end
