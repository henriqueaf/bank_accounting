class CreateTransferences < ActiveRecord::Migration[5.2]
  def change
    create_table :transferences do |t|
      t.references :account, foreign_key: true
      t.decimal :value, precision: 15, scale: 2

      t.timestamps
    end
  end
end
