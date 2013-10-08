class Module
  
  def attribute(params, &block)
  	init = nil
  	if params.is_a? Hash
  		name = params.keys[0]
  		init = params.values[0]
  	else
  		name = params
  	end

  	define_attribute_methods(name, init, &block)

  end

  private 
	def define_attribute_methods(name, init, &block)
		define_method(name) do
			init ||= instance_eval &block if block_given?

			instance_variable_set("@#{name}", init) unless instance_variable_get("@#{name}")
			
			instance_variable_get("@#{name}")
		end
		define_method(name + '=') do |val|
			instance_variable_set("@#{name}", val)
		end
		define_method(name + '?') do
			!!instance_variable_get("@#{name}")
		end
	end  

end