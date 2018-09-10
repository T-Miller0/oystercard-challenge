class Oystercard

  MAX_BALANCE = 90

  MIN_BALANCE = 1

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end
