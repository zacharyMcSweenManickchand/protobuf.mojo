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
    