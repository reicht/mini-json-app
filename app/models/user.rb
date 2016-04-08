class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  def next
    user = User.where("id > #{self.id}").limit(1).first
    if user.nil?
      User.first.id
    else
      user.id
    end
  end

  def prev
    user = User.where("id < #{self.id}").limit(1).order("id DESC").first
    if user.nil?
      User.last.id
    else
      user.id
    end
  end

end
