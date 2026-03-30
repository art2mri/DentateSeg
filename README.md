# DentateSeg

Welcome to the **Cerebellar Dentate Nucleus Segmentation from QSM Images** project! This repository provides a deep learning pipeline designed to segment the dentate nucleus in Quantitative Susceptibility Mapping (QSM) images. The entire solution is containerized using Docker for seamless deployment.

## Table of contents
- [Getting started - Docker](#getting-started---docker)
- [Getting started - Apptainer](#getting-started---apptainer)
- [Output](#output)
- [Reference](#reference)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

## Getting started - Docker

### Requirements

Before running the segmentation pipeline, **Docker** must be installed on your operating system. Follow the instructions based on your OS: [Windows](https://docs.docker.com/desktop/install/windows-install/), [Linux](https://docs.docker.com/desktop/install/linux/), [macOS](https://docs.docker.com/desktop/install/mac-install/).

If you chose to install the Docker Engine on Linux, perform the optional [post-installation procedures](https://docs.docker.com/engine/install/linux-postinstall/).

Then, download the Docker image:
```bash
docker pull diogohs/dentateseg:0.3.2
```

### Usage

Once Docker is installed, you can run the segmentation pipeline using the following command:

**Windows:**
```bash
docker run -it --rm -v C:/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.3.2 -i INPUT-RESOURCE -o OUTPUT-DIR
```

**Linux/macOS:**
```bash
docker run -it --rm --user $(id -u):$(id -g) -v ~/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.3.2 -i INPUT-RESOURCE -o OUTPUT-DIR
```

If you have an NVIDIA GPU available and correctly configured, add the flags `--gpus=all` and `--gpu`. For instance, on Windows:

```bash
docker run -it --rm --gpus=all -v C:/path/to/your/QSM/images:/dentateseg-storage diogohs/dentateseg:0.3.2 -i INPUT-RESOURCE -o OUTPUT-DIR --gpu
```

#### Explanation of the command

- `-v /path/to/your/QSM/images:/dentateseg-storage`: Mounts your local QSM images directory to the container path `/dentateseg-storage`.
- `-i INPUT-RESOURCE`: This argument can be either a path to a directory containing images or a NIfTI file (`.nii.gz` extension).
- `-o OUTPUT-DIR`: Replace `OUTPUT-DIR` with a local directory to save the output data.

#### Example

Suppose that my QSM images are located at `/home/john/qsm-data`, my input QSM image is `QSM_image.nii.gz` and `dentateseg-output` is the output directory name. Then, the following command should be used for Linux/Mac with GPU support:

```bash
docker run -it --rm --user $(id -u):$(id -g) --gpus=all -v /home/john/qsm-data:/dentateseg-storage diogohs/dentateseg:0.3.2 -i QSM_image.nii.gz -o dentateseg-output --gpu
```

## Getting started - Apptainer

### Requirements

Before running the segmentation pipeline, **Apptainer** must be installed or enabled on your operating system.

Then, download the Docker image at the [Google Drive link](https://ggl.link/dentateseg-apptainer).
Ensure that the name of the downloaded container image is `dentateseg.sif`.
For the following steps, assume that the Apptainer image is located at `~/path/to/apptainer/dentateseg.sif`. 

### Usage

Once Apptainer is installed, you can run the segmentation pipeline using the following command:

**Linux/macOS:**
```bash
apptainer exec --pwd /app --writable-tmpfs --bind ~/path/to/your/QSM/images:/dentateseg-storage ~/path/to/apptainer/dentateseg.sif /app/dentateseg.sh -i INPUT-RESOURCE -o OUTPUT-DIR
```

If you have an NVIDIA GPU available and correctly configured, add the flags `--nv` and `--gpu`. For instance, on Linux:

```bash
apptainer exec --nv --pwd /app --writable-tmpfs --bind ~/path/to/your/QSM/images:/dentateseg-storage ~/path/to/apptainer/dentateseg.sif /app/dentateseg.sh -i INPUT-RESOURCE -o OUTPUT-DIR --gpu
```

#### Example

Suppose that my QSM images are located at `/home/john/qsm-data`, my input QSM image is `QSM_image.nii.gz`, the Apptainer image is at `/home/john/apptainer` and `dentateseg-output` is the output directory name. Then, the following command should be used for Linux/Mac with GPU support:

```bash
apptainer exec --nv --pwd /app --writable-tmpfs --bind /home/john/qsm-data:/dentateseg-storage /home/john/apptainer/dentateseg.sif /app/dentateseg.sh -i INPUT-RESOURCE -o OUTPUT-DIR --gpu
```

## Output

The segmented cerebellar dentate nucleus images will be saved in the specified output directory within your local machine.
Suppose that your input image has the filename `QSM_image.nii.gz`. The following files will be created:

```
OUTPUT-DIR/
└── QSM_image
    ├── QSM_image_cerebellar_mask.nii.gz      # Cerebellar localization mask
    ├── QSM_image_cropped.nii.gz              # Cropped image
    ├── QSM_image_cropped_seg.nii.gz          # Dentate binary segmentation on cropped image
    ├── QSM_image_cropped_seg_labeled.nii.gz  # Dentate labeled segmentation on cropped image
    ├── QSM_image_metadata.json               # Metadata supporting file
    ├── QSM_image_report.csv                  # Report and texture analysis in CSV
    ├── QSM_image_report.xlsx                 # Report and texture analysis in Excel
    └── QSM_image_seg.nii.gz                  # Final segmentation in original space
```

The `QSM_image_seg.nii.gz` file is the dentate nucleus segmentation mask. The left side is labeled as 1 and the right side with the label 2.
The Excel (.xlsx) and CSV report files contain a statistical analysis report and texture analysis.

## Reference

If you use DentateSeg in your project, please cite:

*Shiraishi, D. H.\*, Saha, S.\*, ... , Harding, I. H., Rezende, T. J. R., TRACK-FA Neuroimaging Consortium. (\*co-first). ***Automated Deep Learning-based Segmentation of the Dentate Nucleus Using Quantitative Susceptibility Mapping MRI***. Radiology: Artificial Intelligence (2025). https://doi.org/10.1148/ryai.240478*

## Acknowledgments

This project was supported by the [Friedreich's Ataxia Research Alliance](https://www.curefa.org/) (FARA) and grants from the Australian National Health and Medical Research Council.

## Contact

For any questions or suggestions, please open an issue on the GitHub repository or [contact us](mailto:diogohshiraishi@gmail.com).


<p align="center">
  <a href="https://mapmyvisitors.com/web/1c3jk">
    <img src="https://mapmyvisitors.com/map.png?cl=0e1633&w=384&t=tt&d=mZonDOf4Sqmt8KwyD37jlJOLRUViWbBTuGPkC5_V3YE&co=0b4975&ct=cdd4d9" width="384" />
  </a>
</p>
