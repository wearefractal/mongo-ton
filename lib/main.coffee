ton = require 'ton'
mongo = require 'mongodb'

global.ObjectID = mongo.ObjectID
global.DBRef = mongo.DBRef
global.Binary = mongo.Binary
global.Timestamp = mongo.Timestamp
global.MinKey = mongo.MinKey
global.MaxKey = mongo.MaxKey
global.Code = mongo.Code
global.Long = mongo.Long
global.Double = mongo.Double

getClass = (obj) ->
  return "undefined" if typeof obj is "undefined"
  return "null" unless obj?
  return obj.constructor.name if obj.constructor?.name?
  return Object.prototype.toString.call(obj).match(/^\[object\s(.*)\]$/)[1]

ton.add "DBRef", (val) -> "new DBRef(\"#{val.namespace}\", new ObjectID(\"#{val.oid}\"), \"#{val.db}\")" if getClass(val) is 'DBRef'
ton.add "ObjectID", (val) -> "new ObjectID(\"#{val}\")" if getClass(val) is 'ObjectID'
ton.add "Binary", (val) -> "new Binary(new Buffer(\"#{val}\"), \"#{val.sub_type}\")" if getClass(val) is 'Binary'
ton.add "Code", (val) -> "new Code(\"#{val.code}\", #{ton.stringify(val.scope)})"if getClass(val) is 'Code'
ton.add "Long", (val) -> "new Long(#{val.low_}, #{val.high_})" if getClass(val) is 'Long'
ton.add "Double", (val) -> "new Double(#{val.value})" if getClass(val) is 'Double'
ton.add "MinKey", (val) -> "new MinKey()" if getClass(val) is 'MinKey'
ton.add "MaxKey", (val) -> "new MaxKey()" if getClass(val) is 'MaxKey'
module.exports = ton