require "fluent/mixin/rewrite_tag_name"
class Fluent::RetagOutput < Fluent::Output
  Fluent::Plugin.register_output("retag", self)

  include Fluent::HandleTagNameMixin
  include Fluent::Mixin::RewriteTagName

  def configure(conf)
    super
  end

  def emit(tag, es, chain)
    emit_tag = tag.dup
    filter_record(emit_tag, nil, nil)

    router.emit_stream(emit_tag, es)
    chain.next
  end
end
