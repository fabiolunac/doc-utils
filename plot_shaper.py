import matplotlib.pyplot as plt



def read_txt(path):
    values = []

    with open(path, "r") as file:
        for line in file:
            values.append(int(line.strip()))

    return values

def reverse_quantization(shaper_out, Gx, Gy):
    shaper_out_dq = [c/(Gx*Gy) for c in shaper_out]

    return shaper_out_dq

def plot_shaper(shaper_out, N=200):
    plt.figure()
    plt.plot(shaper_out[0:N], marker='o')
    plt.grid(alpha=0.2)
    plt.title('Shaper Impulse Response')
    plt.xlabel('Sample')
    plt.ylabel('Amplitude')


def main():
    Gx = pow(2, 15)
    Gy = pow(2, 32)
    path = 'shaper_electronics_tb.txt' 
    
    shaper_out = read_txt(path)
    shaper_out_dq = reverse_quantization(shaper_out, Gx, Gy)

    # plot_shaper(shaper_out)
    plot_shaper(shaper_out_dq)

    plt.show()


if __name__ == "__main__":
    main() 