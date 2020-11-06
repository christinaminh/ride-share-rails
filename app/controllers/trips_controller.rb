class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])

      if @passenger.nil?
        head :not_found
        return
      else
        @trips = @passenger.trips
      end

    elsif params[:driver_id]
      @driver = Driver.find_by(id: params[:driver_id])

      if @driver.nil?
        head :not_found
      else
        @trips = @driver.trips
      end

    else
      @trips = Trip.all
    end

  end

  def new
    driver = Driver.find_available_driver

    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])

      if @passenger.nil?
        head :not_found
        return
      else
        @trip = @passenger.trips.new()
        @trip.driver = driver
        @trip.set_date
      end

    else
      @trip = Trip.new()
      @trip.driver = driver
      @trip.set_date
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.set_cost

    if @trip.save
      # Set driver availability to false once trip is created
      driver = @trip.driver
      driver.toggle_status

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

  def complete
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
    else
      driver = @trip.driver
      driver.toggle_status

      redirect_to trip_path(@trip)
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
