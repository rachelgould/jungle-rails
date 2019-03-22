class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @line_items = @order.line_items
    @order_table_data = retrieve_products(@line_items)
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      @order_table_data = retrieve_products_basic_info(order.line_items)
      UserReceipt.welcome_email(order.email, order, @order_table_data).deliver_later
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Your Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

  def retrieve_products(items)
    order_products = []
    items.each do |item|
      product = Product.find(item[:product_id])
      obj = { 
        img: product.image.tiny, 
        name: product.name,
        description: product.description,
        quantity: item.quantity,
        line_total: item.total_price_cents / 100
      }
      order_products.push obj
    end
    return order_products
  end

  def retrieve_products_basic_info(items)
    order_products = []
    items.each do |item|
      product = Product.find(item[:product_id])
      obj = { 
        name: product.name,
        quantity: item.quantity,
        line_total: item.total_price_cents / 100
      }
      order_products.push obj
    end
    return order_products
  end

end
