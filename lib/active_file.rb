require 'fileutils'

module ActiveFile

  def save
    @new_record = false
    File.open("db/revistas/#{@id}.yml", "w") do |file|
      file.puts serialize
    end
  end

  def destroy
    unless @destroyed
      @destroyed = true
      FileUtils.rm "db/revistas/#{@id}.yml"
    end
  end

  class Field
    attr_reader :name, :required

    def initialize(name, required)
      @name, @required = name, required
    end  
  end

  module ClassMethods
    

    def field(name, required: false)
      @fields ||= []
      @fields << Field.new(name, required)
    end

    def find(id)
      raise DocumentNotFound, "Arquivo db/revistas/#{id} não encontrado", caller unless File.exist?("db/revistas/#{id}.yml")
      YAML.load File.open("db/revistas/#{id}.yml", "r")
    end

    def next_id
      Dir.glob("db/revistas/*.yml").size + 1
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      attr_reader :id, :destroyed, :new_record

      def initialize(parameters = {})
        @id = self.class.next_id
        @destroyed = false
        @new_record = true

        self.class.fields.each do |field|
          parameter = parameters.select{ |k, v| k == field.name}
          if field.required
            raise StandardError.new("#{field.name} obrigatório") unless parameter && parameter[field.name]
          else
            instance_variable_set "@#{field.name}"
            parameter[field.name]
          end
        end

      end
    end
  end

  private

  def serialize
    YAML.dump self
  end
 

end