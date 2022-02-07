FROM rocker/r-ver:devel

ADD install_everything.sh /tmp/

RUN echo "R_LIBS=/usr/local/lib/R/host-site-library:\${R_LIBS}" > /usr/local/lib/R/etc/Renviron.site

## comment this line if you don't want to set up your emacs like an R programmer
ADD dot-emacs.el /root/.emacs

RUN bash /tmp/install_everything.sh
