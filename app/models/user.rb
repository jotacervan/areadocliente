class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :rg, type: String
  field :cpf, type: String
  field :password_digest, type: String
  field :picture_file_name, type: String
  field :picture_file_size, type: Integer
  field :picture_content_type, type: String
  field :login, type: String
  field :user_type, type: String

  belongs_to :client
end
