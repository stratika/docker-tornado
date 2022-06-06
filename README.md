# Docker for TornadoVM

[![](https://img.shields.io/badge/License-Apache%202.0-orange.svg)](https://opensource.org/licenses/Apache-2.0)

We have two docker configurations for TornadoVM using 2 different JDKs:

* TornadoVM Docker for **NVIDIA GPUs**: See [instructions](https://github.com/beehive-lab/docker-tornado#nvidia-gpus)
    * JDKs supported:
	    * TornadoVM with OpenJDK 17
		* TornadoVM with GraalVM 21.3.0 and JDK 17
* TornadoVM Docker for **Intel Integrated Graphics, Intel CPUs, and Intel FPGAs (Emulated Mode)**: See [instructions](https://github.com/beehive-lab/docker-tornado#intel-intergrated-graphics)
    * JDKs supported:
	    * TornadoVM with OpenJDK 17
		* TornadoVM with GraalVM 21.3.0 and JDK 17

## Nvidia GPUs

### Prerequisites

The `tornadovm-nvidia-openjdk` docker image needs the docker `nvidia` daemon.  More info here: [https://github.com/NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

### How to run?

1) Pull the image

For the `tornadovm-nvidia-openjdk` image:
```bash
$ docker pull beehivelab/tornadovm-nvidia-openjdk:latest
```

This image uses the latest TornadoVM for NVIDIA GPUs and OpenJDK 17.

2) Run an experiment

We provide a runner script that compiles and run your Java programs with Tornado. Here's an example:

```bash
$ git clone https://github.com/beehive-lab/docker-tornado
$ cd docker-tornado

## Run Matrix Multiplication - provided in the docker-tornado repository
$ ./run_nvidia_openjdk.sh tornado -cp example/target/example-1.0-SNAPSHOT.jar example.MatrixMultiplication

Computing MxM of 2048x2048
	CPU Execution: 0.36 GFlops, Total time = 48254 ms
	GPU Execution: 277.09 GFlops, Total Time = 62 ms
	Speedup: 778x 
```

### Using TornadoVM with GraalVM for NVIDIA GPUs

With JDK 17:

```bash
$ docker pull beehivelab/tornadovm-nvidia-graalvm:latest
```

### Some options

```bash
# To see the generated OpenCL kernel
$ ./run_nvidia.sh tornado --printKernel example/MatrixMultiplication

# To check some runtime info about the kernel execution and device
$ ./run_nvidia.sh tornado --debug example/MatrixMultiplication
```

The `tornado` command is just an alias to the `java` command with all the parameters for TornadoVM execution. So you can pass any Java (OpenJDK or Hotspot) parameter.

```bash
$ ./run_nvidia.sh tornado -Xmx16g -Xms16g example/MatrixMultiplication
```

## Intel Integrated Graphics

### Prerequisites

The `beehivelab/tornadovm-intel-openjdk` docker image Intel OpenCL driver for the integrated GPU installed.  More info here: [https://github.com/intel/compute-runtime](https://github.com/intel/compute-runtime).

### How to run?

1) Pull the image

For the `beehivelab/tornadovm-intel-openjdk` image:
```bash
$ docker pull beehivelab/tornadovm-intel-openjdk:latest
```

This image uses the latest TornadoVM for Intel integrated graphics and OpenJDK 17.

2) Run an experiment

We provide a runner script that compiles and run your Java programs with Tornado. Here's an example:

```bash
$ git clone https://github.com/beehive-lab/docker-tornado
$ cd docker-tornado

## Run Matrix Multiplication - provided in the docker-tornado repository
$ ./run_intel_openjdk.sh tornado -cp example/target/example-1.0-SNAPSHOT.jar example.MatrixMultiplication 256

Computing MxM of 256x256
	CPU Execution: 1.53 GFlops, Total time = 22 ms
	GPU Execution: 8.39 GFlops, Total Time = 4 ms
	Speedup: 5x
```

### Using TornadoVM with GraalVM for Intel Integrated Graphics

With JDK 17:

```bash
$ docker pull beehivelab/tornadovm-intel-graalvm:latest
```


Enjoy Tornado!! 

Docker scripts have been inspired by [blang/latex-docker](https://github.com/blang/latex-docker)


## License

This project is developed at [The University of Manchester](https://www.manchester.ac.uk/), and it is fully open source under the [Apache 2](https://github.com/beehive-lab/docker-tornado/blob/master/LICENSE) license.

