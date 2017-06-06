class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :phone, type: String
  field :contract, type: String
  field :cnpj, type: String
  field :zip, type: String
  field :street, type: String
  field :number, type: String
  field :complement, type: String
  field :neighborhood, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :has_maintenance, type: Integer, default: 0
  field :total_maintenance, type: Integer, default: 0
  field :used_maintenance, type: Integer, default: 0
  

  has_many :users, dependent: :destroy
  has_many :cores, dependent: :destroy
end
