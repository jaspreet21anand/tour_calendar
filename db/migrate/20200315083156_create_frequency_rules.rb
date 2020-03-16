class CreateFrequencyRules < ActiveRecord::Migration[6.0]
  def change
    create_table :frequency_rules do |t|
      t.integer :frequency_type
      t.json :specifics
      t.integer :availability_id

      t.timestamps
    end
    add_index :frequency_rules, :availability_id
  end
end
