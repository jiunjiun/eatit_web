# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require underscore

Before_num     = 0
Before_Display = false

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
    $(this).find('.doublecheck').addClass('doublechecked')
    task = $(this).data('task')
    $('.modal-dialog > form').attr('action', '/tasks/finish/' + task)

  $('#scores').on 'hide.bs.modal', (e) ->
    $('.doublechecked').removeClass('doublechecked')

  $(document).on 'ajax:success', 'form#feedback_scores', (e, data, status, xhr) ->
    if data.status is 'Y'
      $('#scores').modal('hide')
      $('table tr.task' + data.id).remove()
    else
      $('.modal-dialog').addClass('wobble')
      setTimeout ->
        $('.modal-dialog').removeClass('wobble')
      , 1500

  $('#before_btn').click ->
    DisplayShow = true
    DisplayHide = false
    if Before_Display is DisplayHide
      $('#before').removeClass('hide').addClass('fadeInUp')
      Before_Display = DisplayShow
      fbefore()
    false

  $('.more').click ->
    fbefore()
    false

  fbefore = ->
    $.ajax
      url: "/tasks/before/#{Before_num}" ,
      data: {},
      dataType: 'json'
    .done (data) ->
      Before_num++
      before = $('#before')
      for task in data.tasks
        tr = before.find('tr.sample').clone()
        tr.removeClass('sample').removeClass('hide').addClass('fadeInUp')
        tr = tr.addClass("task#{task.id}").attr('data-task', task.id)
        td0 = tr.find('td').eq(0)
        td1 = tr.find('td').eq(1)

        td0.find('a').attr('href', "/tasks/repeat/#{task.id}")
        td1.html(task.name)
        before.find('tbody').append(tr)


  $(document).on 'ajax:success', '#repeat', (e, data, status, xhr) ->
    task = data.task
    $("#before tr.task#{task.id}").addClass('fadeOutUp')
    setTimeout(
      ->
        $("#before tr.task#{task.id}").hide()
        tasks = $('#tasks').find('tbody')
        tr = tasks.find('tr.sample').removeClass('hide').addClass("task#{task.id} fadeInUp").attr('data-task', task.id)
        td0 = tr.find('td').eq(0)
        td1 = tr.find('td').eq(1)
        td2 = tr.find('td').eq(2)

        td0.find('a').attr('data-task', task.id)
        td1.html(task.name)
        td2.find('a').attr('href', "/tasks/#{task.id}")

        tasks.append(tr)
      , 500
    )

  $(document).on 'ajax:success', 'a#delete', (e, data, status, xhr) ->
    tr = $(this).parents('tr')
    tr.addClass('fadeOutUp')
    setTimeout(
      ->
        tr.hide()
      , 500
    )

  $(document).on 'click', 'tbody td.task_name', ->
    opt  = $(this)
    fold = opt.parents('tr').attr('data-fold')
    if fold is 'close'
      task_id = opt.parents('tr').data('task')
      opt.parents('tr').attr('data-fold', 'open')
      $.ajax
        url: "/tasks/#{task_id}",
        data: {},
        dataType: 'json'
      .done (data) ->
        index = opt.parents('tr').index()

        card = $('.sample-card').clone().removeClass('hide')
        card.find('.header h4').html(data.name)
        card.find('.address a').attr('href', "https://www.google.com/maps/search/#{data.address}/17z").html(data.address)
        card.find('.telephone a').attr('href', "tel:#{data.telephone}").html(data.telephone)
        card.find('.link a').attr('href', data.url)

        tr = opt.parents('.table').find("tr:eq(#{index})")
        card.addClass('fadeInDown').insertAfter(tr)

        $('i').tooltip()
    else
      opt.parents('tr').attr('data-fold', 'close')
      index = opt.parents('tr').index() + 1
      tr = opt.parents('.table').find("tr:eq(#{index})")
      tr.addClass('fadeOutUp')
      setTimeout(
        ->
          tr.remove()
        , 500
      )
    false
  # ---- Ends

  # ---- New Task
  $(".float-label-control").floatLabels()

  $('#url').keyup (event) ->
    task_form_reset() if event.keyCode is 13


  $('.fetch_btn').click ->
    task_form_reset()

  task_form_reset = ->
    $('.loading').removeClass('hide')
    $('.task_form').addClass('hide')

  $(document).on 'ajax:success', 'form#fetch', (e, data, status, xhr) ->
    if data.info
      fetch_info = data.info

      $('.hide').removeClass('hide').addClass('fadeInDown')
      $('.loading').addClass('hide')

      $('#respone_url').val($('#url').val())
      $('#name').val(fetch_info.title)
      $('#address').val(fetch_info.address[0])
      $('#telephone').val(fetch_info.telephone[0])

      $(".float-label-control").floatLabels()





# handler = Gmaps.build("Google")

# handler.buildMap
#   provider:
#     zoom: 15
#     center: new google.maps.LatLng(22.6875, 120.307)
#     mapTypeId: google.maps.MapTypeId.ROADMAP
#     panControl: false
#     zoomControl: false
#     mapTypeControl: false
#     scaleControl: false
#     # streetViewControl: false
#     overviewMapControl: false
#     disableDefaultUI: false
#   internal:
#     id: "map"
# , ->
#   markers = handler.addMarkers([
#     lat: 22.6875
#     lng: 120.307
#     infowindow: "hello!"
#   ])
#   # handler.bounds.extendWith markers
#   # handler.fitMapToBounds()
#   # handler.getMap().setZoom(16)
#   return




