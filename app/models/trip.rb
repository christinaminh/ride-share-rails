class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6, allow_nil: true}
  validates :cost, numericality: { only_integer: true, greater_than: 0}

  def self.default_fields
    default_date = "#{Date.today.strftime("%F")}"
    default_cost = rand(1000...3000)

    default_trip_fields = {
      passenger_id: nil,
      driver_id: nil,
      date: default_date,
      rating: nil,
      cost: default_cost
    }

    return default_trip_fields
  end
end
