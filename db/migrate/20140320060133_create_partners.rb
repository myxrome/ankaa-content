class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.boolean :active
      t.string :name
      t.string :url
      t.attachment :logo
      t.string :file_key

      t.timestamps
    end

    add_index :partners, :active
    add_index :partners, :updated_at
  end
end
