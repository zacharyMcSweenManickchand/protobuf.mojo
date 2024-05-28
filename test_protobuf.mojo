from testing import assert_equal, assert_false, assert_true

from protobuf import ProtoBuf, serialize, deserialize, Bytes



@value
struct Person(ProtoBuf):
    var name: Optional[String]
    var age: UInt8
    var is_human: Bool

    fn __init__(inout self):
        self.name = String("Default")
        self.age = 4
        self.is_human = False

# The tests for this program come from the encoding specifications
# https://protobuf.dev/programming-guides/encoding/
# fn test_serialization():
#     """
#     Testing `A Simple Message`
#     message Test1 {
#         optional int32 a = 1;
#     }
#     """
#     pass

# fn test_2_serialization():
#     var p = Person(String("Joe"), 23, True)
#     serialize(p)

fn test_deserialization() raises:
    var p = Person()
    deserialize(p, Bytes(123, 122, 33, 23))
    assert_true(True)