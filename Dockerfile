FROM pytorch/pytorch:2.4.1-cuda11.8-cudnn9-runtime

# WORKDIR /app

# COPY app.py .
# COPY requirements.txt .

# RUN pip3 install -r requirements.txt

# EXPOSE 8501

# HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0", "--browser.gatherUsageStats false"]

WORKDIR /app

COPY dentateseg.sh .
COPY app.py .
COPY requirements.txt .
COPY main.py .
COPY localization_model_qsm.py .
COPY localization_qsm.py .
COPY nnunet_predict.py .
COPY utils.py .
COPY models/ ./models

RUN pip3 install -r requirements.txt

RUN chmod +x ./dentateseg.sh

ENTRYPOINT ["./dentateseg.sh"]

CMD ["-h"]