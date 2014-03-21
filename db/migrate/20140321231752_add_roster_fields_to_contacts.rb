class AddRosterFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :member_num, :integer
    add_column :contacts, :middle_name, :string
    add_column :contacts, :suffix, :string
    add_column :contacts, :member_cat_id, :integer
    add_column :contacts, :member_cat_name, :string
    add_column :contacts, :specialties, :string
    add_index  :contacts, :member_num, unique: true
  end
end
