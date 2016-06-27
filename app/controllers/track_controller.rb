class TrackController < ApplicationController
  def all
    render json: TRACKS.all
  end
end
