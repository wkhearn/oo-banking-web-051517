class Transfer
  attr_accessor :sender,:receiver,:amount,:status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if sender.valid? == true && receiver.valid? == true && sender.balance > amount
      return true
    else
      return false
    end
  end

  def execute_transaction
    if self.status == "complete"
      return
    elsif self.valid? == false
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    else
      sender.balance -= amount
      receiver.deposit(amount)
      self.status = "complete"
    end
  end

  def reverse_transfer
    if self.status == "complete"
      receiver.balance -= amount
      sender.deposit(amount)
      self.status = "reversed"
    # elsif self.valid? == false
    #   self.status = "rejected"
    #   return "Transaction rejected. Please check your account balance."
    # else
    #   sender.balance -= amount
    #   receiver.deposit(amount)
    #   self.status = "complete"
    end
  end

end
