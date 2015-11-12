require 'thor'
require 'kosi'

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

    desc "update [index]", "Edit a guide"
    option :priority, default: 'medium', banner: '[high|medium|low]'
    def update(index)
      guide = Guide.all[index.to_i]
      guide.priority = options[:priority] if options[:priority]
      Guide.save
      puts "Update [#{index}]#{guide}"
    end

    desc "list", "List guides"
    option :all, type: :boolean, default: false, aliases: :a
    def list
      puts guide_table(all: options[:all])
    end
    default_task :list

    desc "delete [index]", "Delete a guide"
    def delete(index)
      guide = Guide.all.delete_at(index.to_i)
      Guide.save
      puts "Deleted [#{index}]#{guide}"
    end

    desc "done [index]", "Mark as done"
    option :at, banner: "done_at"
    def done(*indexes)
      guides = indexes.map { |index| Guide.all[index.to_i] }
      done_at =
        if options[:at]
          Time.parse(options[:at])
        else
          Time.now
        end

      guides.each do |guide|
        guide.done_at = done_at
      end

      Guide.save
      indexes.each do |index|
        puts "Done [#{index}]#{Guide.all[index.to_i]}"
      end
    end

    private

    def guide_table(all: false)
      rows = Guide.all.map.with_index { |guide, index|
        [index, guide]
      }.select { |index, guide|
        all || guide.should_do?
      }.sort_by { |index, guide|
        guide.priority_rate
      }.map { |index, guide|
        [index, guide.cycle, guide.priority, guide.description, guide.done_at]
      }

      table = Kosi::Table.new(
        header: %w(index cycle priorify description done_at)
      )
      table.render(rows)
    end
  end
end
