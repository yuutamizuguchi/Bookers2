class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_current_user_book?, only: [:edit, :update]
  def index
      @book = Book.new
      @user = current_user
      @books = Book.all

  end

  def show
      @book = Book.find(params[:id])
      @user = @book.user

  end

  def edit

      @book = Book.find(params[:id])

  end

  def create
      @user = current_user
      @book = Book.new(book_params)
      @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else
       flash[:notice] = "error"
       render :edit
    end
  end

  private
   def book_params
      params.require(:book).permit(:title, :body)
   end

   def check_current_user_book?
       book = Book.find(params[:id])
       unless current_user.id == book.user_id
         redirect_to books_path
       end
   end
end
