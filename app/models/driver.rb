class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    earnings = 0
    all_trips = self.trips

    all_trips.each do |trip|
      if trip.cost == nil
        next
      elsif trip.cost <= 165
        earnings += trip.cost.to_f * 0.8
      else
        earnings += (trip.cost.to_f - 165) * 0.8
      end
    end

    return (earnings.to_f/100).round(2)
  end

  def average_rating
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      total += trip.rating.to_f
    end
    if all_trips.length == 0
      return 0
    end
    average_total = total / all_trips.length
    return average_total.round(2)
  end
end
