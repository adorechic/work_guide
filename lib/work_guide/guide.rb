require 'active_support'
require 'active_support/core_ext'

module WorkGuide
  class Guide
    attr_accessor :description, :cycle, :done_at

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

    def initialize(description: , cycle: 'daily', done_at: nil)
      @description = description
      @cycle = cycle
      if done_at
        @done_at = Time.parse(done_at)
      end
    end

    def to_h
      {
        description: description,
        cycle: cycle,
        done_at: done_at,
      }
    end

    def to_s
      "[#{cycle}] #{description} (#{done_at || '--'})"
    end
  end
end
