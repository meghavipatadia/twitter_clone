class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :confirmable
  # :timeoutable, :timeout_in => 10.minutes , used if user want ro put session of 10 min
 devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :timeout_in => 10.minutes

   
 has_many :microposts, dependent: :destroy
 has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
 has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent:   :destroy
 has_many :following, through: :active_relationships,  source: :followed
 has_many :followers, through: :passive_relationships, source: :follower
 

def feed
	microposts
end     

# Follows a user.
def follow(other_user)
  following << other_user
end

# Unfollows a user.
def unfollow(other_user)
  following.delete(other_user)
end

# Returns true if the current user is following the other user.
def following?(other_user)
  following.include?(other_user)
end

  def name
     read_attribute(:name).try(:titleize)
  end
end
