Template.ListSelect.onCreated ->
  @subscribe 'lists'
  @listIds = new ReactiveVar([])
  @edit = new ReactiveVar(false)
  @autorun =>
    user = Meteor.user()
    @listIds.set user.lists if user and user.lists

Template.ListSelect.events
  'click .getIonBodyEvent': (e, t) -> Template.instance().edit.set !Template.instance().edit.get()

Template.ListSelect.helpers
  lists: -> List.find _id: $in: Template.instance().listIds.get()
  editMode: -> Template.instance().edit.get()
  # templateGestures:
  #   'swiperight .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"
  #   'doubletap .item': (e,t) -> e.target.style.transform = "translateX(#{e.deltaX}px)"

Template._ListNewModal.events
  'click .add': (e, t) ->
    data = {
      name: t.$('.name').val()
    }
    id = List.insert data
    Meteor.users.update Meteor.userId(), $push: lists: id if id

Template.ListSelectShopItem.helpers
  url: -> "/lists/#{@_id}"


Template.ListSelectEditItem.events
  'click .remove': -> 
    Item.find(listId: @_id).forEach (doc) -> Item.remove doc._id
    List.remove @_id
  