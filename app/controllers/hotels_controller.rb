class HotelsController < ApplicationController
  before_action :find_hotel, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:term]
      @hotels = Hotel.search_by_hotel_name(params[:term]).page(params[:page]).per Settings.paginate.hotels
      @keyword = params[:term]
    elsif params[:commit] == "Filter"
      @hotels = Hotel.filter_by_service(params).page(params[:page]).per Settings.paginate.hotels
    else
      @hotels = Hotel.all.page(params[:page]).per Settings.paginate.hotels
    end
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = current_user.hotels.build hotel_params
    if @hotel.save
      flash[:success] = t "create_hotel_success"
      redirect_to @hotel
    else
      render :new
    end
  end

  def show
    if current_user && @hotel.average("quality")
      rate_avg = @hotel.average("quality").avg.round
      @hotel.update_attributes(rate_round: rate_avg)
    end
  end

  def edit; end

  def update
    if @hotel.update_attributes hotel_params
      flash[:success] = t "update_hotel_success"
      redirect_to @hotel
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    flash[:success] = t "delete_hotel_success"
    redirect_to hotels_url
  end

  private

  def hotel_params
    params.require(:hotel).permit :title, :content, :hastags_list
  end

  def correct_user
    if current_user.admin?
      find_hotel
    else
      @hotel = current_user.hotels.find_by id: params[:id]
    end
    redirect_to hotel_hotels_url if @hotel.nil?
  end

  def find_hotel
    @hotel = Hotel.find_by id: params[:id]

    return if @hotel
    flash.now[:danger] = t "cant_find_hotel"
    redirect_to hotels_url
  end
end
