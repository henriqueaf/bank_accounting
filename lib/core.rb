module Core
  def self.transfer_money?(source_account_id, destination_account_id, value)
    UseCases::TransferMoney.new(
      source_account_id: source_account_id,
      destination_account_id: destination_account_id,
      value: value
    ).transfer?
  end

  def self.get_balance(account_id)
    UseCases::GetBalance.get_balance(account_id: account_id)
  end
end
