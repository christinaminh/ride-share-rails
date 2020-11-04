require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create( name: "sample driver",  vin: "A", available: true)
    # # we might need a different driver if the available status toggles to false when creating a trip
    # @driver2 = Driver.create( name: "another driver",  vin: "B", available: true)

    @passenger = Passenger.create( name: "sample passenger", phone_num: "000-000-0000")

    @trip = Trip.new( driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, rating: nil, cost: 1234)
  end

  describe "index" do
    it "responds with success when there are trips saved" do
      get trips_path

      must_respond_with :success
    end

    it "responds with success when there are no trips saved" do
      Trips.destroy_all

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing trip" do
      get trip_path(@trip)

      must_respond_with :success
    end

    it "responds with 404 with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_trip_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new trip and redirects" do
      new_trip_hash = {
        driver_id: @driver.id, # do we need to select a new driver if the available status toggles to false??
        passenger_id: @passenger.id,
        date: Date.today,
        rating: nil,
        cost: 1234
      }

      expect{
        post trips_path, params: new_trip_hash
      }.must_change "Trips.count", 1

      created_trip = Passenger.order(created_at: :desc).first

      expect(created_trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(created_trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]
      expect(created_trip.date).must_equal new_trip_hash[:trip][:date]
      expect(created_trip.rating).must_equal new_trip_hash[:trip][:rating]
      expect(created_trip.cost).must_equal new_trip_hash[:trip][:cost]

      must_redirect_to trip_path(created_trip)
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing trip" do
      get edit_trip_path(@trip)

      must_respond_with :success
    end

    it "respond with 404 when getting the edit page for a non-existent trip" do
      get edit_trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:updated_trip_hash) {
      {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Date.today,
          rating: 5,
          cost: 1234
        }
      }
    }

    it "updates an existing trip, and redirect" do
      expect{
        patch trip_path(@trip), params: updated_trip_hash
      }.must_change "Trips.count", 1

      @trip.reload

      expect(@trip.driver_id).must_equal updated_trip_hash[:trip][:driver_id]
      expect(@trip.passenger_id).must_equal updated_trip_hash[:trip][:passenger_id]
      expect(@trip.date).must_equal updated_trip_hash[:trip][:date]
      expect(@trip.rating).must_equal updated_trip_hash[:trip][:rating]
      expect(@trip.cost).must_equal updated_trip_hash[:trip][:cost]

      must_redirect_to trip_path(updated_trip)
    end

    it "does not update any trip if given an invalid id, and responds with 404" do
      expect{
        patch trip_path(-1), params: updated_trip_hash
      }.wont_change "Trips.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "destroys an existing trip, then redirects" do
      expect{
        delete trip_path(@trip)
      }.must_change "Trip.count", -1

      must_redirect_to trips_path
    end

    it "does not change the database when the trip does not exist, then responds with 404" do
      expect{
        delete trip_path(-1)
      }.wont_change "Trip.count"

      must_respond_with :not_found
    end
  end

end
