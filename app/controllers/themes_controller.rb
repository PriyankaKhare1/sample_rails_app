class ThemesController < ApplicationController
  def update
    new_theme = params[:theme] == "dark" ? "dark" : "light"
    if logged_in?
      current_user.update_attribute(:theme, new_theme)
    end
    cookies[:theme] = { value: new_theme, expires: 1.year.from_now }
    respond_to do |format|
      format.js
      format.html { redirect_back(fallback_location: root_url) }
    end
  end
end
