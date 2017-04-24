class Core
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  belongs_to :client
  has_many :stages, dependent: :destroy
end
