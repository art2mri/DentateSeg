# DentateSeg

🚧 Work in progress!

Welcome to the **Cerebellar Dentate Nucleus Segmentation from QSM Images** project! This repository provides a deep learning pipeline designed to segment the dentate nucleus in Quantitative Susceptibility Mapping (QSM) images. The entire solution is containerized using Docker for seamless deployment.

## Getting started

### Requirements

Before running the segmentation pipeline, **Docker** must be installed on your operating system. Follow the instructions based on your OS: [Windows](https://docs.docker.com/desktop/install/windows-install/), [Linux](https://docs.docker.com/desktop/install/linux/), [macOS](https://docs.docker.com/desktop/install/mac-install/).

If you chose to install the Docker Engine on Linux, perform the optional [post-installation procedures](https://docs.docker.com/engine/install/linux-postinstall/).

Then, download the Docker image:
```bash
docker pull diogohs/dentateseg:0.1.0
```

### Usage

Once Docker is installed, you can run the segmentation pipeline using the following command:

**Windows:**
```bash
docker run -it --rm -v C:/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.1.0 -i QSM-IMAGE-FILEPATH -o OUTPUT-DIR
```

**Linux/Mac:**
```bash
docker run -it --rm --user $(id -u):$(id -g) -v ~/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.1.0 -i QSM-IMAGE-FILEPATH -o OUTPUT-DIR
```

If you have an NVIDIA GPU available and correctly configured, add the flags `--gpus=all` and `--gpu`. For instance, on Windows:

```bash
docker run -it --rm --gpus=all -v C:/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.1.0 -i QSM-IMAGE-FILEPATH -o OUTPUT-DIR --gpu
```

#### Explanation of the command

- `-v /path/to/your/QSM/images:/dentateseg-storage`: Mounts your local QSM images directory to the container path `/dentateseg-storage`
- `-i QSM-IMAGE-FILEPATH`: Replace `QSM-IMAGE-FILEPATH` with your actual QSM image filename with `.nii.gz` extension
- `-o OUTPUT-DIR`: Replace `OUTPUT-DIR` with a local directory to save the output data.

#### Example

Suppose that my QSM images are located at `C:/Users/John/qsm-data/`, my input QSM image is `QSM_image.nii.gz` and `dentateseg-output` is the output directory name. Then, the following command should be used for Linux/Mac with GPU support:

```bash
docker run -it --rm --user $(id -u):$(id -g) --gpus=all -v C:/Users/John/qsm-data/:/dentateseg-storage diogohs/dentateseg:0.1.0 -i QSM-IMAGE-FILEPATH -o dentateseg-output --gpu
```

#### Output

The segmented cerebellar dentate nucleus images will be saved in the specified output directory within your local machine.
Suppose that your input image has the filename `QSM_image.nii.gz`. The following files will be created:

```
OUTPUT-DIR/
└── QSM_image
    ├── QSM_image_cerebellar_mask.nii.gz
    ├── QSM_image_cropped.nii.gz
    ├── QSM_image_cropped_seg.nii.gz
    ├── QSM_image_metadata.json
    └── QSM_image_seg.nii.gz
```

The `QSM_image_seg.nii.gz` file is the dentate nucleus segmentation mask. The left side is labeled as 1 and the right side with the label 2.

## Reference

If you use DentateSeg in your project, please cite:

*Shiraishi D\*, Saha S\*, ... , Harding I, Rezende T, TRACK-FA Neuroimaging Consortium. (\*co-first). ***Automated Dentate Nucleus Segmentation from QSM Images Using Deep Learning***. medRxiv (2024). https://doi.org/10.1101/2024.06.17.24308662*

## Acknowledgments

This project was supported by the [Friedreich's Ataxia Research Alliance](https://www.curefa.org/) (FARA) and grants from the Australian National Health and Medical Research Council.

## Contact

For any questions or suggestions, please open an issue on the GitHub repository or [contact us](mailto:diogohshiraishi@gmail.com).
