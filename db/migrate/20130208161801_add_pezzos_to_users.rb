class AddPezzosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pezzos, :integer
  end
end
