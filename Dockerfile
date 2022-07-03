FROM python:3.8-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirement.txt /requirement.txt

RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers

RUN pip install -r /requirement.txt
RUN apk del .tmp

RUN mkdir /todo_list
COPY ./todo_list /todo_list
WORKDIR /todo_list
COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media

RUN mkdir -p /vol/web/static

RUN adduser -D user
RUN chown -R user:user /vol
RUN chown -R user:user /todo_list
RUN chmod 755 /vol/web
USER user


CMD ["entrypoint.sh"]
