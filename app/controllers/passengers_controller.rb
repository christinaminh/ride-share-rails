class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :new
      return
    end
  end

  def show
    @passenger = Passenger.find_by(params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(params[:id])

    if @passenger.nil?
      redirect_to passengers_path
      return
    elsif @passenger.update(passenger_params)
      redirect_to passengers_path
      return
    else #if save failed
      redirect_to edit_passenger_path
      return
    end
  end

  def destroy
    @passenger = Passenger.find_by(params[:id])

    if @passenger
      @passenger.destroy
    end

    redirect_to passengers_path
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
