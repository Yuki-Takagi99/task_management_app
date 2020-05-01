class TasksController < ApplicationController
  def index
    if params[:search].present?
      if params[:title].present? && params[:status].present? #タイトルとステータス両方で検索する場合 #タイトルはあいまい検索
        @tasks = Task.search_title(params[:title]).search_status(params[:status])
      elsif params[:title].present? #タイトルのみで検索する場合
        @tasks = Task.search_title(params[:title])
      else params[:status].present? #ステータスのみで検索する場合
        @tasks = Task.search_status(params[:status])
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(end_deadline: :asc) #終了期限の昇順に表示
    else
      @tasks = Task.all.order(created_at: :desc) #作成日時の降順に表示
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
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.title}」を登録しました。"
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
    redirect_to tasks_url, notice: "タスク「#{task.title}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.title}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :end_deadline, :status, :priority)
  end
end
