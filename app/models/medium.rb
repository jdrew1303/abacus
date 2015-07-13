class Medium < ActiveRecord::Base
  has_many :events
  belongs_to :app

  def did_user_watch_whole_video?(user_id)
    percentage_watched_by_user(user_id) > 99.0
  end

  def percentage_watched_by_user(user_id)
    "SELECT sum(
      
    ) "
  end

  def percentage_of_users_watched

  end

  def percentage

  end
end
