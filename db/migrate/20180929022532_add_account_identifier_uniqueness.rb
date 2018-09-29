class AddAccountIdentifierUniqueness < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, :identifier, unique: true
  end
end
