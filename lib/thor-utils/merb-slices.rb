require "thor-utils/merb"

class Thor
  alias_method :__start_environment__, :start_environment
  def start_environment(*args)
    init_slice
    __start_environment__(*args)
  end

  private
  # directly copied z bin/slice
  def init_slice
    require 'merb-core'
    require 'merb-slices'
    __DIR__ = Dir.pwd
    slice_name = File.basename(__DIR__)

    Merb::Config.use { |c|
      c[:framework]           = { :public => [Merb.root / "public", nil] }
      c[:session_store]       = 'none'
      c[:exception_details]   = true
    }

    if File.exists?(slice_file = File.join(__DIR__, 'lib', "#{slice_name}.rb"))
      Merb::BootLoader.before_app_loads do
        $SLICE_MODULE = Merb::Slices.filename2module(slice_file)
        require slice_file
      end
      Merb::BootLoader.after_app_loads do
        # See Merb::Slices::ModuleMixin - $SLICE_MODULE is used as a flag
        Merb::Router.prepare do 
          slice($SLICE_MODULE)
          slice_id = slice_name.gsub('-', '_').to_sym
          slice_routes = Merb::Slices.named_routes[slice_id] || {}
        
          # Setup a / root path matching route - try several defaults
          route = slice_routes[:home] || slice_routes[:index]
          if route
            params = route.params.inject({}) do |hsh,(k,v)|
              hsh[k] = v.gsub("\"", '') if k == :controller || k == :action
              hsh
            end
            match('/').to(params)
          else
            match('/').to(:controller => 'merb_slices', :action => 'index')
          end
        end
      end
    else
      raise "No slice found (expected: #{slice_name})"
    end
  end
end
