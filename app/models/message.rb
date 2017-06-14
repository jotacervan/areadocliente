class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subject, type: String
  field :description, type: String

  has_many :pictures
  belongs_to :conversation
  belongs_to :user

end
