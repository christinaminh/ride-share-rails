class RelatePassengerAndDriverToTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :driver
    remove_column :trips, :passenger

    add_reference :trips, :driver, index: true
    add_reference :trips, :passenger, index: true
  end
end
