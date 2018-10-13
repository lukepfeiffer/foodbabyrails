class EventsController < ApplicationController
  def index
    @event = Event.new
    @types = ['pizza', 'wings', 'sandwiches', 'burritos', 'other']
    @options = ['Yes', 'No']
    @restrictions = ['None', 'Vegetarian', 'Vegan']
  end

  def search
    redirect_to :root
  end
end
