class Journey

  def initialize
    @journey_history = []
    @in_use = false
  end

  def touch_in(tube_stop)
    @entry_station = tube_stop
    @in_use = true
  end

  def touch_out(tube_stop)
    @journey_history << {entry_station: @entry_station, exit_station: tube_stop}
    @entry_station = nil
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end
