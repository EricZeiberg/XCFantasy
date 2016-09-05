class Prediction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :min, :type => Integer, :default => 0
  field :sec, :type => Integer, :default => 0
  field :runner_id
  field :points, :type => Integer, :default => 0

  belongs_to :meet
  belongs_to :user

end
