from protobuf import ProtoBuf, Bytes

# Write
# Serialize


fn drop_msb(bin: Int8) -> Tuple[Bool, Int8]:
    """
    Drop the most significant bit (First one)
    """
    if bin % 128 != 0:
        return False, bin
    return True, bin ^ 0b10000000


struct Field[T: CollectionElement]:
    var tag: Int8  # Should be 3 bytes
    var value: T

    fn __init__(inout self, tag: Int8, value: T):
        self.tag = tag
        self.value = value

    fn _serialize_tag(inout self) -> Int8:
        return self.tag >> 3
    
    fn _serialize_value(inout self) -> Bytes:
        return List[Int8](1, 23, 4)

    fn serialize(inout self) -> Bytes:
        var serialization_value = self._serialize_value()
        serialization_value.insert(0, self._serialize_tag())
        return serialization_value


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

    var msb: Bool
    var byte: Int8

    msb, byte = drop_msb(123)