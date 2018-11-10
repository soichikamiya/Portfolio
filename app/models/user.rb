# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  image_name      :string
#  password_digest :string
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :destroy
  
  validates :name, {presence: true, uniqueness: true, length: { in: 3..30 } }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
  validates :password, {length: {minimum: 3}}
  
  def posts
    return Post.where(user_id: self.id).order(created_at: :desc)
  end
  
end
