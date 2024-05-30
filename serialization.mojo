from protobuf import Bytes

# The tag is actually starts at `000`
# So if the Tag id is 2 is equal to `001`
fn serialize_len(tag: Int8, owned value: Bytes) -> Bytes:
    value.insert(0, ((tag-1) << 4) ^ 0x02)
    value.insert(1, len(value)-1)
    return value

fn serialize(tag: Int8, value: String) -> Bytes:
    return serialize_len(tag, value.as_bytes())

fn serialize(tag: Int8, value: UInt16) -> Bytes:
    pass