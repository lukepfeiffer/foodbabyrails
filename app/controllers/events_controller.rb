#Code for controller of events

#Outlines index for the rest of the controller.
class EventsController < ApplicationController
  def index
    @types = ['Other', 'Pizza', 'Wings', 'Sandwiches', 'Burritos']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
    @events = query_events(params)
  end

  def render_details
    event = Event.find(params[:event_id])
    render partial: "details", locals: {event: event}
  end

  def new
    @types = ['Other', 'Pizza', 'Wings', 'Sandwiches', 'Burritos']
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    if !current_user.present?
      flash[:danger] = "You were not signed in."
      redirect_to root_path
    end

    if event.address_line_one.present?
      address =  event.address_line_one + ", Gainesville, FL 32611"
      coor = Geocoder.search(address).first.coordinates
      lat = coor[0]
      long = coor[1]
      event.long = long
      event.lat = lat
    end

    event.user_id = current_user.id

    if event.save
      flash[:success] = "Created event!"
    else
      flash[:danger] = "Event was not created...."
    end
    redirect_to events_path
  end

  def edit
    @types = ['Other', 'Pizza', 'Wings', 'Sandwiches', 'Burritos']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
    @event = Event.find(params[:id])
    if !current_user.present? || current_user.id != @event.user_id.to_i
      flash[:danger] = "You weren't signed in."
      redirect_to root_path
    end
  end

  def update
    event = Event.find(params[:id])
    if !current_user.present?
      flash[:danger] = "You were not signed in."
      redirect_to root_path
    end

    event.update(event_params)
    lat = event.lat
    long = event.long
    if params[:event][:address_line_one].present?
      address = params[:event][:address_line_one] + ", Gainesville, FL 32611"
      coor = Geocoder.search(address)
      if coor.present?
        coor = coor.first.coordinates
        lat = coor[0]
        long = coor[1]
      end
      event.update(lat: lat, long: long)
    end

    flash[:success] = "Update event!"
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

  def destroy
    event = Event.find(params[:id])
    event.delete
    flash[:success] = "Deleted Event!"
    redirect_to root_path
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

#This places restrictions on the parameters of a given event
  def query_events(params)
    events = Event.all
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
      date = params[:date].to_date
      events = events.where('date >= ?', date)
    else 
      events = Event.where('date >= ?', Date.today)
    end

    if params[:time].present?
    	#allows you to select the times
      events = events.where('time >= ?', params[:time])
    end

    events
  end
end
