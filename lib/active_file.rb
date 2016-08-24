require 'fileutils'

module ActiveFile

  class Field
    attr_reader :name, :required, :default

    def initialize(name, required, default)
      @name, @required, @default = name, required, default
    end

    def to_argument
      "#{@name}: #{@default}"
    end

    def to_assign
      "@#{@name} = #{@name}"
    end
  end

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


  module ClassMethods
    attr_reader :fields

    def field(name, required: false, default: "")
      
      @fields ||= []
      @fields << Field.new(name, required, default)

      self.class_eval %Q$
        attr_reader :id, :destroyed, :new_record
        def initialize(#{@fields.map(&:to_argument).join(", ")})
          @id = self.class.next_id.size + 1
          @destroyed = false
          @new_record = true
          #{@fields.map(&:to_assign).join("\n")}
        end
      $
    end

    def method_missing(name, *args, &block)
      super unless name.to_s =~ /^find_by_(.*)/

      argument = args.first
      field = $1

      super if @fields.include? field
      
      load_all.select do |object|
        should_select? object, field, argument
      end
    end

    def find(id)
      raise DocumentNotFound, "Arquivo db/revistas/#{id} não encontrado", caller unless File.exist?("db/revistas/#{id}.yml")
      YAML.load File.open("db/revistas/#{id}.yml", "r")
    end

    private

    def next_id
      Dir.glob("db/revistas/*.yml")
    end

    def should_select?(object, field, argument)
      if argument.kind_of? Regexp
        object.instance_variable_get("@#{field}") =~ argument
      else
        object.instance_variable_get("@#{field}") == argument
      end
    end

    def load_all
      Dir.glob('db/revistas/*.yml').map do |file|
        deserialize file
      end
    end

    def deserialize(file)
      YAML.load File.open(file, "r")
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  private

  def serialize
    YAML.dump self
  end

end
