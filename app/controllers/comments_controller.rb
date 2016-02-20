class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_book
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @book.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        NotificationJob.set(wait: 1.minute).perform_later(@book.id, @comment.id)
       # NotificationMailer.add_comment_notification(@book, @comment).deliver
        format.html { redirect_to book_path(@book) }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
 
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to book_comments_url(@book), notice: 'Comment was successfully destroyed.' }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:book_id, :user_id, :description)
    end
end
