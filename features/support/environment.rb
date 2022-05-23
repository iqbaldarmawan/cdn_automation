class Environment
  attr_accessor :platform_name, :environment_name

  def platform_name
    ENV['PLATFORM_NAME']
  end

  def browser_name
    ENV['BROWSER_NAME']
  end

  def host
    ENV['HOST']
  end

end