class Backlog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String

  belongs_to :user
end
