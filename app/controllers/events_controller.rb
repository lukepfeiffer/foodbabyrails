class EventsController < ApplicationController
  def index
    @restrictions = ['None', 'Vegetarian', 'Vegan']
    @events = query_events(params)
    @types = Event.distinct.pluck(:food_type)
    if @types.empty?
      @types = ['Other', 'Pizza', 'Wings']
    end
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
    if !current_user.present?
      flash[:danger] = "You were not signed in."
      redirect_to root_path
    end
    event = Event.new(event_params)
    event.user_id = current_user.id

    if event.save
      flash[:success] = "Created event!"
      redirect_to root_path
    else
      error_messages = ""

      event.errors.each do |attribute, message|
	if attribute.to_s.include?("_")
	  updated_name = attribute.to_s.split("_").join(" ").capitalize
          error_messages += "#{updated_name}: #{message}, "
        else
          error_messages += "#{attribute.capitalize}: #{message}, "
        end
      end

      flash[:danger] = error_messages
      redirect_to new_event_path
    end
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
      :time,
      :lat,
      :long
    )
  end

#This places restrictions on the parameters of a given event
  def query_events(params)
    events = Event.all

    #Allows the input and output parameters like time and date.
    if params[:date].present?
      date = params[:date].to_date
      events = events.where('date >= ?', date)
    else 
      events = Event.where('date >= ?', Date.today)
    end

    if params[:food].present?
      if params[:food] != 'Any'
        events = events.where(food_type: params[:food])
      end
    end

    #allows for the selection of vegetarian options
    if params[:restrictions] == 'Vegetarian'
      events = events.where(vegetarian: true)
    end
    #allows for selection of vegan options
    if params[:restrictions] == 'Vegan'
      events = events.where(vegan: true)
    end

    if params[:time].present?
    	#allows you to select the times
      events = events.where('time >= ?', params[:time])
    end

    events
  end
end
