require 'thor'

module WorkGuide
  class CLI < Thor
    desc "add [guide description]", "Add a new guide"
    def add(description)
      Guide.create(description: description)
    end

    desc "list", "List guides"
    def list
      Guide.all.each_with_index do |guide, index|
        puts "[#{index}] #{guide.description}"
      end
    end
  end
end
