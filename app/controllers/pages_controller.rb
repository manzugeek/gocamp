class PagesController < ApplicationController
  def home
    @rooms = Room.all.limit(3)
  end
end
