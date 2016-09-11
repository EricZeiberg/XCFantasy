class RacesController < ApplicationController
  def index
    @races = Meet.all
  end

  def new
    if current_user.isAdmin? == false
      redirect_to '/'
    end
    @runners = Runner.all
  end

  def create
    meet = Meet.new(:name => params[:name], :date => params[:date], :distance => params[:distance], :runners => Runner.all)
    meet.save!
   render status: 200, json: @controller.to_json

  end

  def run
    @meet = Meet.find(params[:id])
    if @meet.isRun?
      redirect_to '/meets'
    end
  end

  def runUpdate
    meet = Meet.find(params[:id])
    i = 0
    result = Result.new
    while params[i.to_s] != nil
      data = params[i.to_s]
      runner = Runner.where(:name => data["name"]).first
      result = Result.create(:meet => meet, :runner => runner, :min => data[:value].split(":")[0], :sec => data[:value].split(":")[1], :meet => meet)
      if runner == nil
        i+=1
        next
      end
      runner.results << result
      predictions = Prediction.where(:meet => meet, :runner_id => runner.id.to_str)
      predictions.each do |p|
        prediction = p
        score = 200 - ((60 * (result.min - prediction.min).abs) + (result.sec - prediction.sec).abs)
        if score < 1
          score = 0
        end
        prediction.update_attributes(:points => score)
        prediction.save!
      end
      runner.save!
      i +=1
    end

    User.all.each do |u|
      preds = u.predictions.where(:meet => meet)
      if preds.count() == 0
        next
      end
      predCount = 0
      preds.each do |p|
        predCount = predCount + p.points
      end
      score = (predCount / preds.count()) + (preds.count() * 2)
      u.update_attributes(:points => u.points + score)

    end
    meet.update_attributes(:isRun => true, :isLocked => true)
    meet.results << result
    meet.save!

    render status: 200, json: @controller.to_json
  end

  def get
    id = params[:id]
    @meet = Meet.find(id)
    if current_user.nil?
      @predictions = nil
    else
      @prediction = current_user.predictions.where(:meet => @meet)
      @prediction.each do |p|
        if p.nil?
          @min = 0
          @sec = 0
        else
          @min = p.min
          @sec = p.sec
        end
      end
    end
  end

  def update
    meet = Meet.find(params[:id])
    prediction = current_user.predictions.where(:meet => meet, :runner_id => params[:r_id]).first
    if prediction.nil?
      prediction = Prediction.new(:min => params[:min], :sec => params[:sec], :runner_id => params[:r_id], :meet => meet, :user => current_user)
      prediction.save!
      render status: 200, json: @controller.to_json
    else
      prediction.update_attributes(:min => params[:min], :sec => params[:sec])
      prediction.save!
      render status: 200, json: @controller.to_json
    end
  end
end
