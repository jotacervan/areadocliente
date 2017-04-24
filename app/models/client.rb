class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :phone, type: String
  field :contract, type: String
  field :zip, type: String
  field :street, type: String
  field :number, type: String
  field :complement, type: String
  field :neighborhood, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  
  has_many :users, dependent: :destroy
  has_many :cores, dependent: :destroy
end
