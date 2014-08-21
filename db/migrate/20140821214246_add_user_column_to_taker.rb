class AddUserColumnToTaker < ActiveRecord::Migration
  def change
    add_column :takers, :user, :string
  end
end
