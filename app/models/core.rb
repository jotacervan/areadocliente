class Core
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :status, type: Integer, default: 0
  
  belongs_to :customer
  has_many :stages, dependent: :destroy
end
