class RoomsController < ApplicationController
  before_action :set_room, except: [:index,:new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised,  only: [:listing, :pricing, :description, :photo_upload, 
                                  :amenities, :location, :update]

  def index
    #room object associated with "a current_user"
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
    @photos = @room.photos
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong!"
      render :new
    end
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @room.photos
  end

  def amenities
  end

  def location
  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Saved"
    else
      flash[:alert] = "Something went wrong"
    end
      redirect_back(fallback_location: request.referer) 
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, 
              :bath_room, :listing_name, :summary, :address, :is_tv, :is_air,
              :is_heating, :is_kitchen, :is_internet, :pricing, :active ) 
  end

  def is_authorised
    redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
  end
end
