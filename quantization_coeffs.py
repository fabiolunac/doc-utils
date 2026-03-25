NBITS = 10


def to_twos_complement(value, bits):
    if value < 0:
        value = (1 << bits) + value
    return format(value, f'0{bits}b')

def quantization(coeffs, Q):
    coeffs_quant = [int(c * Q) for c in coeffs]

    return coeffs_quant

def main():
    coeffs = [1, -2.5, 2.5, -1.25, 0.3125, -0.03125]

    coeffs_quant = quantization(coeffs, 256)
    print(coeffs_quant)

    for c in coeffs_quant:
        print(to_twos_complement(c, NBITS))



if __name__ == "__main__":
    main() 