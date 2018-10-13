class EventsController < ApplicationController
  def index
    @event = Event.new
    @types = ['Pizza', 'Wings', 'Sandwiches', 'Burritos', 'Other']
    @options = ['Yes', 'No']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
    @events = query_events(params)
    static_address_parts = ", Gainesville, FL 32611 US"

    @markers = []
    @events.each do |event| 
      address = event.address_line_one + static_address_parts
      event_json = event.to_json

      event_json.split('}').first + ", \"coordinates\":\"#{Geocoder.search(address).first.coordinates}\"}"
      @markers << event_json
    end
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

  def query_events(params)
    Event.where('date >= ?', Date.today)
  end
end
