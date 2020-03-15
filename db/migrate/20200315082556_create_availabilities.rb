class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :repeats
      t.integer :tour_id

      t.timestamps
    end
  end
end
