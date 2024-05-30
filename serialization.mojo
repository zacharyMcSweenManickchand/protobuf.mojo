from protobuf import Bytes

# The tag is actually starts at `000`
# So if the Tag id is 2 is equal to `001`
fn serialize_len(tag: Int8, owned value: Bytes) -> Bytes:
    value.insert(0, ((tag-1) << 4) ^ 0x02)
    value.insert(1, len(value)-1)
    return value

# Think it simply an overflow of bits with the msb behing inserted (if unsigned)
fn serialize_var_int[size:Int8](tag: Int8, owned value: Bytes) -> Bytes:
    # Need to loop throught and change the first bit to 1 or 0

    # little endian
    value.reverse()

    value.insert(0, ((tag-1) << 4))
    return value

fn serialize(tag: Int8, value: String) -> Bytes:
    return serialize_len(tag, value.as_bytes())

fn serialize(tag: Int8, value: Bytes) -> Bytes:
    return serialize_len(tag, value)

fn serialize(tag: Int8, value: UInt64) -> Bytes:
    # Converting UInt64 to bytes
    var list = Bytes()
    alias SIZE_OF_VARIABLE = 64
    alias SIZE_OF_BYTE = 8

    for i in range(SIZE_OF_VARIABLE/SIZE_OF_BYTE):
        list.append(Int8(value >> (SIZE_OF_BYTE * i)) & 0XFF)

    return serialize_var_int[SIZE_OF_VARIABLE/SIZE_OF_BYTE](tag, list)