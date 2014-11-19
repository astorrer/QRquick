class QuickCodesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_quick_code, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @quick_codes = QuickCode.all
    respond_with(@quick_codes)
  end

  def show
    respond_with(@quick_code)
  end

  def new
    @quick_code = QuickCode.new
    respond_with(@quick_code)
  end

  def edit
  end

  def create
    @quick_code = QuickCode.new(quick_code_params)
    flash[:notice] = 'QuickCode was successfully created.' if @quick_code.save
    respond_with(@quick_code)
  end

  def update
    flash[:notice] = 'QuickCode was successfully updated.' if @quick_code.update(quick_code_params)
    respond_with(@quick_code)
  end

  def destroy
    @quick_code.destroy
    respond_with(@quick_code)
  end

  private
    def set_quick_code
      @quick_code = QuickCode.find(params[:id])
    end

    def quick_code_params
      params.require(:quick_code).permit(:name, :content, :size, :level, :offset, :unit, :fill, :color)
    end
end
