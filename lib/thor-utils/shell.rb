require "fileutils"
require "term/ansicolor"

String.send(:include, Term::ANSIColor)

class Thor
  include FileUtils
  def success(*messages)
    messages.each do |message|
      puts message.green.bold
    end
  end

  def error(*messages)
    if messages.empty?
      messages.push("Error")
    end
    messages.each do |message|
      STDERR.puts message.red.bold
    end
    exit 1
  end

  def warn(*messages)
    messages.each do |message|
      STDERR.puts message.yellow.bold
    end
  end

  def sh(command)
    puts "sh> ".blue + command.to_s
    if returned = %x(#{command})
      puts returned
    else
      error returned
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
