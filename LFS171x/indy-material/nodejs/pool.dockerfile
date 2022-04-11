FROM bcgovimages/von-image:py36-1.16-1

USER indy

RUN pip install --upgrade pip

RUN pip install --no-cache-dir aiosqlite
#RUN pip install aiosqlite

ENV RUST_LOG ${RUST_LOG:-warning}

RUN mkdir -p \
        $HOME/ledger/sandbox/data \
        $HOME/log \
        $HOME/.indy-cli/networks \
        $HOME/.indy_client/wallet && \
    chmod -R a+rw $HOME/log $HOME/ledger $HOME/.indy-cli $HOME/.indy_client

ADD --chown=indy:indy indy_config.py /etc/indy/

ADD --chown=indy:indy . $HOME

RUN sudo chmod uga+x scripts/* bin/*
