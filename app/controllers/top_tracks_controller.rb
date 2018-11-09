require 'rspotify'

class TopTracksController < ApplicationController
  #this is calling a function stablished before
  before_action :set_top_track, only: [:show, :edit, :update, :destroy]

  ##Notes
  #   constraints - track_name, :album_name, :personal_ranking
  #   
  #

  # GET /top_tracks
  # GET /top_tracks.json
  def index
    #this is getting all the top tracks, 
    @top_tracks = TopTrack.all
  end

  ## This is been affected by before_action
  # GET /top_tracks/1
  # GET /top_tracks/1.json
  def show
    # Here I'm making this call
    # This is calling to see the top track of a certain artist, what else could it show
    # the other top tracks
    # This is getting the information of an specific 
    @top_track = RSpotify::Track.search(':id')
    respond_to do |format|
      if @top_track.show
        format.html { redirect_to @top_track, notice: 'Top track was successfully found and retrieved.' }
        format.json { render :show, status: :get, location: @top_track }
      else
        format.html { render :show }
        format.json { render json: @top_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /top_tracks/new
  def new
    @top_track = TopTrack.new
  end

  ## This is been affected by before_action
  # GET /top_tracks/1/edit
  def edit
  end

  # POST /top_tracks
  # POST /top_tracks.json
  def create
    @top_track = TopTrack.new(top_track_params)

    respond_to do |format|
      if @top_track.save
        format.html { redirect_to @top_track, notice: 'Top track was successfully created.' }
        format.json { render :show, status: :created, location: @top_track }
      else
        format.html { render :new }
        format.json { render json: @top_track.errors, status: :unprocessable_entity }
      end
    end
  end

  ## This is been affected by before_action
  # PATCH/PUT /top_tracks/1
  # PATCH/PUT /top_tracks/1.json
  def update
    respond_to do |format|
      if @top_track.update(top_track_params)
        format.html { redirect_to @top_track, notice: 'Top track was successfully updated.' }
        format.json { render :show, status: :ok, location: @top_track }
      else
        format.html { render :edit }
        format.json { render json: @top_track.errors, status: :unprocessable_entity }
      end
    end
  end

  ## This is been affected by before_action
  # DELETE /top_tracks/1
  # DELETE /top_tracks/1.json
  def destroy
    @top_track.destroy
    respond_to do |format|
      format.html { redirect_to top_tracks_url, notice: 'Top track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_top_track
      @top_track = TopTrack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def top_track_params
      params.require(:top_track).permit(:track_name, :album_name, :personal_ranking)
    end
end
