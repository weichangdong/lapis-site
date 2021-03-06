@L ||= {}

class L.Reference
  constructor: ->
    @setup_captions()
    @setup_lang_picker()
    @setup_search()

  setup_search: =>
    drop = $("#search_drop")
    L.setup_search drop, {
      index: drop.data "index"
      root: drop.data "root"
    }

  setup_captions: ->
    tpl = (url, caption, alt="Hi") -> """
      <div class="image_container">
        <div class="image">
          <div class="caption_outer">
            <div class="caption">#{caption}</div>
          </div>
          <img src="#{url}" alt="#{alt}" />
        </div>
      </div>
    """

    $(".text_column img[title]").replaceWith ->
      elm = $(@)
      tpl elm.attr("src"), elm.attr("title"), elm.attr("alt")

  setup_lang_picker: ->
    body = $(document.body)
    pickers = $(".lang_picker .lang_toggle")
    override = body.find(".override_lang")

    set_lang = (name, save=true) ->
      if name
        pickers.removeClass("active")
          .filter("[data-lang='#{name}']")
          .addClass("active")

      real_lang = name
      if override.length
        real_lang = override.data "lang"

      if real_lang
        body
          .toggleClass("show_lua", real_lang == "lua")
          .toggleClass("show_moonscript", real_lang == "moonscript")

      if save
        window.localStorage?.setItem("reference_lang", name)

    body.on "click", ".lang_picker .lang_toggle", (e) ->
      button = $(e.currentTarget)
      set_lang button.data "lang"
      null

    lang = window.localStorage?.getItem("reference_lang")
    set_lang lang, false

