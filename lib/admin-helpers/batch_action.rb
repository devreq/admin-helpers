module AdminHelpers
  module BatchAction
    extend ActiveSupport::Concern
    
    included do
      class_inheritable_hash :defined_batch_actions
      self.defined_batch_actions = {
        :destroy => proc { |objects| objects.each { |o| o.destroy } }    
      }
    end
    
    module ClassMethods
      def define_batch_action(action, proc)
        batch_action_procs[action] = proc
      end

      def batch_action(*args)
        options = args.extract_options!
        actions = args + options.keys
        defined_actions = self.defined_batch_actions.keys
    
        define_method :batch_action do
          objects = current_model.find(params[:ids] || [])
          defined_actions.each do |d|
            self.class.defined_batch_actions[d].call(objects) if params[d]
          end
          redirect_to :action => :index
        end
      end      
    end
  end
end