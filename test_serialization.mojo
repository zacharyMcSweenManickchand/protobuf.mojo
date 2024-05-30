from testing import assert_equal, assert_false, assert_true

from serialization import *


fn test_string_serialization() raises:
    """
    Test String Serialization:
    message Test2 {
        optional string b = 2;
    }
    .
    """
    var serialization = serialize(2, String("testing"))

    # View Bytes inside the array
    # for i in range(len(serialization)):
    #     print(serialization[i], hex(serialization[i]))
    # print()

    # var expected_output = 0x120774657374696e67
    var expected_output = Bytes(
        0x12, 0x07, 0x74, 0x65, 0x73, 0x74, 0x69, 0x6E, 0x67
    )
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_byte_serialization() raises:
    """
    Testing Byte Serialization.
    """
    var serialization = serialize(2, Bytes(123, 23, 32, 89))

    # View Bytes inside the array
    # for i in range(len(serialization)):
    #     print(serialization[i], hex(serialization[i]))
    # print()

    # var expected_output = 0x120774657374696e67
    var expected_output = Bytes(0x12, 4, 123, 23, 32, 89)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn main() raises:
    test_string_serialization()
    test_byte_serialization()
