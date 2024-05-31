from protobuf import Bytes

# The tag is actually starts at `000`
# So if the Tag id is 2 is equal to `001`
fn serialize_len(tag: Int8, owned value: Bytes) -> Bytes:
    value.insert(0, ((tag) << 3) ^ 0x02)
    value.insert(1, len(value)-1)
    return value

fn reject_null_bytes_in_front(inout arr: Bytes):
    """
    This function reject the 0x00 bytes that are in the front of the array.
    Since the array is backward alreadu the loop is reversed.
    """
    print(arr[0])
    var index = len(arr) - 1 
    while index > 0 and arr[index] == 0x00:
        _ = arr.pop(index)
        index -= 1

# Think it simply an overflow of bits with the msb behing inserted (if unsigned)
fn serialize_var_int[size:Int8](tag: Int8, owned value: Bytes) -> Bytes:
    # Need to loop throught and change the first bit to 1 or 0
    reject_null_bytes_in_front(value)
    for i in range(len(value)):
        print("Before", value[i])
        value[i] ^= 0b10000000
        print("After", value[i])
    value[len(value)-1] ^= 0b10000000
    print("After Again", value[len(value)-1])

    # little endian
    # value.reverse()

    value.insert(0, ((tag) << 3))
    return value

fn serialize(tag: Int8, value: String) -> Bytes:
    return serialize_len(tag, value.as_bytes())

fn serialize(tag: Int8, value: Bytes) -> Bytes:
    return serialize_len(tag, value)

fn serialize(tag: Int8, value: UInt64) -> Bytes:
    var list = Bytes()
    alias SIZE_OF_VARIABLE = 64
    alias SIZE_OF_BYTE = 7

    # This is reversed
    for i in range(SIZE_OF_VARIABLE/SIZE_OF_BYTE + SIZE_OF_VARIABLE%SIZE_OF_BYTE):
        var num = (value >> (SIZE_OF_BYTE * i)) #& 0XFF
        var int8 = num.cast[DType.int8]()
        if int8 < 0:
            print("Uses mvb", 0b11111111 - (128 * (i-1)))
            int8 &= 0b11111111 - (128 * (i-1))
        print(hex(value), '->', hex(num), '=', hex(int8))
        #if int8 != 0x00:
        list.append(int8)

    return serialize_var_int[SIZE_OF_VARIABLE/SIZE_OF_BYTE](tag, list)