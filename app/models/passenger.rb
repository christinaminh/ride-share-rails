class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true


  def total_charged
    if self.trips.empty?
      total_charged = 0
    else
      total_charged = self.trips.sum { |trip| trip.cost }
    end

    return total_charged
  end

  #TODO
  def add_trip(trip)
    # self.trips.create(trip_hash)?
    # request_trip in TripsController??
    self.trips << trip
  end

  # def request_ride
  #
  # end

  # def complete_trip
  #
  # end
end
