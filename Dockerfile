FROM ubuntu:22.04

RUN echo "Hello, World2!"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    python3.10 \
    python3-distutils \
    python3-pip \
    ffmpeg

ARG POETRY_VERSION=1.6.1

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1

WORKDIR /app

RUN pip install --upgrade pip && \
    pip install --no-cache-dir poetry==$POETRY_VERSION

COPY pyproject.toml pyproject.toml
RUN poetry install --no-root --only main


COPY start.sh start.sh
RUN chmod +x start.sh

RUN mkdir -p /app/video /app/transcribe
COPY audio /app/audio

RUN bash ./start.sh ./audio/privet-druzya.mp3

CMD ["bash", "/start.sh"]
