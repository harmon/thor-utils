class Thor
  def start_environment(env = nil)
    require "merb-core"
    env = ENV["MERB_ENV"] || "development" if env.nil?
    Merb.start_environment(:environment => env, :adapter => 'runner')
  end
end
