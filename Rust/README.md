[crates.io](https://crates.io/crates/fastnoise-lite) • [docs.rs](https://docs.rs/fastnoise-lite/latest/bezier_rs/) • [repo](https://github.com/GraphiteEditor/Graphite/tree/master/libraries/fastnoise-lite)

# FastNoise Lite

FastNoise Lite is an extremely portable open source noise generation library with a large selection of noise algorithms. This library focuses on high performance while avoiding platform/language specific features, allowing for easy ports to as many possible languages.

## Features

- 2D & 3D
- OpenSimplex2 Noise
- OpenSimplex2S Noise
- Cellular (Voronoi) Noise
- Perlin Noise
- Value Noise
- Value Cubic Noise
- OpenSimplex2-based Domain Warp
- Basic Grid Gradient Domain Warp
- Multiple fractal options for all of the above
- Supports floats and/or doubles
  - Switch from `f32` to `f64` position inputs with the `"f64"` feature flag in your `Cargo.toml`

## Getting Started

Below is an example for creating a 128x128 array of OpenSimplex2 noise.

Additional documentation is available at [docs.rs](https://docs.rs/fastnoise-lite/latest/bezier_rs/) and the project's [Getting Started](https://github.com/Auburn/FastNoiseLite/wiki#getting-started) and [Documentation](https://github.com/Auburn/FastNoiseLite/wiki/Documentation) pages from its GitHub wiki.

```rs
use fastnoise_lite::*;

// Create and configure FastNoise object
let mut noise = FastNoiseLite::new();
noise.SetNoiseType(NoiseType::OpenSimplex2);

// Gather noise data
const WIDTH: usize = 128;
const HEIGHT: usize = 128;

let mut noise_data = [0.; WIDTH * HEIGHT];

for y in 0..HEIGHT {
    for x in 0..WIDTH {
        // Enable `features = ["f64"]` in Cargo.toml to pass f64 values here instead of f32.
        // Use `noise.get_noise_3d(x, y, z)` for 3D noise instead of 2D.
        noise_data[WIDTH * y + x] = noise.get_noise_2d(x as f32, y as f32);
    }
}

// Do something with this data...
```