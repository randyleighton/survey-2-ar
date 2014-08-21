class RemoveResponseIdFromTaker < ActiveRecord::Migration
  def change
    remove_column :takers, :response_id, :integer
  end
end
