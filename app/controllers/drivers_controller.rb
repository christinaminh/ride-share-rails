class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params) #instantiate a new book
    if @driver.save # save returns true if the database insert succeeds
      redirect_to driver_path(@driver.id) # go to the index so we can see the task in the list
    else
    render :new # show the new task form view again
    end
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)
    #
    if @driver.nil?
      head :not_found
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif  @driver.update(driver_params)
      redirect_to driver_path
      return
    else
      render :edit
    end
  end

  def destroy

    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      head :not_found
      return
    end
    @driver.destroy
    redirect_to drivers_path
    return
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
