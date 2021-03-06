class TopicsController < ApplicationController
  load_and_authorize_resource :family
  load_and_authorize_resource :topic, :through => :family, :shallow => true
  def new
  end

  def create
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to @family
    else
      flash[:error] = "Something went wrong"
    end
  end

  def index
    @topics = Topic.includes(:quizzes).all
    @quiz = Quiz.new
  end

  def show
  end

  def edit
  end

  def update
    if @topic.update_attributes(params[:topic])
      redirect_to topics_path
    else
      flash[:error] = "Something went wrong"
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path    
  end

  def admin_update
    @topic = Topic.find(params[:id])
  end
end
