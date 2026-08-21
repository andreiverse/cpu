import sys

def parse_arguments(args, num, instr):
    if len(args) != num:
        print(f"received wrong number of arguments for {instr} instruction")
        exit(1)
    return args


def parse_register_name(r_name):
    if not r_name.startswith("R"):
        print("register names must start with R")
        exit(1)

    number = int(r_name[1:])

    if number < 0 or number > 15:
        print(f"register out of range: {r_name}")
        exit(1)

    return number


def parse_immediate(imm):
    value = int(imm, 0)

    if value < 0 or value > 255:
        print(f"immediate out of range: {imm}")
        exit(1)

    return value


def parse_address(addr):
    value = int(addr, 0)

    if value < 0 or value > 255:
        print(f"address out of range: {addr}")
        exit(1)

    return value


def parse_lines(lines):
    result = []

    for line in lines:
        line = line.split(";")[0].strip().upper()

        if line:
            result.append(line)

    return result


def assemble(lines):
    binary = []

    alu_ops = {
        "ADD":  "0001",
        "SUB":  "0010",
        "XOR":  "0011",
        "XNOR": "0100",
        "MOV":  "0101",
        "CMP":  "1111",
    }

    jump_ops = {
        "JMP": "0000",
        "JZ":  "0001",
        "JN":  "0010",
        "JC":  "0011",
        "JV":  "0100",
        "JNZ": "0101",
        "JNN": "0110",
        "JNC": "0111",
        "JNV": "1000",
    }

    for line in lines:
        parts = line.split(None, 1)

        op = parts[0]

        if len(parts) > 1:
            arguments = [x.strip() for x in parts[1].split(",")]
        else:
            arguments = []

        # NOP
        if op == "NOP":
            parse_arguments(arguments, 0, op)
            binary.append("0000000000000000")

        # ADD, SUB, XOR, XNOR, MOV, CMP
        elif op in alu_ops:
            args = parse_arguments(arguments, 2, op)

            rd = parse_register_name(args[0])
            rs = parse_register_name(args[1])

            binary.append(
                "0001"
                + alu_ops[op]
                + format(rd, "04b")
                + format(rs, "04b")
            )

        # INC
        elif op == "INC":
            args = parse_arguments(arguments, 1, op)

            rd = parse_register_name(args[0])

            binary.append(
                "00011000"
                + format(rd, "04b")
                + "0000"
            )

        # Jumps
        elif op in jump_ops:
            args = parse_arguments(arguments, 1, op)

            address = parse_address(args[0])

            binary.append(
                "0010"
                + jump_ops[op]
                + format(address, "08b")
            )

        # MOVI
        elif op == "MOVI":
            args = parse_arguments(arguments, 2, op)

            rd = parse_register_name(args[0])
            imm = parse_immediate(args[1])

            binary.append(
                "0011"
                + format(rd, "04b")
                + format(imm, "08b")
            )

        else:
            print(f"unknown instruction: {op}")
            exit(1)

    return binary


def write_hex(binary, filename):
    with open(filename, "w") as f:
        for instruction in binary:
            value = int(instruction, 2)
            f.write(f"{value:04X}\n")


with open(sys.argv[1]) as f:
    lines = parse_lines(f.readlines())

binary = assemble(lines)

write_hex(binary, "program.hex")