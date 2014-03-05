# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ul = $('ul#results')
  $("#name, #address").keyup ->
    name    = $("#name").val()
    address = $("#address").val()

    if(name.length > 0 || address.length > 0)
      $.ajax
        url: "/dashboard/restaurants/search",
        data: { name : name, address: address },
        dataType: 'json'
      .done (data) ->
        liveSearch(data)
    else if name.length is 0 && address.length is 0
      ul.html('')

  $(document).on 'ajax:success', 'form#search', (e, data, status, xhr) ->
    liveSearch(data)

  liveSearch = (data) ->
    ul.html('')

    results = JSON.parse data['results']
    if results.length is 0
      name    = $('<h3/>', {html: '隱藏美食!!'})
      address = $('<h4/>', {html: '快來新增!!'})
      a       = $('<a/>', {href: '/dashboard/restaurants/new'}).append(name).append(address)
      li      = $('<li/>', {class: 'result'}).append(a)
      ul.append(li)
    else
      for result in results
        name    = $('<h3/>', {html: result.name})
        address = $('<h4/>', {html: result.address})
        a       = $('<a/>', {href: '/dashboard/tasks/?restaurant='+ result.id, 'data-method': 'post'}).append(name).append(address)
        li      = $('<li/>', {class: 'result'}).append(a)
        ul.append(li)