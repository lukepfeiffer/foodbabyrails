class EventsController < ApplicationController
  def index
    @event = Event.new
    @events = Event.all
    @types = ['Pizza', 'Wings', 'Sandwiches', 'Burritos', 'Other']
    @options = ['Yes', 'No']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
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
    redirect_to :root
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
end
