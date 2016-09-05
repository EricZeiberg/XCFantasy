class Meet
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, :type => String, :default => ""
  field :date, :type => String, :default => ""
  field :distance, :type => String, :default => ""
  field :isRun, :type => Boolean, :default => false
  field :isLocked, :type => Boolean, :default => false

  has_many :results
  has_and_belongs_to_many :runners

end
