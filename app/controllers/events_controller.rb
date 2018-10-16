#Code for controller of events

#Outlines index for the rest of the controller.
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
    if event.address_line_one.present?
      address =  event.address_line_one + ", Gainesville, FL 32611"
      coor = Geocoder.search(address).first.coordinates
      lat = coor[0]
      long = coor[1]
      event.long = long
      event.lat = lat
    end
#Saves events and creates success statements or error messages
#based on outcome.
    if event.save
      flash[:success] = "Created event!"
    else
      flash[:danger] = "Event was not created...."
    end
    redirect_to events_path
  end

#This redirects requests and parameters to the correct root path
  def search
    redirect_to root_path(
      food: params[:food], 
      restrictions: params[:restrictions], 
      date: params[:date], 
      time: params[:time]
    )
  end

#This creates a level of security to privatize data
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

#This places restrictions on the parameters of a given event
  def query_events(params)
    events = Event.where('date >= ?', Date.today)
    #allows for filtering of events based off of a given set of parameters
    if params[:food].present? && params[:food] != 'Other'
      events = events.where(food_type: params[:food])
    end
    #allows for the selection of vegetarian options
    if params[:restrictions] == 'Vegetarian'
      events = events.where(vegetarian: true)
    end
    #allows for selection of vegan options
    if params[:restrictions] == 'Vegan'
      events = events.where(vegan: true)
    end

#Allows the input and output parameters like time and date.
    if params[:date].present?
      date = params[:date]
      #allows you to select the dates
      events = events.where('date >= ?', date)
    end
    if params[:time].present?
    	#allows you to select the times
      events = events.where('time >= ?', params[:time])
    end

    events
  end
end
