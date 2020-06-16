class Oystercard
  
  # VALUE CONSTANTS
  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  # ERROR CONSTANTS
  BALANCE_ERROR = "Topup will exceed maximum balance of #{MAXIMUM_BALANCE}, Topup not processed"
  INSUFFICIENT_FUND_ERROR = "Insufficient funds :("
  
  attr_reader :balance, :in_journey

  def initialize
    @balance = DEFAULT_START_BALANCE
    @in_journey = false
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(BALANCE_ERROR) : @balance += credit
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @balance >= MINIMUM_FARE ? @in_journey = true : raise(INSUFFICIENT_FUND_ERROR)
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
