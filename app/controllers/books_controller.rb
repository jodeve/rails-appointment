class BooksController < ApplicationController

  # GET /books/new
  def new
    return redirect_to root_path, notice: "Please select a slot to book" if(!params[:datetime])
    @date = DateTime.parse(params[:datetime])
    @book = Book.new
  end

  # POST /books or /books.json
  def create
    date = DateTime.parse(params[:book][:on_at])
    p = book_params
    p[:on_at] = date
    @book = Book.new(p)

    if @book.save
      redirect_to root_path, notice: "Slot booked successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:day, :name, :phone)
    end
end
