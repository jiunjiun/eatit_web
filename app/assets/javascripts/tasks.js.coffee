# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
      url: "/tasks/before/" + Before_num,
      data: {},
      dataType: 'json'
    .done (data) ->
      Before_num++
      before = $('#before')
      for task in data.tasks
        tr = before.find('tr.sample').clone()
        tr.removeClass('sample').removeClass('hide').addClass('fadeInUp')
        tr = tr.addClass("task#{task.id}")
        td0 = tr.find('td').eq(0)
        td1 = tr.find('td').eq(1)

        td0.find('a').attr('href', "/tasks/repeat/#{task.id}")
        td1.find('a').attr('href', "/restaurants/#{task.rid}").html(task.name)
        before.find('tbody').append(tr)


  $(document).on 'ajax:success', '#repeat', (e, data, status, xhr) ->
    task = data.task
    $("#before tr.task#{task.id}").addClass('fadeOutUp')
    setTimeout(
      ->
        $("#before tr.task#{task.id}").hide()
        tasks = $('#tasks').find('tbody')
        tr = tasks.find('tr.sample').removeClass('hide').addClass("task#{task.id} fadeInUp")
        td0 = tr.find('td').eq(0)
        td1 = tr.find('td').eq(1)
        td2 = tr.find('td').eq(2)

        td0.find('a').attr('data-task', task.id)
        td1.find('a').attr('href', "/restaurants/#{task.rid}").html(task.name)
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
  # ---- Ends

  # ---- New Task
  $("#name, #address").keyup (event) ->
    name    = $("#name").val()
    address = $("#address").val()

    if(name.length > 0 || address.length > 0)
      $.ajax
        url: "/restaurants/search",
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

    sampleCard.find('a').attr('href', '/tasks/?restaurant='+ params.id).attr('data-method': 'post')
    $('.row').append(sampleCard)

  $(document).on 'ajax:success', 'form#search', (e, data, status, xhr) ->
    liveSearch(data)

  # ---- End