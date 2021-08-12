class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
    # Если удачно, отправляем пользователя на главную с помощью метода redirect_to
    # с сообщением
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
    # Если не удалось по какой-то причине сохранить пользователя, то используем метод render (не redirect!),
    # который заново рисует шаблон, и название шаблона
      render 'new'
    end
  end

  def edit
  end

  def update
  # Получаем параметры нового (обновленного) пользователя с помощью метода user_params
  # пытаемся обновить юзера
    if @user.update(user_params)
    # Если получилось, отправляем пользователя на его страницу с сообщением
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
    # Если не получилось, как и в create, рисуем страницу редактирования
    # пользователя со списком ошибок
      render 'edit'
  end
end


  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build
  end

  private

  def load_user
    # защищаем от повторной инициализации с помощью ||=
    @user ||= User.find params[:id]
  end

  def authorize_user
    reject_user unless @user == current_user
  end

    def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                               :name, :username, :avatar_url)
  end
end