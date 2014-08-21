class AddTakerIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :taker_id, :integer
  end
end
