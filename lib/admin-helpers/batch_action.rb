module AdminHelpers
  module BatchAction
    extend ActiveSupport::Concern
    
    included do
      class_attribute :defined_batch_actions
      self.defined_batch_actions = {
        :destroy => :destroy,
        :publish => :publish!,
        :unpublish => :unpublish!,
        :nav_publish => :nav_publish!,
        :nav_unpublish => :nav_unpublish!        
      }
    end
    
    module ClassMethods
      def define_batch_action(action, proc)
        defined_batch_actions[action] = proc
      end

      def batch_action(*args)
        options = args.extract_options!
        actions = args + options.keys
        defined_actions = self.defined_batch_actions.keys
    
        define_method :batch_action do
          objects = current_model.find(params[:ids] || [])
          actions.each do |d|            
            if params[d] && defined_actions.include?(d)
              action = self.class.defined_batch_actions[d]                        
              if action.is_a?(Proc)
                action.call(objects)
              else
                object.each { |o| o.send(action) }
              end
            end
          end
          redirect_to :action => :index
        end
      end      
    end
  end
end