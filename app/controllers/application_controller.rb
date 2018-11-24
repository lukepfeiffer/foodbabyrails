class ApplicationController < ActionController::Base
  before_action :global_variables
  authem_for :user

  def global_variables
    controller = params[:controller]
    action = params[:action]
    @is_active_about = ""
    @is_active_contact = ""
    @is_active_home = ""
    @is_active_my_events = ""
    @is_active_sign_in = ""

    if controller == "events" && action == "index"
      @is_active_home = " active"
    elsif controller == "pages" && action == "about"
      @is_active_about = " active"
    elsif controller == "pages" && action == "contact"
      @is_active_contact = " active"
    elsif controller == "users" && action == "show"
      @is_active_my_events = " active"
    elsif controller == "pages" && action == "sign_in"
      @is_active_sign_in = " active"
    end
  end
end
