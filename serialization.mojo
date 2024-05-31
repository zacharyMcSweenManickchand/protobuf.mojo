from protobuf import Bytes


fn serialize_len(tag: Int8, owned value: Bytes) -> Bytes:
    value.insert(0, ((tag) << 3) ^ 0x02)
    value.insert(1, len(value) - 1)
    return value


fn reject_null_bytes_in_front(inout arr: Bytes):
    """
    This function reject the 0x00 bytes that are in the front of the array.
    Since the array is backward already the loop is reversed.
    """
    var index = len(arr) - 1
    while index > 0 and arr[index] == 0x00:
        _ = arr.pop(index)
        index -= 1


fn serialize_var_int(tag: Int8, owned value: Bytes) -> Bytes:
    reject_null_bytes_in_front(value)
    for i in range(len(value)):
        value[i] ^= 0b10000000
    value[len(value) - 1] ^= 0b10000000

    # little endian
    # value.reverse()

    value.insert(0, ((tag) << 3))
    return value


fn serialize(tag: Int8, value: String) -> Bytes:
    return serialize_len(tag, value.as_bytes())


fn serialize(tag: Int8, value: Bytes) -> Bytes:
    return serialize_len(tag, value)


fn serialize(tag: Int8, value: Bool) -> Bytes:
    return serialize_var_int(tag, Bytes(1 if value else 0))


# Not supported in the language yet
# fn serialize(tag: Int8, value: Enum) -> Bytes:
#     pass


fn serialize(tag: Int8, value: UInt64) -> Bytes:
    var list = Bytes()
    alias SIZE_OF_VARIABLE = 64
    alias SIZE_OF_BYTE = 8 - 1  # Because we are removing the msb

    # This is reversed
    for i in range((SIZE_OF_VARIABLE / SIZE_OF_BYTE)):
        var num = value >> ((SIZE_OF_BYTE * i))
        var int8 = num.cast[DType.int8]()

        if int8 < 0:
            int8 ^= 0b10000000
        # print(hex(value), "->", hex(num), "=", hex(int8))
        list.append(int8)

    return serialize_var_int(tag, list)


fn serialize(tag: Int8, value: UInt32) -> Bytes:
    pass


fn serialize(tag: Int8, value: UInt16) -> Bytes:
    pass


fn serialize(tag: Int8, value: UInt8) -> Bytes:
    pass


fn serialize(tag: Int8, value: Int64) -> Bytes:
    pass


fn serialize(tag: Int8, value: Int32) -> Bytes:
    pass


fn serialize(tag: Int8, value: Int16) -> Bytes:
    # If their no way to do this just act its a `Int32`
    pass


fn serialize(tag: Int8, value: Int8) -> Bytes:
    # If their no way to do this just act its a `Int32`
    pass


fn serialize_fixed(tag: Int8, value: Int64) -> Bytes:
    pass


fn serialize_fixed(tag: Int8, value: Int32) -> Bytes:
    pass
