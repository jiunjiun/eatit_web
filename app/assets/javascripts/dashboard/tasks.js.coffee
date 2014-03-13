# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require bootstrap/modal
//= require bootstrap/tooltip

$ ->
  # --- index Task
  $('i').tooltip()
  $('.more i').click (event) ->
    $('.detail').slideToggle ->
      if $('.detail').is(':hidden')
        $('.more i').addClass('fa-chevron-circle-down').removeClass('fa-chevron-circle-up')
      else
        $('.more i').addClass('fa-chevron-circle-up').removeClass('fa-chevron-circle-down')


  $('.finish').click ->
    task = $(this).data('task')
    $('.modal-dialog > form').attr('action', '/dashboard/tasks/finish/' + task)

  $(document).on 'ajax:success', 'form#feedback_scores', (e, data, status, xhr) ->
    if data.status is 'Y'
      $('#scores').modal('hide')
      $('table tr.task' + data.id).remove()
    else
      $('.modal-dialog').addClass('wobble')
      setTimeout ->
        $('.modal-dialog').removeClass('wobble')
      , 1500

  # ---- Ends

  # ---- New Task
  $("#name, #address").keyup (event) ->
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
      $('#liveSearch > .row').html('')

  liveSearch = (data) ->
    $('#liveSearch > .row').html('')

    results = JSON.parse data['results']
    if results.length isnt 0
      ALL_order = results.length
      order_num = 0
      for result in results
        params = {
          id        : result.id
          name      : result.name
          telephone : result.telephone
          area      : result.area
          address   : result.address
          count     : result.count
        }
        displayResultToPage(params)
    else
      sampleCard = $('.hidefood').clone().removeClass('hide')
      $('.row').append(sampleCard)

  displayResultToPage = (params) ->
    sampleCard = $('.sampleCard').clone().removeClass('sampleCard')
    sampleCard.find('.name').html(params.name)
    sampleCard.find('.address').html(params.address)

    sampleCard.find('a').attr('href', '/dashboard/tasks/?restaurant='+ params.id).attr('data-method': 'post')
    $('.row').append(sampleCard)

  $(document).on 'ajax:success', 'form#search', (e, data, status, xhr) ->
    liveSearch(data)

  # ---- End


# $ ->
#   KEY_UP    = 38
#   KEY_DOWN  = 40
#   ALL_order = 0
#   order_num = 0
#   $("#name, #address").keyup (event) ->
#     if event.keyCode is KEY_UP || event.keyCode is KEY_DOWN
#       if event.keyCode is KEY_UP
#         order_num -= 1
#       else
#         order_num += 1

#       if order_num - 1 < 0
#         order_num = 1
#         return 0
#       else if order_num > ALL_order
#         order_num = ALL_order
#         return 0

#       console.log order_num
#       $('.active').removeClass('active');
#       $('ul#results li').eq(order_num-1).addClass('active');
#     else
#       name    = $("#name").val()
#       address = $("#address").val()

#       if(name.length > 0 || address.length > 0)
#         $.ajax
#           url: "/dashboard/restaurants/search",
#           data: { name : name, address: address },
#           dataType: 'json'
#         .done (data) ->
#           liveSearch(data)
#       else if name.length is 0 && address.length is 0
#         $('ul#results').html('')

#   $("ul#results").mousemove (event) ->
#     order_num = 0
#     $('.active').removeClass('active');





#   liveSearch = (data) ->
#     $('ul#results').html('')

#     results = JSON.parse data['results']
#     if results.length is 0
#       params = {
#         name      : '隱藏美食!!'
#         address   : '快來新增!!'
#       }
#       displayResultToPage(params)

#     else
#       ALL_order = results.length
#       order_num = 0
#       for result in results
#         params = {
#           id        : result.id
#           name      : result.name
#           telephone : result.telephone
#           area      : result.area
#           address   : result.address
#           count     : result.count
#         }
#         displayResultToPage(params)

#   displayResultToPage = (params) ->
#     ul        = $('ul#results')
#     name      = $('<p/>', {class: 'name', html: params.name})
#     telephone = $('<p/>', {class: 'telephone', html: params.telephone})

#     if typeof params.id is 'undefined'
#       address   = $('<p/>', {class: 'address', html: params.address})
#       a = $('<a/>', {href: '/dashboard/restaurants/new'})
#     else
#       address   = $('<p/>', {class: 'address', html: params.area + params.address + '．'+ params.count + ' 使用次'})
#       a = $('<a/>', {href: '/dashboard/tasks/?restaurant='+ params.id, 'data-method': 'post'})

#     a.append(telephone).append(name).append(address)
#     li = $('<li/>', {class: 'result list-group-item'}).append(a)
#     $('ul#results').append(li)


# //= require twitter/typeahead.min
# # instantiate the bloodhound suggestion engine
# numbers = new Bloodhound(
#   datumTokenizer: (d) ->
#     Bloodhound.tokenizers.whitespace d.num
#   remote: '../data/films/queries/%QUERY.json',
#   queryTokenizer: Bloodhound.tokenizers.whitespace
#   local: [
#     {
#       num: "one"
#     }
#     {
#       num: "two"
#     }
#     {
#       num: "three"
#     }
#     {
#       num: "four"
#     }
#     {
#       num: "five"
#     }
#     {
#       num: "six"
#     }
#     {
#       num: "seven"
#     }
#     {
#       num: "eight"
#     }
#     {
#       num: "nine"
#     }
#     {
#       num: "ten"
#     }
#   ]
# )

# # initialize the bloodhound suggestion engine
# numbers.initialize()

# $ ->
#   # instantiate the typeahead UI
#   $(".typeahead").typeahead null,
#     displayKey: "num"
#     source: numbers.ttAdapter()

