class HotelsController < ActionController::Base
  def index
    if params[:term]
      @hotels = Hotel.search_by_hotel_name(params[:term])
    else
      @hotels = Hotel.all
    end
  end
end
