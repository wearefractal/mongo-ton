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

ton.add "ObjectID", (val) -> "new ObjectID(\"#{val}\")" if val instanceof ObjectID
ton.add "DBRef", (val) -> "new DBRef(\"#{val.namespace}\", new ObjectID(\"#{val.oid}\"), \"#{val.db}\")" if val instanceof DBRef
ton.add "Binary", (val) -> "new Binary(new Buffer(\"#{val}\"), \"#{val.sub_type}\")" if val instanceof Binary
ton.add "Code", (val) -> "new Code(\"#{val.code}\", #{ton.stringify(val.scope)})" if val instanceof Code
ton.add "Long", (val) -> "new Long(#{val.low_}, #{val.high_})" if val instanceof Long
ton.add "Double", (val) -> "new Double(#{val.value})" if val instanceof Double
ton.add "MinKey", (val) -> "new MinKey()" if val instanceof MinKey
ton.add "MaxKey", (val) -> "new MaxKey()" if val instanceof MaxKey
module.exports = ton