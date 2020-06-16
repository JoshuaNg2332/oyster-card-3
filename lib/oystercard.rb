class Oystercard

  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  BALANCE_ERROR = "Topup will exceed maximum balance of #{MAXIMUM_BALANCE}, Topup not processed"
  attr_reader :balance, :in_journey

  def initialize
    @balance = DEFAULT_START_BALANCE
    @in_journey = false
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(BALANCE_ERROR) : @balance += credit
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
