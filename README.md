# Docker for TornadoVM

[![](https://img.shields.io/badge/License-Apache%202.0-orange.svg)](https://opensource.org/licenses/Apache-2.0)

We have two docker configurations for TornadoVM using 2 different JDKs:

* TornadoVM Docker for **NVIDIA GPUs**: See [instructions](https://github.com/beehive-lab/docker-tornado#nvidia-gpus)
    * JDKs supported:
	    * TornadoVM with OpenJDK 17
		* TornadoVM with GraalVM 22.3.1 and JDK 17
* TornadoVM Docker for **Intel Integrated Graphics, Intel CPUs, and Intel FPGAs (Emulated Mode)**: See [instructions](https://github.com/beehive-lab/docker-tornado#intel-integrated-graphics)
    * JDKs supported:
	    * TornadoVM with OpenJDK 17
		* TornadoVM with GraalVM 22.3.1 and JDK 17

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

## Run Matrix Multiplication - provided in the docker-tornado repositoryu
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
$ ./run_nvidia.sh tornado --jvm="-Xmx16g -Xms16g" example/MatrixMultiplication
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
$ ./run_intel_openjdk.sh tornado -cp example/target/example-1.0-SNAPSHOT.jar example.MatrixMultiplication --params "256"

Computing MxM of 256x256
	CPU Execution: 1.53 GFlops, Total time = 22 ms
	GPU Execution: 8.39 GFlops, Total Time = 4 ms
	Speedup: 5x
```

### Running on FPGAs (Emulation mode)? 

The TornadoVM docker image for the Intel platforms contain the FPGA in device `1:0`. 
To offload a Java application onto an FPGA, you can use the following command (example running the DFT application).

```bash
$ ./run_intel_openjdk.sh tornado --threadInfo  --jvm="-Ds0.t0.device=1:0" -m tornado.examples/uk.ac.manchester.tornado.examples.dynamic.DFTDynamic --params="256 default 1"
WARNING: Using incubator modules: jdk.incubator.foreign, jdk.incubator.vector
Initialization time:  1066024424 ns
 
Task info: s0.t0
        Backend           : OPENCL
        Device            : Intel(R) FPGA Emulation Device CL_DEVICE_TYPE_ACCELERATOR (available)
        Dims              : 1
        Global work offset: [0]
        Global work size  : [256]
        Local  work size  : [64, 1, 1]
        Number of workgroups  : [4]
 
Total time:  276927741 ns 
 
Is valid?: true
 
Validation: SUCCESS 
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

