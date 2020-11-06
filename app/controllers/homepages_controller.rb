class HomepagesController < ApplicationController

  def index
    @drivers = Driver.all
  end
end
