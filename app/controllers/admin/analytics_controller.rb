class Admin::AnalyticsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @top_users = User.left_joins(:microposts)
                     .group(:id)
                     .select("users.*, COUNT(microposts.id) AS microposts_count")
                     .order("microposts_count DESC")
                     .limit(10)
    @recent_posts = Micropost.includes(:user).order(created_at: :desc).limit(10)
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
