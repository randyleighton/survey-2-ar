class CreateTakers < ActiveRecord::Migration
  def change
    create_table :takers do |t|
      t.column :survey_id, :integer

      t.timestamps
    end
  end
end
