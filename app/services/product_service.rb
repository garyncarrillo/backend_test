# app/services/product_service.rb
class ProductService
    def create(product_params)
        product = Product.create(product_params)
    end

    def update_product(params, product_params)
        set_product(params)
        @product.update(product_params)
        @product
    end

    def destroy(params)
        set_product(params)
        @product.destroy
    end
    
    def fetch_all()
        get_products
    end

    def fetch_one(params)
        set_product(params)
    end

    private

    def set_product(params)
        @product = Product.find(params[:id])
    end

    def get_products
        Product.all()
    end
end