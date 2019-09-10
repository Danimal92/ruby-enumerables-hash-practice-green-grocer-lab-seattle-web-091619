def consolidate_cart(cart)
  result = {}
  cart.map{|hashes| 
    hashes.map{|key,value|
    if result.has_key?(key)
      result[key][:count] += 1
         
    else
      result[key] = value
      result[key][:count] = 1 
    end
  }} 
<<<<<<< HEAD
  cart = result
  return cart
=======
  return result 
>>>>>>> dd69eddda61f5a04decb939459f0d8c8db17e966
end

  
  
<<<<<<< HEAD
def apply_coupons(cart, coupons) 
  
  coupons.each do |coupon| 
    coupon.each do |k,v| 
      name = coupon[:item] 
    
      if cart[name] && cart[name][:count] >= coupon[:num] 
        if cart["#{name} W/COUPON"] 
          
          
          cart["#{name} W/COUPON"][:price] = (coupon[:cost] / ((cart[name][:count]) - ((cart[name][:count]) % (coupon[:num]))))
        else 

          cart["#{name} W/COUPON"] = {:price => (coupon[:cost] / ((cart[name][:count]) - ((cart[name][:count]) % (coupon[:num])))), 
          :clearance => cart[name][:clearance], :count => (cart[name][:count]) - ((cart[name][:count]) % (coupon[:num]))} 
        end 
  
      cart[name][:count] -= coupon[:num] 
    end 
  end 
end 
 return cart 
end
=======

def apply_coupons(cart, coupons)

  discounted_item = {}
  cart.each_key{|k|
    coupons.map{|coupon|
      key = "#{coupon[:item]} W/COUPON"
      if k == coupon[:item] and coupon[:num] <= cart[k][:count]       
        
                
        discounted_item[key] = {:price => (coupon[:cost] / ((cart[k][:count]) - ((cart[k][:count]) % (coupon[:num])))) , :clearance => true , :count => (cart[k][:count]) - ((cart[k][:count]) % (coupon[:num]))}        
        cart[k][:clearance] = true
        cart[k][:count] = (cart[k][:count]) % (coupon[:num])
        result = cart.clone
        result.merge!(discounted_item)

      elsif k == coupon[:item] and coupon[:num] > cart[k][:count]
        discounted_item = {}
        key = "#{k} W/COUPON"
        discounted_item[key][:price] = coupon[:cost] / ((cart[k][:count]) - ((cart[k][:count]) % (coupon[:num])))     
        discounted_item[key][:clearance] = false
        discounted_item[key][:count] = 0
        cart[k][:clearance] = false        
        result = cart.clone
        result.merge!(discounted_item)
      
      elsif discounted_item.has_key?(key) and coupon[:num] <= result[k][:count]
        discounted_item[key][:count] += coupon[:count]
        result[k][:count] = result[k][:count] - coupon[:count]
        result[k][:price] = (coupon[:cost] / ((result[k][:count])))

      end     
      return result
    }
  }
    
  end

>>>>>>> dd69eddda61f5a04decb939459f0d8c8db17e966

def apply_clearance(cart)
  cart.each do |k,v|
  if cart[k][:clearance]
    cart[k][:price] = (cart[k][:price] * 0.8).round(2)
    end
  end
  return cart
end





def checkout(cart, coupons)
  total = 0
  sum_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(sum_cart, coupons) 
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each do |fruit, value_hash|
    
    total += (value_hash[:price] * value_hash[:count])
  end 

  if total > 100 
    total = (total * 0.9) 
    end
return total
end
