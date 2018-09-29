class UseCases::GetBalance
  def self.get_balance(account_id:)
    account = Account.find(account_id) #this ensure to raise an error if account does not exists
    Transference.where(account: account).sum(:value)
  end

  def self.get_balance_up_to_timestamp(account_id:, timestamp:)
    account = Account.find(account_id)
    transferences = account.transferences.where("created_at <= ?", timestamp)
    transferences.sum(:value)
  end
end
