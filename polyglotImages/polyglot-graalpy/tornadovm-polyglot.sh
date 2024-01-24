#!/usr/bin/env bash

if [[ "$1" == "--console" ]]; then
    docker run -it -p 8080:8080 --rm --runtime=nvidia --gpus all -v "$PWD":/data beehivelab/tornadovm-polyglot-graalpy-23.1.0-nvidia-opencl-container:fosdem2024
elif [[ "$1" == "--help" ]] || [[ "$1" == "--h" ]]; then
    echo "Please run:"
    echo "  ./tornadovm-polyglot.sh --console		to launch the built image in which GraalPy interoperates with TornadoVM, or"
    echo "  ./tornadovm-polyglot.sh <command>		to launch the built image or execute a Python program that interoperates with TornadoVM, or"
    echo "  ./tornadovm-polyglot.sh --help		to print help message"
else
    docker run -it -p 8080:8080 --rm --runtime=nvidia --gpus all -v "$PWD":/data beehivelab/tornadovm-polyglot-graalpy-23.1.0-nvidia-opencl-container:fosdem2024 "$@"
fi
