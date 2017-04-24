class Stage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :core
  has_many :hops, dependent: :destroy
end
