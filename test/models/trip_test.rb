require "test_helper"

describe Trip do
  before do
    @driver = Driver.create( name: "sample driver",  vin: "A", available: true)

    @passenger = Passenger.create( name: "sample passenger", phone_num: "000-000-0000")

    @trip = Trip.create( driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, rating: nil, cost: 1234)
  end

  it "can be instantiated" do
    expect(@trip.valid?).must_equal true
  end

  it "will have the required fields" do
    expect(@trip).must_respond_to :driver_id
    expect(@trip).must_respond_to :passenger_id
    expect(@trip).must_respond_to :date
    expect(@trip).must_respond_to :rating
    expect(@trip).must_respond_to :cost
  end

  describe "relationships" do
    it "belongs to a driver" do
      expect(@trip.driver).must_be_instance_of Driver
    end

    it "belongs to a passenger" do
      expect(@trip.passenger).must_be_instance_of Passenger
    end
  end

  describe "validations" do
    it "must have a driver id" do
      @trip.driver_id = nil

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :driver_id
      expect(@trip.errors.messages).must_include :driver
      expect(@trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
      expect(@trip.errors.messages[:driver]).must_equal ["must exist"]
    end

    it "must have an existing driver" do
      @trip.driver_id = -1

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :driver
      expect(@trip.errors.messages[:driver]).must_equal ["must exist"]
    end

    it "must have a passenger id" do
      @trip.passenger_id = nil

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :passenger_id
      expect(@trip.errors.messages).must_include :passenger
      expect(@trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
      expect(@trip.errors.messages[:passenger]).must_equal ["must exist"]
    end

    it "must have an existing passenger" do
      @trip.passenger_id = -1

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :passenger
      expect(@trip.errors.messages[:passenger]).must_equal ["must exist"]
    end

    it "must have a date" do
      @trip.date = nil

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :date
      expect(@trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a rating of nil or between 1-5" do
      @trip.rating = 0

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :rating
      expect(@trip.errors.messages[:rating]).must_equal ["must be greater than 0"]

      @trip.rating = 6

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :rating
      expect(@trip.errors.messages[:rating]).must_equal ["must be less than 6"]
    end

    it "must have a cost" do
      @trip.cost = 0

      expect(@trip.valid?).must_equal false
      expect(@trip.errors.messages).must_include :cost
      expect(@trip.errors.messages[:cost]).must_equal ["must be greater than 0"]
    end

  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "default fields" do
      it "returns a hash of parameters for a new trip" do
        expect(Trip.default_fields).must_be_kind_of Hash

        expect(Trip.default_fields).must_include :driver_id
        expect(Trip.default_fields).must_include :passenger_id
        expect(Trip.default_fields).must_include :date
        expect(Trip.default_fields).must_include :rating
        expect(Trip.default_fields).must_include :cost
      end
    end
  end
end
