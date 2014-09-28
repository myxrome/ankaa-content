module Reconcilable

  protected
  def reconcile_child(existing, params, result)
    (existing.ids.to_set - params.map { |p|
      new = false
      child = existing.find_or_create_by(source: p[:source]) { |child|
        result[:new] << child.source unless result.nil?
        new = true
      }
      child.reconcile p
      result[:update] << child.source unless new || result.nil?
      child.id
    }.to_set).each { |child_id|
      child = existing.find(child_id)
      result[:delete] << child.source unless result.nil?
      if block_given?
        yield child
      else
        child.destroy
      end
    }
  end

end