class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :url
      t.attachment :logo
      t.boolean :active

      t.timestamps
    end

    add_index :partners, :active
  end
end
