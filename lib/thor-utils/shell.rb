require "fileutils"
require "term/ansicolor"

class Thor
  include FileUtils
  include Term::ANSIColor
  def sh(command)
    puts blue("sh> ") + command.to_s
    if returned = %x(#{command})
      puts returned
    else
      puts red("Error:")
      puts returned
      exit 1
    end
  end

  def rake(*tasks)
    sh "rake #{tasks.join(" ")}"
  end

  def thor(*options)
    sh "thor #{options.join(" ")}"
  end

  def ruby(*options)
    sh "ruby #{options.join(" ")}"
  end
end
