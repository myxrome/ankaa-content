module Reconcilable
  extend ActiveSupport::Concern

  protected
  def reconcile_children(existing, params, callback_context)
    (existing.ids.to_set - params.map { |p|
      begin
        new = false
        child = existing.find_or_create_by(source: p[:source]) { new = true }.reconcile(p)
        new ? on_create(child, callback_context) : on_update(child, callback_context)
        child.id
      rescue Exception => e
        on_error(e, callback_context)
      end
    }.to_set).each { |child_id|
      begin
        child = existing.find(child_id)
        on_delete child, callback_context
        delete child
      rescue Exception => e
        on_error(e, callback_context)
      end
    }
    callback_context
  end

  def on_create(child, callback_context)
  end

  def on_update(child, callback_context)
  end

  def on_delete(child, callback_context)
  end

  def on_error(e, callback_context)
  end

  def delete(child)
    child.destroy
  end

end