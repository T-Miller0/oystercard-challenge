class Oystercard

  MAX_BALANCE = 90

  MIN_CHARGE = 1


  attr_reader :balance, :station

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(tube_stop)
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_CHARGE
    @station = tube_stop
    @in_use = true
  end

  def touch_out
    deduct(MIN_CHARGE)
    @station = nil
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
