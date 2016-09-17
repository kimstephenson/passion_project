require 'bcrypt'

class User < ActiveRecord::Base
  has_many :instruments_users
  has_many :genres_users
  has_many :genres, through: :genres_users
  has_many :instruments, through: :instruments_users

  validates :email, uniqueness: true
  validate :email_format

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
     user = self.find_by(email: email)
    return user if user && user.password == password
    nil
  end

  private
  def email_format
    unless email.match /\w+@\w+.\w+/
      errors.add(:email, "must be a valid email address")
    end
  end
end
