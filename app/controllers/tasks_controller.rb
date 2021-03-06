class TasksController < ApplicationController
  before_action :must_login, only: [:index, :new, :show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      if params[:title].present? && params[:status].present? && params[:label_id].present? #タイトルとステータスとラベルで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_title(params[:title]).search_status(params[:status]).seach_label(labels: { id: params[:label_id] })
      elsif params[:title].present? && params[:status].present? #タイトルとステータスで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_title(params[:title]).search_status(params[:status])
      elsif params[:title].present? && params[:label_id].present? #タイトルとラベルで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_title(params[:title]).seach_label(labels: { id: params[:label_id] })
      elsif params[:status].present? && params[:label_id].present? #ステータスとラベルで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_status(params[:status]).seach_label(labels: { id: params[:label_id] })
      elsif params[:title].present? #タイトルのみで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_title(params[:title])
      elsif params[:status].present? #ステータスのみで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).search_status(params[:status])
      else params[:label_id].present? #ラベルのみで検索する場合
        @tasks = Task.page(params[:page]).where(user_id: current_user.id).seach_label(labels: { id: params[:label_id] })
      end
    elsif params[:sort_expired]
      @tasks = Task.page(params[:page]).where(user_id: current_user.id).order(end_deadline: :asc) #終了期限の昇順に表示
    elsif params[:sort_priority]
      @tasks = Task.page(params[:page]).where(user_id: current_user.id).order(priority: :asc).order(end_deadline: :asc) #優先順位が高いものを終了期限の昇順に表示
    else
      @tasks = Task.page(params[:page]).where(user_id: current_user.id).order(created_at: :desc) #作成日時の降順に表示
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:success] = "タスク「#{@task.title}」を登録しました。"
      redirect_to @task
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    flash[:success] = "タスク「#{task.title}」を更新しました。"
    redirect_to tasks_url
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    if current_user.admin?
      flash[:success] = "タスク「#{task.title}」を削除しました。"
      redirect_to admin_users_path
    else
      flash[:success] = "タスク「#{task.title}」を削除しました。"
      redirect_to tasks_url
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :end_deadline, :status, :priority, { label_ids: [] })
  end
end
