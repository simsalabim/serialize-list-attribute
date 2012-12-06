module SerializeListAttribute
  extend ActiveSupport::Concern

  included do
    def self.serialize_list_attributes *contexts
      options = contexts.extract_options!
      as = options[:as].to_s.camelize.constantize || Array
      before_save :synchronise_lists

      contexts.each do |context|
        serialize "#{context}", as
        attr_writer "raw_#{context}"

        define_method "raw_#{context}" do
          instance_variable_get("@raw_#{context}") || instance_variable_set("@raw_#{context}", send("#{context}").join(', '))
        end

        define_method "build_#{context}" do
          send("raw_#{context}").split(',').map(&:strip)
        end

        unless options[:validation_method].nil?
          before_validation do
            send("build_#{context}").each do |item|
              send options[:validation_method], item, "raw_#{context}"
            end
          end
        end
      end

      define_method :synchronise_lists do
        contexts.each do |context|
          send "#{context}=", send("build_#{context}")
        end
      end
    end
  end
end