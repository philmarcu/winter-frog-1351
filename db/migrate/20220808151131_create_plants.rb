class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :descrpt
      t.integer :harvest_days
      t.timestamps
    end
  end
end
