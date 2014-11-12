class Admin::EventsController < ApplicationController
  include Admin::AdminModule
  before_filter :set_title
  include Devise::Controllers::Helpers

  def set_title
    @page_title = "Events Management"
  end


  def index
    respond_to do |format|
        format.html
        format.json { render json: EventsDatatable.new(view_context) }
    end
  end

  def show
    render :action => "index"
  end

  def new
    @title = "Add Event"
    @event = Event.new
  end

  def edit
    @title = "Edit Event"
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.browser_title = @event.title
    @event.browser_url = transliterate(@event.title)
    if @event.save
      redirect_to(:url => admin_event_path(@event), :notice => 'Create Event Successfully!')
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.browser_title = @event.title
    @event.browser_url = transliterate(@event.title)
  
    if @event.update_attributes(event_params.reject{|k,v| v.blank?})
    
      redirect_to(:url => admin_event_path, :notice => 'Update Event Successfully!')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  
    redirect_to(admin_events_url)
  end

  private

  def event_params
    params.require(:event).permit!
  end
end
