require 'journey'

class Oystercard

  MAX_BALANCE = 90

  MIN_CHARGE = 1


  attr_reader :balance, :entry_station, :journey_history, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_history = []
    @journey = journey
  end

  def top_up(money)
    fail "Balance would exceed #{MAX_BALANCE}" if balance + money > MAX_BALANCE
    @balance += money
  end

  def touch_in(tube_stop)
    fail "Insufficient funds. Balance: #{balance}" if balance < MIN_CHARGE
    journey.touch_in(tube_stop)
  end

  def touch_out(tube_stop)
    deduct(MIN_CHARGE)
    @journey_history << journey.touch_out(tube_stop)
    @journey_history.last
  end

  def in_journey?
    journey.in_journey?
  end

  private

  def deduct(money)
    @balance -= money
  end
end
