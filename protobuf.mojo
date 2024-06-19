
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
    
    fn __iter__(inout self):
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

##################
fn serialize[T: ProtoBuf](owned model: T):
    for i in model:
        pass

fn deserialize[T: ProtoBuf](inout model: T, owned bytes: Bytes):
    for cursor in range(len(bytes)):
        var byte = bytes[cursor] # I have to make some bit masking now
        byte << 1

fn __dict__[T: ProtoBuf](borrowed model: T):
    ...

# Essentially a Model Interface
trait ProtoBuf:
    ...

struct Model(ProtoBuf):
    var fields: List[Field]

@value
struct Field[T:CollectionElement]:
    var index: Int8
    var name: String
    var value: T

    fn __init__(inout self, index: Int8, name: String, value: T):
        self.index = index
        self.name = name
        self.value = value

fn main():
    var f = Field[String](0, "First Field", "Value of Filed")
    var fields = Tuple(
        Field[String](0, "First Field", "Value of Filed"),
        Field[Int8](1, "Second Field", 2)
    )
    print(f.index, f.name, f.value)
    print(fields[0].index, fields[0].name, fields[0].value)
    print(fields[1].index, fields[1].name, fields[1].value)