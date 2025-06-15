import numpy as np
from PIL import Image

def generate_butterfly_texture(N=256):
    stages = int(np.log2(N))
    texture = np.zeros((stages,N, 4), dtype=np.float32)

    for stage in range(stages):
        num_blocks = 2 ** stage
        block_size = N // num_blocks

        for i in range(N):
            k = i % block_size
            twiddle_angle = -2 * np.pi * k / (block_size * 2)
            real = np.cos(twiddle_angle)
            fake = np.sin(twiddle_angle)

            # Assign the real and fake parts to the texture
            texture[stage, i, 0] = real # Use the r channel for the real part
            texture[stage, i, 1] = fake # Use the g chanel for the fake part
            texture[stage, i, 2] = 0.0  # unused b channel
            texture[stage, i, 3] = 1.0 #
    
    output = (texture * 0.5 + 0.5) * 255
    image = Image.fromarray(output.astype(np.uint8), 'RGBA')
    image = image.transpose(Image.Transpose.ROTATE_270)

    image.save('../Assets/butterfly_texture.png', 'PNG')

if __name__ == "__main__":
    generate_butterfly_texture(256)
    print("Butterfly texture generated and saved as 'butterfly_texture.png'.")