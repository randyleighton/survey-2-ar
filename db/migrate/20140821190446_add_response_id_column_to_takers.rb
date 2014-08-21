class AddResponseIdColumnToTakers < ActiveRecord::Migration
  def change
    add_column :takers, :response_id, :integer
  end
end
