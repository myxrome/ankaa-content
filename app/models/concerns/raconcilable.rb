module Reconcilable

  protected
  def reconcile_child(existing, params)
    (existing.ids.to_set - params.map { |p|
      child = existing.find_or_create_by(source: p[:source])
      child.reconcile p
      child.id
    }.to_set).each { |child_id|
      child = existing.find(child_id)
      if block_given?
        yield child
      else
        child.destroy
      end
    }
  end

end