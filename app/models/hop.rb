class Hop
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name, type: String
  field :status, type: Integer, default: 0
  field :recursive, type: Mongoid::Boolean
  field :next_stage, type: String
  field :approved, type: Mongoid::Boolean, default: false
  field :picture_file_name, type: String
  field :picture_file_size, type: Integer
  field :picture_content_type, type: String
  
  belongs_to :stage

  has_mongoid_attached_file :picture, :styles => { :medium => "320x320>", :thumb => "160x160#" },
                      :path => ':rails_root/public/images/:id-:basename-:style.:extension',
                      :url => '/images/:id-:basename-:style.:extension'
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  after_update :update_stage_status

  def update_stage_status

    if self.stage.hops.count > 0
      total = 0
      self.stage.hops.each do |h|
        total += h.status
      end
      percentil = total / self.stage.hops.count
    else
      percentil = 0
    end

    self.stage.update(:status => percentil)
  end

end