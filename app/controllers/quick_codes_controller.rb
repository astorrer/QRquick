class QuickCodesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_quick_code, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @quick_codes = current_user.quick_codes.all

    respond_to do |format|
      format.html
      # Provide an XLS or CSV list
      format.xls { send_data(@quick_codes.to_xls, :filename => "Codes-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls") }
      format.csv { send_data(@quick_codes.to_csv, :filename => "Codes-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv") }
    end
  end

  def show
    fill = @quick_code.fill[1..-1]
    color = @quick_code.color[1..-1]
    
    respond_to do |format|
      format.html
      # Render the QR Code images
      format.svg  { render :qrcode => @quick_code.content, :level => :h, :unit => @quick_code.unit, :offset => @quick_code.offset, :fill => fill, :color => color }
      format.png  { render :qrcode => @quick_code.content, :level => :h, :unit => @quick_code.unit, :offset => @quick_code.offset, :fill => fill, :color => color }
      format.gif  { render :qrcode => @quick_code.content, :level => :h, :unit => @quick_code.unit, :offset => @quick_code.offset, :fill => fill, :color => color }
      format.jpg  { render :qrcode => @quick_code.content, :level => :h, :unit => @quick_code.unit, :offset => @quick_code.offset, :fill => fill, :color => color }
    end
  end

  def new
    @quick_code = current_user.quick_codes.new
    respond_with(@quick_code)
  end

  def edit
  end

  def create
    @quick_code = current_user.quick_codes.new(quick_code_params)
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
      @quick_code = current_user.quick_codes.find(params[:id])
    end

    def quick_code_params
      params.require(:quick_code).permit(:name, :content, :size, :level, :offset, :unit, :fill, :color)
    end
end
