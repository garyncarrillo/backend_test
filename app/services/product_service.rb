# app/services/product_service.rb
class ProductService
    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def create(product_params)
        product = @current_user.products.create(product_params)
    end

    def update_product(product_params)
        set_product()
        @product.update(product_params)
        @product
    end

    def destroy()
        set_product()
        @product.destroy
    end
    
    def fetch_all()
        get_products()
    end

    def fetch_one()
        set_product()
    end

    private

    def set_product()
        @product = @current_user.products.find(@params[:id])
    end

    def get_products()
        @current_user.products.all()
    end
end