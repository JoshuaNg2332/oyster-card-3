class Oystercard
  
  # VALUE CONSTANTS
  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  # ERROR CONSTANTS
  BALANCE_ERROR = "Topup will exceed maximum balance of #{MAXIMUM_BALANCE}, Topup not processed"
  INSUFFICIENT_FUND_ERROR = "Insufficient funds :("
  
  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_START_BALANCE
    #@entry_station = nil
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(BALANCE_ERROR) : @balance += credit
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise(INSUFFICIENT_FUND_ERROR) if (@balance < MINIMUM_FARE)
    #@in_journey = true
    @entry_station = station
  end

  def touch_out
    #@in_journey = false
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
