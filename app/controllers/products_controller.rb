class ProductsController < ApplicationController
  def index
    @get_products = Product.all
  end

  def show
   # render :text => params
   @product = Product.find(params[:id])
    @get_comments = @product.comments.all
    @comment = Comment.new
  end

  def new
    @item = Product.new
    @category = Category.all.map { |g| g = [ g.name, g.id ] }
  end

  def create
    @item = Category.find(params[:item][:category_id]).products.new(item_params)
    if @item.save
      flash[:notice] = "Successfully added item to inventory"
      redirect_to('/')
    else
      render('products/new')
    end
  end

  def create_com
    @item = Product.find(params[:product][:id]).comments.new(:comment => params[:com][:comment], :product_id => params[:com][:product_id] )
    if @item.save
      flash[:notice] = "Successfully added item to inventory"
      redirect_to('/products/'+params[:product][:id])
    else
      render('/products/params'+[:product][:id])
    end
  end

  def edit
    @edit = Product.find(params[:id])
    @category = Category.all.map! { |g| g= [ g.name, g.id]}
  end


  def update
    u = Product.find(params[:id])
    u.update_attributes(item_params)
    redirect_to('/')
  end

  def destroy
    @del_item = Product.find(params[:id])
    @del_item.destroy
    redirect_to('/')
  end

  private 
    def item_params
      params.require(:item).permit(:name, :description, :price, :category_id)
    end
end
