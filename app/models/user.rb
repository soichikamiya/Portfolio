class User < ActiveRecord::Base
  validates :name, {presence: true, uniqueness: true, length: { in: 3..30 } }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
  validates :password, {presence: true, length: {minimum: 3}}
end
