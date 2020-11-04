class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def create
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)
    #
    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
