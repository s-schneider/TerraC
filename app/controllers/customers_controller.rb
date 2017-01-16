class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /customers
  # GET /customers.json

  def index

    @user = User.find(session[:user_id]).id
    
    if params[:search]
      @customers = Customer.search(params[:search]).order("created_at DESC")
    elsif params[:customer]
      @customers = Customer.where(id: params[:id])
    elsif params[:cgroup]
      @customers = Customer.filter(params.slice(:cgroup))
    else
      @customers = Customer.all.order('customer_surname ASC')
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    if current_user.nil?
      redirect_to '/'
    end
  end

  # GET /customers/new
  def new
    if params[:supplier_id]
      @customer = Customer.new
      @supplier_id = params[:supplier_id]
    else
      @customer = Customer.new
    end
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    @existing_customers = Customer.where(customer_surname: @customer.customer_surname)

    @err = 0
    @existing_customers.each do |c|
      if c.customer_surname == @customer.customer_surname && c.customer_name == @customer.customer_name
        @dubl = c
        @err += 1
      end
    end

    respond_to do |format|
      if @err == 0
        if @customer.save
          format.html { redirect_to @customer, notice: 'Person wurde erfolgreich erstellt.' }
          format.json { render :show, status: :created, location: @customer }
        else
          format.html { render :new }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @dubl, notice: 'Person existiert bereits!' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end



  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Personendaten wurden erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Person wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:customer_name, :customer_street, :customer_town, :customer_phone, :customer_fax, :customer_email, :customer_notes, :customer_surname, :customer_mobile, :customer_club, :customer_newsletter, :supplier_id, :customer_group)
    end
end
