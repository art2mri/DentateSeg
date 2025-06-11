FROM pytorch/pytorch:2.4.1-cuda11.8-cudnn9-runtime

WORKDIR /app

COPY dentateseg.sh .
COPY requirements.txt .
COPY main.py .
COPY localization_model_qsm.py .
COPY localization_qsm.py .
COPY nnunet_predict.py .
COPY postprocessing.py .
COPY utils.py .
COPY models/ ./models

RUN pip3 install -r requirements.txt

RUN chmod +x ./dentateseg.sh

ENTRYPOINT ["./dentateseg.sh"]

CMD ["-h"]