class Stage
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :status, type: Integer, default: 0
  
  belongs_to :core
  has_many :hops, dependent: :destroy

  after_update :update_core_status
  

  def update_core_status


  	if self.core.stages.count > 0
      total = 0
      self.core.stages.each do |h|
        total += h.status
      end
      percentil = total / self.core.stages.count
    else
      percentil = 0
    end

    self.core.update(:status => percentil)

  end


end
