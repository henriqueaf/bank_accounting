class AddNotNullToUserIdAndAccountId < ActiveRecord::Migration[5.2]
  def change
    change_column_null :accounts, :user_id, true
    change_column_null :transferences, :account_id, true
  end
end
