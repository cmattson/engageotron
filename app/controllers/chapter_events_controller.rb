class ChapterEventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_chapter_event, only: [:show, :edit, :update, :destroy]

  # GET /chapter_events
  # GET /chapter_events.json
  def index
    @chapter_events = ChapterEvent.all
  end

  # GET /chapter_events/1
  # GET /chapter_events/1.json
  def show
  end

  # GET /chapter_events/new
  def new
    @chapter_event = ChapterEvent.new
  end

  # GET /chapter_events/1/edit
  def edit
  end

  # POST /chapter_events
  # POST /chapter_events.json
  def create
    @chapter_event = ChapterEvent.new(chapter_event_params)

    respond_to do |format|
      if @chapter_event.save
        format.html { redirect_to @chapter_event, notice: 'Chapter event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chapter_event }
      else
        format.html { render action: 'new' }
        format.json { render json: @chapter_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapter_events/1
  # PATCH/PUT /chapter_events/1.json
  def update
    respond_to do |format|
      if @chapter_event.update(chapter_event_params)
        format.html { redirect_to @chapter_event, notice: 'Chapter event was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @chapter_event }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapter_events/1
  # DELETE /chapter_events/1.json
  def destroy
    @chapter_event.destroy
    respond_to do |format|
      format.html { redirect_to chapter_events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter_event
      @chapter_event = ChapterEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_event_params
      params.require(:chapter_event).permit(:name, :date)
    end
end
