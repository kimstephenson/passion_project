class User < ActiveRecord::Base
  has_many :instruments_users
  has_many :genres_users
  has_many :genres, through: :genres_users
  has_many :instruments, through: :instruments_users
end
