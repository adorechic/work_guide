require 'thor'

module WorkGuide
  class CLI < Thor
    desc "add [guide description]", "Add a new guide"
    def add(description)
      puts "Added #{description}!"
    end
  end
end
