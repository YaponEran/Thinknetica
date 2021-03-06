# frozen_string_literal: true

class Train
  attr_reader :number, :type, :amount_wagon
  attr_accessor :speed

  def initialize(number, type, amount_wagon)
    @number = number
    @type = type
    @amount_wagon = amount_wagon
    @speed = 0
  end

  def move(speed)
    @speed += speed
  end

  def add_wagon
    @amount_wagon += 1 if @speed.zero?
  end

  def remove_wagon
    @amount_wagon -= 1 if @speed.zero? && @amount_wagon != 1
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    @route.first_st.add_train(self)
    @station = route.first_st
  end

  def move_station
    return if last_st?
  end

  def comeback_station
    return if first_st?
  end

  def next_station
    @route.stations[station_index + 1] unless last_st?
  end

  def prev_station
    @route.stations[station_index - 1] unless first_st?
  end

  private

  def station_index
    @route.stations.index(@station)
  end

  def last_st?
    @station == @route.last_st
  end

  def first_st?
    station_index == 0
  end
end
