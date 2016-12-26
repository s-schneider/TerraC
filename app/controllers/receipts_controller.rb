class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # before_filter :init_share_producer_articles

  # GET /receipts
  # GET /receipts.json
  
  def index
    #Checks for the current user
    @user = User.find(session[:user_id]).id

    # First thing to do is: Just show receipts for the current user
    if params[:search]
      @receipts = Receipt.where(user_id: @user).search(params[:search]).order("created_at DESC")
    elsif params[:type]
      @receipts = Receipt.where(user_id: @user).filter(params.slice(:type))
    elsif params[:state]
      @receipts = Receipt.where(user_id: @user).filter(params.slice(:state))
    elsif params[:person]
      @receipts = Receipt.where(user_id: @user).filter(params.slice(:person))
    elsif params[:receipt_number]
      @receipts = Receipt.where(user_id: @user).order('receipt_number ASC')
    elsif params[:dateup]
      @receipts = Receipt.where(user_id: @user).order('receipt_date ASC')
    elsif params[:datedown]
      @receipts = Receipt.where(user_id: @user).order('receipt_date DESC')
    else
      @receipts = Receipt.where(user_id: @user).order('created_at DESC')
    end

    if @user == 1
        if params[:search]
          @receipts = Receipt.search(params[:search]).order("created_at DESC")
        elsif params[:type]
          @receipts = Receipt.filter(params.slice(:type))
        elsif params[:state]
          @receipts = Receipt.filter(params.slice(:state))
        elsif params[:person]
          @receipts = Receipt.filter(params.slice(:person))
        elsif params[:receipt_number]
          @receipts = Receipt.order('receipt_number ASC')
        elsif params[:dateup]
          @receipts = Receipt.order('receipt_date ASC')
        elsif params[:datedown]
          @receipts = Receipt.order('receipt_date DESC')
        else
          @receipts = Receipt.order('created_at DESC')
        end
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @user = User.find(session[:user_id]).id
    respond_to do |format|
      format.html do
        if params[:id]
          @receipts = Receipt.find(params[:id])
        end
      end
      format.pdf do
        if @receipt.supplier_id
          @supplier = Supplier.find(@receipt.supplier_id).name
        else
          @supplier = @receipt.producer
        end
        pdf = ReportPdf.new(@receipt, @supplier) # here it takes the Model we created
        send_data pdf.render, filename: "report.pdf", # and renders it
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
    if params[:format]
      @customer = Customer.find(params[:format])
    end
  end

  # GET /receipts/1/edit
  def edit
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Vorgang wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @receipt }
        @receipt.user_id = User.find(session[:user_id]).id

        if @receipt.user_id == 4
          @aeg = find_aeg
          @receipt.receipt_number = "B-" + @aeg
        elsif @receipt.user_id == 3
          @aeg = find_aeg
          @receipt.receipt_number = "H-" + @aeg
        elsif @receipt.user_id == 2
          @aeg = find_aeg
          @receipt.receipt_number = "A-" + @aeg
        end

        @receipt.producer = Supplier.find(@receipt.supplier_id).name
        @receipt.save

        # If not existent Supplier will be created, according to Receipt
        # if not Supplier.where(name: @receipt.producer)[0]
        #   @supplier = Supplier.new(name: @receipt.producer)
        #   @supplier.save
        # end
       
        if not Article.where(article_name: @receipt.article)[0]
          @article = Article.new(article_name: @receipt.article, article_producer: @receipt.producer)
          @article.save
        end

      else
        format.html { render :new }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Vorgang wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Vorgang wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end


  def find_aeg
    @receipts = Receipt.all
    @aeg = 0

    @receipts.each do |receipt|

      @number = receipt.receipt_number.to_s.split("-")[1].to_i
      if @number > @aeg
        @aeg = @number
      end

    end
        @aeg = @aeg + 1
    return @aeg.to_s
  end

  # def init_share_producer_articles
  #   params[:shared_param__] ||= [ @receipt.producer, @receipt.article, @receipt.article_size, @receipt_article_color ]
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params.require(:receipt).permit(:receipt_number, :receipt_person, :receipt_date, :receipt_notes, :producer, :article, :article_color, :article_size, :customer_id, :receipt_type, :order_date, :order_receiving, :purchase_date, :receipt_true, :article_flaw, :customer_notice, :article_quantity, :user_id, :status, :supplier_id)
    end
end
