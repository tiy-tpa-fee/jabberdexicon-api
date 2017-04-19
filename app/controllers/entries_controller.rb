class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update, :destroy]

  # GET /entries
  def index
    scope = params[:q].blank? ? current_user.entries.all : current_user.entries.basic_search(params[:q])
    @entries = scope.order(:term)
  end

  # GET /entries/1
  def show
  end

  # POST /entries
  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      render :show, status: :created, location: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      render :show
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = current_user.entries.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:term, :definition)
    end
end
