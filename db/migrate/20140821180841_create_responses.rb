class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :question_id, :integer
      t.column :choice_id, :integer

      t.timestamps
    end
  end
end
