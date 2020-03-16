class CreateTours < ActiveRecord::Migration[6.0]
  def change
    create_table :tours do |t|
      t.string :title
      t.text :description
      t.string :contact_details

      t.timestamps
    end
  end
end
