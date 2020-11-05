class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = @passenger.trips
    else
      @trips = Trip.all
    end
  end

  def new
    default_date = "#{Date.today.strftime("%F")}"
    default_cost = rand(1000...3000)
    driver = find_available_driver


    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = @passenger.trips.new(
        driver_id: driver,
        date: default_date,
        rating: nil,
        cost: default_cost,
        )
    else
      @trip = Trip.new(
        driver_id: driver,
        date: default_date,
        rating: nil,
        cost: default_cost,
        )
    end
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      # Set driver availability to false once trip is created
      driver = Driver.find_by(id: trip_params[:driver_id])
      driver.available = false
      driver.save

      redirect_to trip_path(@trip)
      return
    else
      render :new
      return
    end
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip)
      return
    else
      redirect_to edit_trip_path
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.destroy
      redirect_to trips_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end


  def find_available_driver
    driver = Driver.find_by(available: true)

    return driver
  end
end
