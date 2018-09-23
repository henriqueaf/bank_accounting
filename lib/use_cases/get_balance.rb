class UseCases::GetBalance
  def self.get_balance(account_id:)
    begin
      account = Account.find(account_id) #this ensure to raise an error if account does not exists
      Transference.where(account: account).sum(:value)
    rescue ActiveRecord::RecordNotFound
      return "Account not found"
    end
  end
end
