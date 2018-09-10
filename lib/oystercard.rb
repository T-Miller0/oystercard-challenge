class Oystercard

  MAX_BALANCE = 90

  MIN_CHARGE = 1


  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(tube_stop)
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_CHARGE
    @entry_station = tube_stop
    @in_use = true
  end

  def touch_out(tube_stop)
    deduct(MIN_CHARGE)
    @journey_history << {entry_station: @entry_station, exit_station: tube_stop}
    @entry_station = nil
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(money)
    @balance -= money
  end
end
