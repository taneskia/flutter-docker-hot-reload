FROM  cirrusci/flutter:3.7.7 AS build

RUN apt update
RUN apt install -y tmux inotify-tools net-tools

RUN mkdir /app/
WORKDIR /app/

COPY ./entrypoint.sh ./entrypoint.sh

EXPOSE 8080

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
