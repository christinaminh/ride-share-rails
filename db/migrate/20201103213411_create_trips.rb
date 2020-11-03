class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :driver
      t.string :passenger
      t.string :date
      t.integer :rating
      t.integer :cost

      t.timestamps
    end
  end
end
