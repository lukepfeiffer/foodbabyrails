class EventsController < ApplicationController
  def index
    @event = Event.new
    @types = ['Other', 'Pizza', 'Wings', 'Sandwiches', 'Burritos']
    @options = ['Yes', 'No']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
    @events = query_events(params)
  end

  def create
    event = Event.new(event_params)
    if event.save
      flash[:success] = "Created event!"
    else
      flash[:danger] = "Event was not created...."
    end
    redirect_to events_path
  end

  def search
    redirect_to root_path(
      food: params[:food], 
      restrictions: params[:restrictions], 
      date: params[:date], 
      time: params[:time]
    )
  end

  private
  def event_params
    params.require(:event).permit(
      :org_name,
      :address_line_one,
      :room_number,
      :building_name,
      :food_type,
      :vegan,
      :vegetarian,
      :date,
      :time
    )
  end

  def query_events(params)
    events = Event.where('date >= ?', Date.today)
    if params[:food].present? && params[:food] != 'Other'
      events = events.where(food_type: params[:food])
    end
    if params[:restrictions] == 'Vegetarian'
      events = events.where(vegetarian: true)
    end
    if params[:restrictions] == 'Vegan'
      events = events.where(vegan: true)
    end

    if params[:date].present?
      date = params[:date]
      events = events.where('date >= ?', date)
    end
    if params[:time].present?
      events = events.where('time >= ?', params[:time])
    end

    events
  end
end
