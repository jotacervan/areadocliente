class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :icon, type: String
  field :link, type: String
  
  belongs_to :user
end