class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /suppliers
  # GET /suppliers.json
  
  def index

    @user = User.find(session[:user_id]).id


    if params[:search]
      @suppliers = Supplier.search(params[:search]).order("created_at DESC")
    elsif params[:from_r]
      redirect_to Supplier.find(params[:from_r])
    else
      @suppliers = Supplier.all.order('name ASC')
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    respond_to do |format|
      format.html do
        if params[:id]
          @supplier = Supplier.find(params[:id])
        else
        end
      end
    end
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    @dubl = Supplier.find_by(name: @supplier.name)

    respond_to do |format|
      if @dubl
        format.html { redirect_to @dubl, notice: 'Lieferant existiert bereits!' }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }   
      else
        if @supplier.save
          format.html { redirect_to @supplier, notice: 'Lieferant erfolgreich erstellt.' }
          format.json { render :show, status: :created, location: @supplier }
        else
          format.html { render :new }
          format.json { render json: @supplier.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'Lieferant erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Lieferant erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :delilver_cond, :payment_cond, :reorder_cond, :preorder_cond, :order_id, :internal_id, :external_id, :service_id, :preorder_date, :website, :b2b, :repair_condition)
    end
end
