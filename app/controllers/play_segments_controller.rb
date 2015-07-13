class PlaySegmentsController < ApplicationController
  before_action :authenticate_app

  # GET /play_segments
  # GET /play_segments.json
  def index
    @play_segments = PlaySegment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @play_segments }
    end
  end
end
