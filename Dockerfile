FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-runtime

# Add a environment variable to indicate that the container is running in Docker
ENV RUNNING_IN_DOCKER=true
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8

WORKDIR /app

COPY config_manager.py .
COPY config.yaml .
COPY dentateseg.sh .
COPY localization_model_qsm.py .
COPY localization_qsm.py .
COPY log_manager.py .
COPY main.py .
COPY nnunet_predict.py .
COPY postprocessing.py .
COPY print_redirector.py .
COPY report.py .
COPY texture.py .
COPY utils.py .

# Models directory
COPY models/ ./models

# Requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Install dos2unix and fix line endings
RUN apt-get update && apt-get install -y dos2unix
RUN dos2unix ./dentateseg.sh && chmod +x ./dentateseg.sh

ENTRYPOINT ["./dentateseg.sh"]

CMD ["-h"]