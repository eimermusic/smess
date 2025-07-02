# coding: UTF-8
require 'active_support'
require 'active_support/core_ext'

require_relative "smess/version"
require_relative 'smess/logging'
require_relative 'smess/output'
require_relative 'smess/utils'
require_relative 'smess/sms'
require_relative 'smess/outputs/http_base'
require_relative 'smess/outputs/auto'
require_relative 'smess/outputs/card_board_fish'
require_relative 'smess/outputs/clickatell'
require_relative 'smess/outputs/smsglobal'
require_relative 'smess/outputs/global_mouth'
require_relative 'smess/outputs/link_mobility'
require_relative 'smess/outputs/twilio'
require_relative 'smess/outputs/twilio_whatsapp'
require_relative 'smess/outputs/test'

require_relative 'string_ext'

module Smess

  def self.new(*args)
    Sms.new(*args)
  end

  def self.named_output_instance(name)
    output_class_name = config.configured_outputs.fetch(name)[:type].to_s.camelize
    conf = config.configured_outputs[name][:config]
    "Smess::#{output_class_name}".constantize.new(conf)
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset_config
    @config = Config.new
  end

  def self.configure
    yield(config)
  end

  class Config
    attr_accessor :nothing, :default_output, :default_sender_id, :default_sender_id, :output_types, :configured_outputs, :output_by_country_code

    def initialize
      @nothing = false
      @default_output = nil
      @default_sender_id = "Smess"
      @output_types = %i{auto card_board_fish clickatell global_mouth link_mobility smsglobal twilio twilio_whatsapp}
      @configured_outputs = {}
      @output_by_country_code = {}

      if ENV["RAILS_ENV"] == "test"
        @configured_outputs = {test: {type: :test, config: nil}}
      end

      register_output({
        name: :auto,
        country_codes: [],
        type: :auto,
        config: {}
      })
    end

    def add_country_code(cc, output=default_output)
      raise ArgumentError.new("Invalid country code") unless cc.to_i.to_s == cc.to_s
      raise ArgumentError.new("Unknown output specified") unless outputs.include? output.to_sym
      output_by_country_code[cc.to_s] = output.to_sym
      true
    end

    def register_output(options)
      name = options.fetch(:name).to_sym
      type = options.fetch(:type).to_sym
      countries = options.fetch(:country_codes)
      config = options.fetch(:config)

      raise ArgumentError.new("Duplicate output name") if outputs.include? name
      raise ArgumentError.new("Unknown output type specified") unless output_types.include? type

      configured_outputs[name] = {type: type, config: config}
      countries.each do |cc|
        add_country_code(cc, name)
      end
    end

    def outputs
      configured_outputs.keys
    end

    def country_codes
      output_by_country_code.keys
    end

  end
end

# httpclient does not send basic auth correctly, or at all.
HTTPI.adapter = :net_http
