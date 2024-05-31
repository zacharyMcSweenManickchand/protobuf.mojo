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
    print("test_string_serialization()")
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
    print("test_byte_serialization()")
    var serialization = serialize(2, Bytes(123, 23, 32, 89))

    # View Bytes inside the array
    # for i in range(len(serialization)):
    #     print(serialization[i], hex(serialization[i]))
    # print()

    var expected_output = Bytes(0x12, 4, 123, 23, 32, 89)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_uint64_serialization() raises:
    """
    Testing UInt64 Serialization.
    """
    print("test_uint64_serialization()")
    var serialization = serialize(1, UInt64(0x34))

    # View Bytes inside the array
    # for i in range(len(serialization)):
    #     print(serialization[i], hex(serialization[i]))
    # print()

    var expected_output = Bytes(0x08, 0x34)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_uint64_serialization_2() raises:
    """
    Testing UInt64 Serialization.
    """
    print("test_uint64_serialization_2()")
    var serialization = serialize(1, UInt64(500))

    # View Bytes inside the array
    # for i in range(len(serialization)):
    #     print(serialization[i], hex(serialization[i]))
    # print()

    var expected_output = Bytes(0x08, 0xF4, 0x03)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_large_int64_serialization() raises:
    """
    This test checks if a unsigned interger that uses the first bit.
    Testing the overflow for `10000000 10000000 10000000`.
    """
    print("test_large_int64_serialization()")
    var serialization = serialize(1, UInt64(8421504))

    # View Bytes inside the array
    for i in range(len(serialization)):
        print(serialization[i], hex(serialization[i]))
    print()

    var expected_output = Bytes(0x08, 0x80, 0x81, 0x82, 0x04)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_large_int64_serialization_2() raises:
    """
    This test checks if a unsigned interger that uses the first bit.
    Testing the overflow for `11111111 11111111`.
    """
    print("test_large_int64_serialization_2()")
    var serialization = serialize(1, UInt64(65535))

    # View Bytes inside the array
    for i in range(len(serialization)):
        print(serialization[i], hex(serialization[i]))
    print()

    var expected_output = Bytes(0x08, 0xFF, 0xFF, 0x03)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        assert_equal(serialization[i], expected_output[i])


fn test_larger_int64_serialization() raises:
    """
    This test checks if a unsigned interger that uses the first bit.
    """
    print("test_larger_int64_serialization")
    var serialization = serialize(1, UInt64(9223372036854775807))

    # View Bytes inside the array
    for i in range(len(serialization)):
        print(serialization[i], hex(serialization[i]))
    print()

    var expected_output = Bytes(
        0x08, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC7F
    )
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        print(serialization[i], expected_output[i])
        assert_equal(serialization[i], expected_output[i])


fn test_bool_serialization() raises:
    """
    This function test the boolean encoding.
    Note: the implementation is probably incorrect since a the boolean takes a whole byte.
    """
    print("test_bool_serialization()")
    var serialization = serialize(1, True)

    # View Bytes inside the array
    for i in range(len(serialization)):
        print(serialization[i], hex(serialization[i]))
    print()

    var expected_output = Bytes(0x08, 0x01)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        print(serialization[i], expected_output[i])
        assert_equal(serialization[i], expected_output[i])


fn test_bool_serialization_false() raises:
    """
    This function test the boolean encoding.
    Note: the implementation is probably incorrect since a the boolean takes a whole byte.
    """
    print("test_bool_serialization_false()")
    var serialization = serialize(1, False)

    # View Bytes inside the array
    for i in range(len(serialization)):
        print(serialization[i], hex(serialization[i]))
    print()

    var expected_output = Bytes(0x08, 0x00)
    assert_equal(len(serialization), len(expected_output))
    for i in range(len(expected_output)):
        print(serialization[i], expected_output[i])
        assert_equal(serialization[i], expected_output[i])


fn main() raises:
    test_string_serialization()
    test_byte_serialization()
    test_uint64_serialization()
    test_uint64_serialization_2()
    test_large_int64_serialization()
    test_large_int64_serialization_2()
    test_larger_int64_serialization()
    test_bool_serialization()
    test_bool_serialization_false()
