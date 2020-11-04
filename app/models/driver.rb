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
end
