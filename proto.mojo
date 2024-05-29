from protobuf import ProtoBuf
# Write
# Serialize
fn serialize(person: Person):
    pass

struct Field[T: CollectionElement]:
    var tag: Int8 #Should be 3 bytes
    var value: T

    fn __init__(inout self, tag: Int8, value: T):
        self.tag = tag
        self.value = value


# Model
struct Person(ProtoBuf):
    var name: Field[Optional[String]] 
    var age: Field[UInt8]
    var is_human: Field[Bool]

    fn __init__(inout self):
        self.name = Field[Optional[String]](1, String("Default")) 
        self.age = Field[UInt8](2, 4)
        self.is_human = Field[Bool](3, False)

def main():
    var p = Person()