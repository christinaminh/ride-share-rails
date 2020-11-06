class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :driver_id, presence: true
  validates :passenger_id, presence: true
  validates :date, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6, allow_nil: true}
  validates :cost, numericality: { only_integer: true, greater_than: 0}

  def set_date
    self.date = "#{Date.today.strftime("%F")}"
    return self.save
  end

  def set_cost
    self.cost = rand(1000...3000)
    return self.save
  end
end
