class CreateFrequencyRules < ActiveRecord::Migration[6.0]
  def change
    create_table :frequency_rules do |t|
      t.integer :frequency_type
      t.json :specifics

      t.timestamps
    end
  end
end
