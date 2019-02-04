class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  helper_method :purchase
  helper_method :total_cost
  # GET /carts
  # GET /carts.json
  def index
    @carts = CartItem.where(cart: Cart.last)
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # Purchase all items in the cart
  # Decrement Product quantity by cart_item quantity
  # Destroy cart_items 
  def purchase
    @cart_items = CartItem.where(cart: Cart.last)
    
    @cart_items.each do |cart_item|
      @product = cart_item.product
      if (@product.inventory_count > 0)
        cart_item.product.update(title: @product.title, 
                               description: @product.description,
                               price: @product.price,
                               inventory_count: @product.inventory_count - cart_item.quantity)
        cart_item.destroy
      else
        flash[:notice] = "Item in cart had no inventory left"
        next
      end
    end
    if @cart = Cart.last
      @cart.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Cart was successfully purchased.'}
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to products_url, notice: "A cart must exist for products to be added to" }
        format.json { head :no_content }
      end
    end
    Cart.create()
  end

  def total_cost
    @cart_items = CartItem.where(cart: Cart.last)
    total_price = 0
    @cart_items.each do |cart_item|
      total_price += cart_item.product.price
    end
    total_price
  end
  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id]) || @cart = Cart.create(:cart => params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
end
