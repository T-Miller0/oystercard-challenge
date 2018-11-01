class Journey

  attr_reader :entry_station
  def initialize
    @in_use = false
    @entry_station = nil
  end

  def touch_in(tube_stop)
    @entry_station = tube_stop
    @in_use = true
  end

  def touch_out(tube_stop)
    journey = {entry_station: entry_station, exit_station: tube_stop}
    entry_station = nil
    @in_use = false
    journey
  end

  def in_journey?
    @in_use
  end

end
