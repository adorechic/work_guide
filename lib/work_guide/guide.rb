require 'active_support'
require 'active_support/core_ext'

module WorkGuide
  class Guide
    attr_accessor :description, :cycle, :done_at, :priority, :week_start

    class << self
      def create(args)
        guide = new(args)
        all << guide
        save
        guide
      end

      def all
        @all ||= Storage.new(:guide).load.map { |h| new(h.symbolize_keys) }
      end

      def save
        Storage.new(:guide).store(to_json)
      end

      private

      def to_json
        all.map(&:to_h).to_json
      end
    end

    def initialize(
          description: ,
          cycle: 'daily',
          done_at: nil,
          priority: 'medium',
          week_start: 'monday'
        )
      @description = description
      @cycle = cycle
      if done_at
        @done_at = Time.parse(done_at)
      end
      @priority = priority

      if week_start
        @week_start = week_start.to_sym
      end
    end

    def should_do?
      if done_at
        case cycle
        when 'hourly'
          1.hour.since(done_at).beginning_of_hour.past?
        when 'daily'
          1.day.since(done_at).beginning_of_day.past?
        when 'weekly'
          Time.now.beginning_of_week(week_start) >= done_at
        when 'monthly'
          1.month.since(done_at).beginning_of_month.past?
        else
          raise ArgumentError, "Unknown cycle: #{cycle}"
        end
      else
        true
      end
    end

    def week_start_if_weekly
      cycle == 'weekly' ? week_start : nil
    end

    def priority_rate
      case priority
      when 'high'  ; 1
      when 'medium'; 2
      when 'low'   ; 3
      else         ; 9
      end
    end

    def to_h
      {
        description: description,
        cycle: cycle,
        done_at: done_at,
        priority: priority,
        week_start: week_start,
      }
    end

    def to_s
      "[#{cycle}/#{priority}] #{description} (#{done_at || '--'})"
    end
  end
end
