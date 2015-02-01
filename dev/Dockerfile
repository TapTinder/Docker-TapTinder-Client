FROM mj41/local-tt-client:my
MAINTAINER Michal Jurosz <docker@mj41.cz>

WORKDIR /home/ttucl/tt-client

COPY dev_image_update-copy /home/ttucl/
COPY docker_param/* /home/ttucl/docker_param/
RUN /home/ttucl/dev_image_update-copy
