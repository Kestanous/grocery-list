@Item = new ShadowModel
  collection: new Mongo.Collection('items')
  schema:
    name: (value) ->
      return @invalid 'must be a alphanumeric' unless _.isString value
      return @invalid 'must be not be empty' unless value.length
      @valid 'is valid'
    notes: (value) ->
      return @valid 'can be empty' if value is undefined
      return @valid 'is normal text' if _.isString value
      @invalid 'not sure what this is'
    count: (value) ->
      return @valid 'can be empty' if value is undefined
      return @invalid 'must be a number' unless _.isNumber value
      return @invalid 'must be a non negative number' unless value >= 0
      @valid 'is valid'
    listId: (value) ->
      return @invalid 'must be an id' unless _.isString value
      return @invalid 'no list found' unless List.find(value, {limit:1}).count()
      @valid 'is valid'
    done: (value) ->
      return @valid 'can be false' if value is undefined
      return @valid 'can be boolean' if _.isBoolean value
      @invalid 'must be some form of boolean'
  helpers: {}

@List = new ShadowModel
  collection: new Mongo.Collection('lists')
  schema: 
    name: (value) ->
      return @invalid 'must be a alphanumeric' unless _.isString value
      return @invalid 'must be not be empty' unless value.length
      @valid 'is valid'
  helpers: {}