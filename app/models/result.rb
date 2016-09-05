class Result
  include Mongoid::Document
  include Mongoid::Timestamps


  field :min, :type => Integer, :default => 0
  field :sec, :type => Integer, :default => 0
  
  belongs_to :runner
  belongs_to :meet


end
