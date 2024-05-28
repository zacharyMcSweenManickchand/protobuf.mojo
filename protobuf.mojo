
alias Bytes = List[Int8]

trait Serializable:
    pass

trait DeSerializable:
    pass

# Message is not Encoded into the **wire format**, the rows must be attached afterwards
struct Message(Serializable, DeSerializable):
    fn __init__(inout self):
        pass

    fn __init__(inout self, dict: Dict):
        """
        This is the function used to for JSON input
        """
        # Parse Dict
        # Map to correct type
        pass

    fn deserialize(inout self, bytes: Bytes):
        pass

struct Field[T: ValueType](Serializable, DeSerializable):
    var name: String
    var tag: Int8 #Should be 3 bytes
    #var value: T#VarInt or I32 or I64 or LEN

    fn __init__(inout self, name: String, tag: Int8):
        self.name = name
        self.tag = tag
        #self.value = value
    
    fn serialize(inout self):
        pass


trait ValueType:
    pass

struct VarInt(ValueType, Serializable, DeSerializable):
    pass


struct I32(ValueType, Serializable, DeSerializable):
    pass


struct I64(ValueType, Serializable, DeSerializable):
    pass


# Up to 2GB
struct LEN(ValueType, Serializable, DeSerializable):
    pass

fn serialize[T: ProtoBuf](owned model: T):
    ...

############## Bit manupulation
fn bit_mod[byte: Int8](value: Int8) -> Bool:
    return value % byte > 0

# Is x bit 1 (True) or 0 (False)
fn bit_location_value[index: Int8](byte: Int8) raises -> Bool:
    if index < 0 or index > 8:
        raise Error("Out of range")
    return bit_mod[256 / (1 + index)](byte)

##################

fn deserialize[T: ProtoBuf](inout model: T, owned bytes: Bytes):
    for cursor in range(len(bytes)):
        var byte = bytes[cursor] # I have to make some bit masking now
        byte << 1

fn __dict__[T: ProtoBuf](borrowed model: T):
    ...

# Essentially a Model Interface
trait ProtoBuf:
    ...

fn main():
    pass