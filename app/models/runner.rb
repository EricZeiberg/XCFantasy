class Runner
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String, :default => ""
  field :isFrosh, :type => Boolean, :default => false

  has_many :results
  has_and_belongs_to_many :meets
end
