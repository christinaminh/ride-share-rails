class HomepagesController < ApplicationController

  def index
    @trips = Trip.all
    @drivers = Driver.all
    @passengers = Passenger.all
  end
end
