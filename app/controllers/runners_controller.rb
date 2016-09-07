class RunnersController < ApplicationController

  def index
    @runners = Runner.all
  end

  def get
    @runner = Runner.find(params[:id])
  end
end
