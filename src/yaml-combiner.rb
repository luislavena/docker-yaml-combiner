#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require "yaml"

module App
  VERSION = "0.1.0"

  class Combiner
    # Result : Hash(String, String | Array(Result) | Result)
    attr_reader :result

    def initialize
      @result = {}
    end

    def combine(other) # : Nil
      merge(result, other)

      nil
    end

    private def merge(base, other)
      other.each_pair do |current_key, other_value|
        base_value = base[current_key]

        base[current_key] = if base_value.is_a?(Hash) && other_value.is_a?(Hash)
          merge(base_value, other_value)
        elsif base_value.is_a?(Array) && other_value.is_a?(Array)
          # avoid repeated values
          (base_value + other_value).uniq
        else
          other_value
        end
      end

      base
    end
  end

  class CLI
    # Options
    attr_reader :in_files # : Array(String)
    attr_reader :out_file # : String | Nil

    def initialize(argv)
      @in_files = []
      @out_file = nil

      argv = argv.dup
      process_args(argv)
    end

    def run
      # noop if no files were provided
      return if @in_files.empty?

      # process all `in_files`
      combiner = Combiner.new

      @in_files.each do |in_file|
        other_yaml = File.open(in_file, "rb") { |f| YAML.safe_load(f) }
        combiner.combine(other_yaml)
      end

      # persist combined results
      persist combiner.result
    end

    private def persist(data)
      if file = @out_file
        File.binwrite(file, YAML.dump(data))
      else
        puts YAML.dump(data)
      end
    end

    private def process_args(argv)
      parser = OptionParser.new

      parser.program_name = "yaml-combiner"
      parser.banner = "Usage: #{parser.program_name} [options] file1.yml file2.yml"

      parser.on("-o FILE", "--output FILE", "Write combined output to file") do |value|
        @out_file = String(value)
      end

      parser.on("--help", "-h", "Display this page") do
        puts parser
        exit 0
      end

      parser.on("-v", "--version", "Display program version") do
        puts "#{parser.program_name} version #{App::VERSION}"
        exit 0
      end

      parser.parse!(argv)

      # treat the remaining values as files
      argv.each do |file|
        @in_files << file
      end

      # if no value were given, display help
      if @in_files.empty?
        puts parser
        exit 1
      end
    end
  end
end

cli = App::CLI.new(ARGV)
cli.run
