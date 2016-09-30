require 'bcrypt'
require 'httparty'

class User < ActiveRecord::Base
  has_many :instruments_users
  has_many :genres_users
  has_many :genres, through: :genres_users
  has_many :instruments, through: :instruments_users

  validates :first_name, :last_name, :zip_code, presence: true
  validates :email, presence: true, uniqueness: true
  validate :email_format

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, pw)
     user = self.find_by(email: email)
    return user if user && user.password == pw
    nil
  end

  def city_state
    response = HTTParty.get("https://www.zipcodeapi.com/rest/#{ENV["ZIP_CODE_KEY"]}/info.json/#{self.zip_code}/degrees")
    data = JSON.parse(response)
    # data = JSON.parse(open("https://www.zipcodeapi.com/rest/#{ENV["ZIP_CODE_KEY"]}/info.json/#{self.zip_code}/degrees").read)
    zipdata = {city: data["city"], state: data["state"]}
    self.city = zipdata[:city]
    self.state = zipdata[:state]
  end

  private
  def email_format
    unless email.match /\w+@\w+.\w+/
      errors.add(:email, "must be a valid email address")
    end
  end
end
