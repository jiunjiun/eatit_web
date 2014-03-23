# from http://bootsnipp.com/snippets/featured/float-label-pattern-forms

$.fn.floatLabels = (options) ->

  # Settings

  # Event Handlers
  registerEventHandlers = ->
    self.on "input keyup change", "input, textarea", ->
      actions.swapLabels this
      return

    return

  # Actions

  # Initialization
  init = ->
    registerEventHandlers()
    actions.initialize()
    self.each ->
      actions.swapLabels $(this).find("input,textarea").first()
      return

    return
  self = this
  settings = $.extend({}, options)
  actions =
    initialize: ->
      self.each ->
        $this = $(this)
        $label = $this.children("label")
        $field = $this.find("input,textarea").first()
        if $this.children().first().is("label")
          $this.children().first().remove()
          $this.append $label
        placeholderText = (if ($field.attr("placeholder") and $field.attr("placeholder") isnt $label.text()) then $field.attr("placeholder") else $label.text())
        $label.data "placeholder-text", placeholderText
        $label.data "original-text", $label.text()
        $field.addClass "empty"  if $field.val() is ""
        return

      return

    swapLabels: (field) ->
      $field = $(field)
      $label = $(field).siblings("label").first()
      isEmpty = Boolean($field.val())
      if isEmpty
        $field.removeClass "empty"
        $label.text $label.data("original-text")
      else
        $field.addClass "empty"
        $label.text $label.data("placeholder-text")
      return

  init()
  this