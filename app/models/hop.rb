class Hop
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :status, type: Integer, default: 0
  field :recursive, type: Mongoid::Boolean
  field :next_stage, type: String

  belongs_to :stage
end