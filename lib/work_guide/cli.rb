require 'thor'
require 'text-table'

module WorkGuide
  class CLI < Thor
    desc "add [guide description]", "Add a new guide"
    option :cycle, default: 'daily', banner: '[hourly|daily|weekly|monthly]', aliases: :c
    def add(description)
      guide = Guide.create(
        description: description,
        cycle: options[:cycle]
      )
      puts "Created [#{Guide.all.size - 1}]#{guide}"
    end

    desc "list", "List guides"
    option :all, type: :boolean, default: false, aliases: :a
    def list
      table = Text::Table.new
      table.head = %w(index cycle description done_at)
      table.rows = Guide.all.map.with_index { |guide, index|
        if options[:all] || guide.should_do?
          [index, guide.cycle, guide.description, guide.done_at]
        end
      }.compact
      puts table.to_s
    end

    desc "delete [index]", "Delete a guide"
    def delete(index)
      guide = Guide.all.delete_at(index.to_i)
      Guide.save
      puts "Deleted [#{index}]#{guide}"
    end

    desc "done [index]", "Mark as done"
    option :at, banner: "done_at"
    def done(index)
      guide = Guide.all[index.to_i]
      guide.done_at =
        if options[:at]
          Time.parse(options[:at])
        else
          Time.now
        end

      Guide.save
      puts "Done [#{index}]#{guide}"
    end
  end
end
