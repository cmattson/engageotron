class AddEmailToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :email, :string
    add_index :contacts, :email, unique: true
  end
end
