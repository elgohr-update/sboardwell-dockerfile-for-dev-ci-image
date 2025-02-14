FROM ubuntu:20.04

ENV JVM_OPTS=-Xmx4g
ENV LEIN_ROOT=true
ENV CHROME_BIN=/usr/local/bin/chrome-wrapper
ENV DISPLAY=:99

SHELL ["/bin/bash", "-c"]

# Every RUN command creates an intermediate layer. Every additional layer has a massive performance
# impact on the 'Initialize containers' step in GitHub Actions, which in turn is by far the most
# significant step in duration in most GitHub Actions workflows. Therefore we execute and cleanup
# everything in a single RUN command to maximise performance.
RUN \
    # Just like RUN commands, every ENV line creates a new intermediate layer. So ENV lines are
    # reserved only for those environment variables that must persist after this RUN script has
    # completed.
    export JVM_VERSION="11" && \
    export LEIN_VERSION="2.9.5" && \
    export LEIN_INSTALL="/usr/local/bin" && \
    export LEIN_SHA256SUM="3601d55c4b5ac5c654e4ebd0d75abf7ad683f48cba8a7af1a8730b6590187b8a" && \
    export LEIN_GPGKEY="20242BACBBE95ADA22D0AFD7808A33D379C806C3" && \
    export CLOJURE_VERSION="1.10.2.796" && \
    export CLOJURE_SHA256SUM="0ea8633c7f53eb76098132d4a4536169395be24bbdc253cff4d10251e2ea6e45" && \
    export BOOT_INSTALL="/usr/local/bin" && \
    export BOOT_VERSION="2.8.3" && \
    export BOOT_SHA256SUM="0ccd697f2027e7e1cd3be3d62721057cbc841585740d0aaa9fbb485d7b1f17c3" && \
    export BABASHKA_VERSION="0.2.13" && \
    export BABASHKA_SHA256SUM="7fb8a5815a343698d0d66dad5da2d6631fbe4cf97b7a21ac52c5d10dbe3a7c2c" && \
    export CLJ_KONDO_VERSION="2021.03.03" && \
    export CLJ_KONDO_SHA256SUM="5b34edc5ff386fa33d49a75a64c22539032905020558fcd0f41a593d794cf584" && \
    export LUMO_VERSION="1.10.1" && \
    export KARMA_CLI_VERSION="2.0.0" && \
    export DIFF_SO_FANCY_VERSION="1.3.0" && \
    export GH_VERSION="1.7.0" && \
    export GH_SHA256SUM="1907a1094cb7eb5218ca4e22a27229849e9a2bfc07ad4e83e1cbf43487b9c1bc" && \
    export BAT_VERSION="0.18.0" && \
    export BAT_SHA256SUM="6bff050d021682ec9acee2b982d03c00a958bf5aafce88b5f5e95e59e0a7af6a" && \
    export FD_VERSION="8.2.1" && \
    export FD_SHA256SUM="f3a949325f1893145ced2b269a67d5763af3bede435c40e3b85b29afdb78c3d2" && \
    export HEXYL_VERSION="0.8.0" && \
    export HEXYL_SHA256SUM="2e85c60264161ba7b99d294e0eda1664b1df776a709286db942416e494168761" && \
    export RIPGREP_VERSION="12.1.1" && \
    export RIPGREP_SHA256SUM="18ef498312073da55d2f2f65c6a906085c68368a23c9a45a87fcb8539be96608" && \
    export EXA_VERSION="0.9.0" && \
    export EXA_SHA256SUM="53d8746b1ca2d945c5b75767edc83addfd1fe3c4a2b0b766c07172473330a50b" && \
    export WEBSOCAT_VERSION="1.7.0" && \
    export WEBSOCAT_SHA256SUM="ab8805344dcf225f0383bd359fe5c9fba8f3c0af7ca2f891cc727f8dce00b147" && \
    export PUEUE_VERSION="0.12.0" && \
    export PUEUE_SHA256SUM="4bed4517edbf2491f55b346ad9947b3cec526a96cd0cc81224f299fdb1a186b3" && \
    export PUEUED_SHA256SUM="f2fa8d5372c5c217808b5fe48200b2a7b2649159b2c9f69601a047b1cb61f524" && \
    export POWERSHELL_VERSION="7.1.2" && \
    export POWERSHELL_SHA256SUM="23639edff0487fe084d011767c67d35d55f37a22bd00cd0bb48acddff9f217b8" && \
    export DOCKER_VERSION="20.10.5" && \
    export DOCKER_SHA256SUM="3f18edc66e1faae607d428349e77f9800bdea554528521f0f6c49fc3f1de6abf" && \
    export DOCKER_COMPOSE_VERSION="1.28.5" && \
    export DOCKER_COMPOSE_SHA256SUM="46406eb5d8443cc0163a483fcff001d557532a7fad5981e268903ad40b75534c" && \
    export KUBECTL_VERSION="1.20.4" && \
    export KUBECTL_SHA256SUM="98e8aea149b00f653beeb53d4bd27edda9e73b48fed156c4a0aa1dabe4b1794c" && \
    export GIT_GPGKEY="E1DD270288B4E6030699E45FA1715D88E1DF1F24" && \
    export NEOVIM_GPGKEY="9DBB0BE9366964F134855E2255F96FCF8231B6DD" && \
    export PLANCK_GPGKEY="A5D6812987A6E53579AF0308D3D743111F327606" && \
    export CHROMIUM_VERSION="56.0.2924.0" && \
    export CHROMIUM_PACKAGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F433062%2Fchrome-linux.zip?generation=1479441205933000&alt=media" && \
    export CHROMIUM_SHA256SUM="5e2e38ffbed6ff9bef287026c8d2628b12b5a43b5bf7c235bfa182e7fd5d213f" && \
    export CHROMEDRIVER_VERSION="2.29" && \
    export CHROMEDRIVER_SHA256SUM="bb2cf08f2c213f061d6fbca9658fc44a367c1ba7e40b3ee1e3ae437be0f901c2" && \
    export PHANTOMJS_VERSION="2.1.1" && \
    export PHANTOMJS_SHA256SUM="86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f" && \
    export DEBIAN_FRONTEND="noninteractive" && \
    export DOTFILES_BASE_URI="https://raw.githubusercontent.com/day8/dockerfile-for-dev-ci-image/master/dotfiles/" && \

    cd /tmp && \

    # Turn on Bash extended glob support so we can use patterns like !("file1"|"file2")
    shopt -s extglob && \

    apt-get update -qq && \
    apt-get dist-upgrade -qq -y && \
    echo '\n\n' && \

    # Install tools needed by the subsequent commands.
    apt-get install -qq -y --no-install-recommends \
        locales tzdata \
        ca-certificates gnupg \
        curl wget \
        unzip && \
    echo '\n\n' && \

    # Set the default locale to en_AU.UTF-8
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_AU.UTF-8 UTF-8/en_AU.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    echo 'LANG="en_AU.UTF-8"' > /etc/default/locale && \
    dpkg-reconfigure locales && \
    update-locale LANG=en_AU.UTF-8 && \

    # Set the default timezone to Australia/Sydney.
    ln -s --force /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
    dpkg-reconfigure tzdata && \

    # When adding PPAs do not depend on `software-properties-common` for the `add-apt-repository`
    # command as that adds several hundred megabytes of dependencies.
    echo "Adding 'Git stable releases' PPA..." && \
    echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu focal main" > /etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $GIT_GPGKEY && \
    echo '\n\n' && \

    # The 'Neovim Stable' PPA provides 0.4.x which is extremely out of date to the point of being
    # unusable so uses the 'Neovim Unstable' PPA for 0.5.x instead.
    echo "Adding 'Neovim Unstable' PPA..." && \
    echo "deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu focal main" >  /etc/apt/sources.list.d/neovim-ppa-ubuntu-unstable-focal.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $NEOVIM_GPGKEY && \
    echo '\n\n' && \

    echo "Adding 'Mike Fikes's Planck' PPA..." && \
    echo "deb http://ppa.launchpad.net/mfikes/planck/ubuntu focal main" > /etc/apt/sources.list.d/mfikes-ubuntu-planck-focal.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $PLANCK_GPGKEY && \
    echo '\n\n' && \

    # Git Large File Storage is required when cloning any Git repository that uses the Git LFS
    # Specification. See https://github.com/git-lfs/git-lfs
    echo "Adding Git LFS package repository..." && \
    curl -sSL https://packagecloud.io/github/git-lfs/gpgkey | apt-key add - && \
    echo "deb https://packagecloud.io/github/git-lfs/ubuntu/ focal main" > /etc/apt/sources.list.d/github_git-lfs.list && \
    echo '\n\n' && \

    echo "Adding NodeSource's Node.js v14.x package repository..." && \
    echo "deb https://deb.nodesource.com/node_14.x focal main" > /etc/apt/sources.list.d/nodesource.list && \
    curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo '\n\n' && \

    echo "Adding Yarn package repository..." && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo '\n\n' && \

    # Refresh package lists after adding package repositories.
    apt-get update -qq && \

    # Begin /docker-entrypoint.sh script. This is amended throughout the RUN
    # command with additional lines.
    echo '#!/bin/bash' > /docker-entrypoint.sh && \

    # Install development tooling, common editors and language runtimes.
    apt-get install -qq -y --no-install-recommends \
      git git-lfs diffstat jq silversearcher-ag fzf \
      neofetch ncdu htop zstd \
      rlwrap less tmux openssh-client mosh \
      neovim emacs-nox \
      zsh build-essential cmake openjdk-$JVM_VERSION\-jdk-headless nodejs yarn python2 python3-pip planck \
      pngnq pngquant pngtools pngmeta pngcrush pngcheck \
      jhead jpeginfo jpegoptim jpegpixi \
    # These are dependencies of powershell
      liblttng-ust-ctl4 liblttng-ust0 \
    # These are dependencies of xvfb and/or Chrome. Unfortunately due to the old version of Chrome
    # used (56.x) there is a dependency on old libraries like libgtk2.0-0 that take up a lot of
    # extra space.
      xvfb libxcomposite1 libxcursor1 libxss1 libxrandr2 libgtk2.0-0 libgconf-2-4  \
    # Voting in the popularity contest may help keep packages we use supported by Ubuntu.
      popularity-contest && \
    rm -rf /var/lib/apt/lists/* && \
    echo '\n\n' && \

    # Start a X11 virtual framebuffer to run tests in Chrome.
    echo 'Xvfb :99 -screen 0 1920x1080x24 &\n' >> /docker-entrypoint.sh && \

    # Install Clojure:
    echo "Installing 'Official' Clojure CLI ${CLOJURE_VERSION}..." && \
    wget -q "https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh" && \
    echo "Verifying linux-install-$CLOJURE_VERSION.sh checksum..." && \
    sha256sum linux-install-$CLOJURE_VERSION.sh && \
    echo "$CLOJURE_SHA256SUM *linux-install-$CLOJURE_VERSION.sh" | sha256sum -c - && \
    chmod +x linux-install-$CLOJURE_VERSION.sh && \
    ./linux-install-$CLOJURE_VERSION.sh && \
    rm -f "linux-install-${CLOJURE_VERSION}.sh" && \
    clojure -e "(clojure-version)" && \
    echo '\n\n' && \

    # Install Leiningen:
    echo "Installing Leiningen ${LEIN_VERSION}..." && \
    mkdir -p $LEIN_INSTALL && \
    wget -q https://raw.githubusercontent.com/technomancy/leiningen/$LEIN_VERSION/bin/lein-pkg && \
    echo "Verifying lein-pkg checksum..." && \
    sha256sum lein-pkg && \
    echo "$LEIN_SHA256SUM *lein-pkg" | sha256sum -c - && \
    mv lein-pkg $LEIN_INSTALL/lein && \
    chmod 0755 $LEIN_INSTALL/lein && \
    wget -q "https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip" && \
    wget -q "https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip.asc" && \
    gpg --batch --keyserver keys.openpgp.org --recv-key $LEIN_GPGKEY && \
    echo "Verifying leiningen-$LEIN_VERSION-standalone.zip PGP signature..." && \
    gpg --batch --verify leiningen-$LEIN_VERSION-standalone.zip.asc leiningen-$LEIN_VERSION-standalone.zip && \
    rm leiningen-$LEIN_VERSION-standalone.zip.asc && \
    mkdir -p /usr/share/java && \
    mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar && \
    mkdir -p /root/.lein && \
    wget -q -O /root/.lein/profiles.clj "${DOTFILES_BASE_URI}/.lein/profiles.clj" && \
    echo '\n\n' && \

    # Install Boot:
    echo "Installing Boot..." && \
    mkdir -p $BOOT_INSTALL && \
    wget -q "https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh" && \
    echo "Verifying boot.sh checksum..." && \
    sha256sum boot.sh && \
    echo "$BOOT_SHA256SUM *boot.sh" | sha256sum -c - && \
    mv boot.sh $BOOT_INSTALL/boot && \
    chmod 0755 $BOOT_INSTALL/boot && \
    echo '\n\n' && \

    # Install babashka:
    echo "Installing babashka..." && \
    wget -q "https://github.com/babashka/babashka/releases/download/v${BABASHKA_VERSION}/babashka-${BABASHKA_VERSION}-linux-amd64.zip" && \
    echo "Verifying babashka-${BABASHKA_VERSION}-linux-amd64.zip" && \
    sha256sum "babashka-${BABASHKA_VERSION}-linux-amd64.zip" && \
    echo "${BABASHKA_SHA256SUM} *babashka-${BABASHKA_VERSION}-linux-amd64.zip" | sha256sum -c - && \
    unzip "babashka-${BABASHKA_VERSION}-linux-amd64.zip" -d /usr/local/bin && \
    bb --version && \

    # Install clj-kondo:
    echo "Installing clj-kondo..." && \
    wget -q "https://github.com/clj-kondo/clj-kondo/releases/download/v${CLJ_KONDO_VERSION}/clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" && \
    echo "Verifying clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" && \
    sha256sum "clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" && \
    echo "$CLJ_KONDO_SHA256SUM *clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" | sha256sum -c - && \
    unzip "clj-kondo-${CLJ_KONDO_VERSION}-linux-amd64.zip" -d /usr/local/bin && \
    clj-kondo --version && \

    # Install pipenv
    echo "Installing pipenv..." && \
    pip3 -q install pipenv && \
    echo '\n\n' && \

    # Install AWS CLI
    echo "Installing AWS CLI..." && \
    pip3 -q install awscli && \
    echo '\n\n' && \

    # Install yq (jq wrapper for YAML and XML)
    echo "Installing yq..." && \
    pip3 -q install yq && \
    echo '\n\n' && \

    # Install pytest
    echo "Installing pytest..." && \
    pip3 -q install pytest && \
    echo '\n\n' && \

    # Install flake8
    # Ref: https://gitlab.com/pycqa/flake8
    echo "Installing flake8..." && \
    pip3 -q install flake8 && \
    echo '\n\n' && \

    # Install Docker
    # Origin: https://download.docker.com/linux/static/stable/x86_64/
    echo "Installing Docker ${DOCKER_VERSION}..." && \
    wget -q "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    echo "Verifying docker-${DOCKER_VERSION}.tgz checksum..." && \
    sha256sum "docker-${DOCKER_VERSION}.tgz" && \
    echo "${DOCKER_SHA256SUM} *docker-${DOCKER_VERSION}.tgz" | sha256sum -c - && \
    tar -xzC /usr/local/bin --strip-components=1 -f "docker-${DOCKER_VERSION}.tgz" && \
    rm -f "docker-${DOCKER_VERSION}.tgz" && \

    # Install Docker Compose
    echo "Installing Docker Compose ${DOCKER_COMPOSE_VERSION}..." && \
    wget -q "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64" && \
    echo "Verifying docker-compose-Linux-x86_64 checksum..." && \
    sha256sum "docker-compose-Linux-x86_64" && \
    echo "${DOCKER_COMPOSE_SHA256SUM} *docker-compose-Linux-x86_64" | sha256sum -c - && \
    mv "docker-compose-Linux-x86_64" /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \

    # Install Kubectl
    echo "Installing Kubectl ${KUBECTL_VERSION}..." && \
    wget -q "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    echo "Verifying Kubectl checksum..." && \
    sha256sum kubectl && \
    echo "${KUBECTL_SHA256SUM} *kubectl" | sha256sum -c - && \
    mv kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl && \

    # Install gh
    #
    # GitHub's official command line tool.
    #
    # To update to a new release:
    # 1. Open https://github.com/cli/cli/releases/
    # 2. Download gh_VERSION_linux_amd64.deb for the desired version
    # 3. Run `sha256sum gh_VERSION_linux_amd64.deb`
    # 4. Copy/paste the checksum to GH_SHA256SUM in environment variables at the beginning of this RUN script
    # 5. Edit the GH_VERSION in environment variables at the beginning of this RUN script
    echo "Installing gh ${GH_VERSION}..." && \
    wget -q "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.deb" && \
    echo "Verifying gh_${GH_VERSION}_linux_amd64.deb checksum..." && \
    sha256sum "gh_${GH_VERSION}_linux_amd64.deb" && \
    echo "$GH_SHA256SUM *gh_${GH_VERSION}_linux_amd64.deb" | sha256sum -c - && \
    dpkg -i "gh_${GH_VERSION}_linux_amd64.deb" && \
    rm -f "gh_${GH_VERSION}_linux_amd64.deb" && \
    echo '\n\n' && \

    # Install bat
    #
    # A cat(1) clone with syntax highlighting and Git integration.
    #
    # To update to a new release:
    # 1. Open https://github.com/sharkdp/bat/releases
    # 2. Download bat_VERSION_amd64.deb for the desired version
    # 3. Run `sha256sum bat_VERSION_amd64.deb`
    # 4. Copy/paste the checksum to BAT_SHA256SUM in environment variables at the beginning of this RUN script
    # 5. Edit the BAT_VERSION in environment variables at the beginning of this RUN script
    echo "Installing bat ${BAT_VERSION}..." && \
    wget -q "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" && \
    echo "Verifying bat_${BAT_VERSION}_amd64.deb checksum..." && \
    sha256sum "bat_${BAT_VERSION}_amd64.deb" && \
    echo "$BAT_SHA256SUM *bat_${BAT_VERSION}_amd64.deb" | sha256sum -c - && \
    dpkg -i "bat_${BAT_VERSION}_amd64.deb" && \
    rm -f "bat_${BAT_VERSION}_amd64.deb" && \
    echo '\n\n' && \

    # Install fd
    #
    # fd is a simple, fast and user-friendly alternative to 'find'.
    #
    # To update to a new release:
    # 1. Open https://github.com/sharkdp/fd/releases
    # 2. Download fd_VERSION_amd64.deb for the desired version
    # 3. Run `sha256sum fd_VERSION_amd64.deb`
    # 4. Copy/paste the checksum to FD_SHA256SUM in environment variables at the beginning of this RUN script
    # 5. Edit the FD_VERSION in environment variables at the beginning of this RUN script
    echo "Installing fd ${FD_VERSION}..." && \
    wget -q "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd_${FD_VERSION}_amd64.deb" && \
    echo "Verifying fd_${FD_VERSION}_amd64.deb checksum..." && \
    sha256sum "fd_${FD_VERSION}_amd64.deb" && \
    echo "$FD_SHA256SUM *fd_${FD_VERSION}_amd64.deb" | sha256sum -c - && \
    dpkg -i "fd_${FD_VERSION}_amd64.deb" && \
    rm -f "fd_${FD_VERSION}_amd64.deb" && \
    echo '\n\n' && \

    # Install hexyl
    #
    # hexyl is a command-line hex viewer.
    #
    # To update to a new release:
    # 1. Open https://github.com/sharkdp/hexyl/releases
    # 2. Download hexyl_VERSION_amd64.deb for the desired version
    # 3. Run `sha256sum hexyl_VERSION_amd64.deb`
    # 4. Copy/paste the checksum to HEXYL_SHA256SUM in environment variables at the beginning of this RUN script
    # 5. Edit the HEXYL_VERSION in environment variables at the beginning of this RUN script
    echo "Installing hexyl ${HEXYL_VERSION}..." && \
    wget -q "https://github.com/sharkdp/hexyl/releases/download/v${HEXYL_VERSION}/hexyl_${HEXYL_VERSION}_amd64.deb" && \
    echo "Verifying hexyl package checksum..." && \
    sha256sum "hexyl_${HEXYL_VERSION}_amd64.deb" && \
    echo "$HEXYL_SHA256SUM *hexyl_${HEXYL_VERSION}_amd64.deb" | sha256sum -c - && \
    dpkg -i "hexyl_${HEXYL_VERSION}_amd64.deb" && \
    rm -f "hexyl_${HEXYL_VERSION}_amd64.deb" && \
    echo '\n\n' && \

    # Install ripgrep
    echo "Installing ripgrep ${RIPGREP_VERSION}..." && \
    wget -q "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}_amd64.deb" && \
    echo "Verifying ripgrep_${RIPGREP_VERSION}_amd64.deb checksum..." && \
    sha256sum "ripgrep_${RIPGREP_VERSION}_amd64.deb" && \
    echo "${RIPGREP_SHA256SUM} *ripgrep_${RIPGREP_VERSION}_amd64.deb" | sha256sum -c - && \
    dpkg -i "ripgrep_${RIPGREP_VERSION}_amd64.deb" && \
    rm -f "ripgrep_${RIPGREP_VERSION}_amd64.deb" && \
    echo '\n\n' && \

    # Install exa
    echo "Installing exa ${EVA_VERSION}..." && \
    wget -q "https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-${EXA_VERSION}.zip" && \
    echo "Verifying exa-linux-x86_64-${EXA_VERSION}.zip checksum..." && \
    sha256sum "exa-linux-x86_64-${EXA_VERSION}.zip" && \
    echo "${EXA_SHA256SUM} *exa-linux-x86_64-${EXA_VERSION}.zip" | sha256sum -c - && \
    unzip -q "exa-linux-x86_64-${EXA_VERSION}.zip" && \
    mkdir -p "/opt/exa/${EXA_VERSION}/bin" && \
    ln -s "/opt/exa/${EXA_VERSION}" /opt/exa/latest && \
    mv exa-linux-x86_64 "/opt/exa/${EXA_VERSION}/bin/exa" && \
    ln -s /opt/exa/latest/bin/exa /usr/local/bin/exa && \
    rm -f "exa-linux-x86_64-${EXA_VERSION}.zip" && \
    echo '\n\n' && \

    # Install websocat
    echo "Installing websocat ${WEBSOCAT_VERSION}..." && \
    wget -q "https://github.com/vi/websocat/releases/download/v${WEBSOCAT_VERSION}/websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb" && \
    echo "Verifying websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb checksum..." && \
    sha256sum "websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb" && \
    echo "${WEBSOCAT_SHA256SUM} *websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb" | sha256sum -c - && \
    dpkg -i "websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb" && \
    rm -f "websocat_${WEBSOCAT_VERSION}_ssl1.1_amd64.deb" && \
    echo '\n\n' && \

    # Install pueue
    echo "Installing pueue and pueued ${PUEUE_VERSION}..." && \
    wget -q "https://github.com/Nukesor/pueue/releases/download/v${PUEUE_VERSION}/pueue-linux-x86_64" && \
    wget -q "https://github.com/Nukesor/pueue/releases/download/v${PUEUE_VERSION}/pueued-linux-x86_64" && \
    echo "Verifying pueue-linux-x86_64 checksum..." && \
    sha256sum pueue-linux-x86_64 && \
    echo "${PUEUE_SHA256SUM} *pueue-linux-x86_64" | sha256sum -c - && \
    echo "Verifying pueued-linux-x86_64 checksum..." && \
    sha256sum pueued-linux-x86_64 && \
    echo "${PUEUED_SHA256SUM} *pueued-linux-x86_64" | sha256sum -c - && \
    mkdir -p "/opt/pueue/${PUEUE_VERSION}/bin" && \
    ln -s "/opt/pueue/${PUEUE_VERSION}" /opt/pueue/latest && \
    mv pueue-linux-x86_64 "/opt/pueue/${PUEUE_VERSION}/bin/pueue" && \
    mv pueued-linux-x86_64 "/opt/pueue/${PUEUE_VERSION}/bin/pueued" && \
    chmod +x "/opt/pueue/${PUEUE_VERSION}/bin/pueue" "/opt/pueue/${PUEUE_VERSION}/bin/pueued" && \
    ln -s /opt/pueue/latest/bin/* /usr/local/bin && \
    echo '\n\n' && \

    # Install Chrome
    #
    # We have an Electron app that uses an older Chrome version. So we want to test with that same older version of
    # Chrome in this image. Google deletes old versions every release, so we can't get it from their official deb package
    # repository. Instead, jump through the following hoops using an example of Chrome 56.x:
    #
    # 1. Look in https://chromereleases.googleblog.com/ for the last time "56." was mentioned in a Desktop release. In
    #    this case I found https://chromereleases.googleblog.com/2017/01/stable-channel-update-for-desktop.html
    #    NOTE: I had to use '56.0.2924.77' instead of '56.0.2924.87' as '56.0.2924.87' does not return a base position
    #          in step 2.
    #
    # 2. Look up that version history ('56.0.2924.77') in the position lookup: https://omahaproxy.appspot.com/
    #    In this case it returns a 'Branch Base Position' of '433059'.
    #
    # 3. Open the continuous build archive: https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html
    #
    # 4. Click 'Linux_x64'
    #
    # 5. Paste the 'Branch Base Position' ('433059') into the 'Filter:' field at the top and wait for remote network
    #    requests to complete. Sometimes you need to decrement or increment the number until you find a match.
    #
    # 6. After waiting a long time you might get a hit; e.g. for '433062' I got:
    #      https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/433062/
    #
    # 7. Copy/paste the download URL for 'chrome-linux.zip'.
    echo "Installing Chromium ${CHROMIUM_VERSION}..." && \
    wget -q -O chromium-linux.zip $CHROMIUM_PACKAGE_URL && \
    echo "Verifying chromium-linux.zip checksum..." && \
    sha256sum chromium-linux.zip && \
    echo "$CHROMIUM_SHA256SUM *chromium-linux.zip" | sha256sum -c - && \
    unzip -q chromium-linux.zip && \
    mkdir -p /opt/chromium && \
    mv chrome-linux /opt/chromium/$CHROMIUM_VERSION && \
    ln -s /opt/chromium/$CHROMIUM_VERSION /opt/chromium/latest && \
    ln -s /opt/chromium/latest/chrome-wrapper /usr/local/bin/chrome-wrapper && \
    # Fixes error on startup like:
    # 'ChromeHeadless stderr: [3284:3284:0816/000443:FATAL:zygote_host_impl_linux.cc(107)] No usable sandbox! Update your kernel...'
    #
    # TODO When upgrading Chrome: Verify that there are no changes to `chrome-wrapper` that would cause this to fail.
    sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' \
        /opt/chromium/$CHROMIUM_VERSION/chrome-wrapper && \
    rm chromium-linux.zip && \

    # Save about ~18MB by deleting all Chromium locales except English:
    #rm -f /opt/chromium/latest/locales/!(en-GB.pak|en-US.pak) && \

    # Install older libraries required by older Chrome release (56.x).
    #
    # The version of Chrome installed is not compatible with newer releases of
    # the following libraries:
    #     $ ldd chrome | grep pango
    #       libpangocairo-1.0.so.0 => /lib/x86_64-linux-gnu/libpangocairo-1.0.so.0 (0x00007f314a52b000)
    #       libpango-1.0.so.0 => /lib/x86_64-linux-gnu/libpango-1.0.so.0 (0x00007f314a2de000)
    #       libpangoft2-1.0.so.0 => /lib/x86_64-linux-gnu/libpangoft2-1.0.so.0 (0x00007f3148673000)
    #
    # This issue causes an error like:
    #     (chrome:1733): Pango-ERROR **: 04:57:48.341: Harfbuzz version too old (1.3.1)
    #
    # To fix it older versions of the associated packages are installed over the top of the current
    # versions.
    #
    # TODO When upgrading Chrome: Remove this fix and verify the above error does not reoccur.
    #
    # Since this fix is expected to be removed when upgrading Chrome, the specific versions and
    # checksums are not stored in environment variables above for ease of upgrades.
    wget -q "http://mirrors.kernel.org/ubuntu/pool/main/p/pango1.0/libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "Verifying libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb checksum..." && \
    sha256sum "libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "bbe6059047b0e03433aee358b01d12c8dc083532fbd8160494aeb9dc74f3a3d9 *libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" | sha256sum -c - && \
    dpkg -i "libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    rm -f "libpango-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \

    wget -q "http://mirrors.kernel.org/ubuntu/pool/main/p/pango1.0/libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "Verifying libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb checksum..." && \
    sha256sum "libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "cb0f273b2ae6f752aa8d295aedb38eb4820cffc2c0c7fc25bc341ec8b182930a *libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" | sha256sum -c - && \
    dpkg -i "libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    rm -f "libpangocairo-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \

    wget -q "http://mirrors.kernel.org/ubuntu/pool/main/p/pango1.0/libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "Verifying libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb checksum..." && \
    sha256sum "libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    echo "e64b05c5108e501745955288a19492876f2bfbc7f54497fd6b87ae7b8b2238eb *libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" | sha256sum -c - && \
    dpkg -i "libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \
    rm -f "libpangoft2-1.0-0_1.40.14-1ubuntu0.1_amd64.deb" && \

    echo '\n\n' && \

    # Install ChromeDriver
    #
    # ChromeDriver version MUST be the correct version for the Chrome release it is being used with.
    #
    # For recent versions of Chrome see https://chromedriver.chromium.org/downloads/version-selection
    #
    # For older versions of Chrome (e.g. '56.x') look through https://chromedriver.storage.googleapis.com/index.html
    # and find the newest release with a 'notes.txt' file that mentions the major version e.g. 'Supports Chrome v56-58'.
    echo "Installing ChromeDriver ${CHROMEDRIVER_VERSION}..." && \
    wget -q https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    echo "Verifying ChromeDriver package checksum..." && \
    sha256sum chromedriver_linux64.zip && \
    echo "$CHROMEDRIVER_SHA256SUM *chromedriver_linux64.zip" | sha256sum -c - && \
    unzip -q chromedriver_linux64.zip && \
    rm -f chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    chromedriver --version && \
    echo '\n\n' && \

    # Install PhantomJS
    #
    # PhantomJS is a discontinued headless browser used for automated web page interaction, such as testing. Although
    # normal unit test builds can use Chrome via Karma, unfortunately PhantomJS is required by cljs-oss/canary builds.
    echo "Installing PhantomJS ${PHANTOMJS_VERSION}..." && \
    wget -q -O phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
    echo "Verifying PhantomJS package checksum..." && \
    sha256sum phantomjs.tar.bz2 && \
    echo "$PHANTOMJS_SHA256SUM *phantomjs.tar.bz2" | sha256sum -c - && \
    mkdir -p /opt/phantomjs/${PHANTOMJS_VERSION} && \
    tar jxf phantomjs.tar.bz2 --strip-components=1 -C /opt/phantomjs/${PHANTOMJS_VERSION} && \
    rm -f phantomjs.tar.bz2 && \
    ln -s /opt/phantomjs/${PHANTOMJS_VERSION} /opt/phantomjs/latest && \
    ln -s /opt/phantomjs/latest/bin/phantomjs /usr/local/bin/phantomjs && \
    echo '\n\n' && \

    # Install PowerShell
    #
    # Windows 10 has become a surprisingly good platform for developers in recent times. Just like its important to have
    # a preferred editor handy, be it vim or emacs, it is also important to have a familiar shell available to those who
    # want to use it.
    echo "Installing PowerShell ${POWERSHELL_VERSION}..." && \
    wget -q https://github.com/PowerShell/PowerShell/releases/download/v${POWERSHELL_VERSION}/powershell_${POWERSHELL_VERSION}-1.ubuntu.20.04_amd64.deb && \
    echo "Verifying powershell package checksum..." && \
    sha256sum "powershell_${POWERSHELL_VERSION}-1.ubuntu.20.04_amd64.deb" && \
    echo "$POWERSHELL_SHA256SUM *powershell_${POWERSHELL_VERSION}-1.ubuntu.20.04_amd64.deb" | sha256sum -c - && \
    dpkg -i "powershell_${POWERSHELL_VERSION}-1.ubuntu.20.04_amd64.deb" && \
    rm -f "powershell_${POWERSHELL_VERSION}-1.ubuntu.20.04_amd64.deb" && \

    # Ref: https://github.com/JanDeDobbeleer/oh-my-posh#installation
    pwsh -Command "Set-PSRepository PSGallery -InstallationPolicy Trusted" && \
    pwsh -Command "Install-Module posh-git -Scope CurrentUser" && \
    pwsh -Command "Install-Module oh-my-posh -Scope CurrentUser" && \
    pwsh -Command "Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck" && \
    pwsh -Command 'if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }' && \
    pwsh -Command 'echo "Import-Module posh-git" > $PROFILE' && \
    pwsh -Command 'echo "Import-Module oh-my-posh" >> $PROFILE' && \
    pwsh -Command 'echo "Set-Theme Agnoster" >> $PROFILE' && \

    echo '\n\n' && \

    # gitstatus is a 10x faster alternative to `git status` and `git describe`.
    #
    # Included in the Docker image so that the shell won't auto download it on
    # startup, reducing startup time.
    git clone --depth=1 https://github.com/romkatv/gitstatus.git && \
    cd gitstatus && \
    ./build -w && \
    mv usrbin/gitstatusd /usr/local/bin/gitstatusd && \
    cd /tmp && \
    rm -rf gitstatus && \

    # Install Zsh, Bash and Vim configuration files:
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k && \
    echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc && \
    echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc && \
    wget -q -O /root/.p10k.zsh "${DOTFILES_BASE_URI}/.p10k.zsh" && \

    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
    ~/.bash_it/install.sh --silent && \

    git clone --depth 1 https://github.com/liuchengxu/space-vim.git ~/.space-vim && \
    wget -q -O /root/.spacevim "${DOTFILES_BASE_URI}/.spacevim" && \
    cd ~/.space-vim && make neovim && cd /tmp && \

    wget -q -O /root/.gitconfig "${DOTFILES_BASE_URI}/.gitconfig" && \

    # Install NPM-based tools incl Lumo, Karma and Diff so Fancy:
    echo "Installing Lumo, Karma CLI and Diff so Fancy..." && \
    npm install -g --unsafe-perm \
      lumo-cljs@$LUMO_VERSION \
      karma-cli@$KARMA_CLI_VERSION \
      diff-so-fancy@$DIFF_SO_FANCY_VERSION && \

    # Finish Docker ENTRYPOINT script:
    echo 'neofetch' >> /docker-entrypoint.sh && \
    echo "echo \"`lein version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"lumo `lumo --version` and Planck `planck --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"Node.js `node --version` with NPM `npm --version` and Yarn `yarn --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`python2 --version` and `python3 --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`git --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`git-lfs --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`pwsh --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`chrome-wrapper --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"`chromedriver --version`\"" >> /docker-entrypoint.sh && \
    echo "echo \"PhantomJS `phantomjs --version`\"" >> /docker-entrypoint.sh && \
    echo 'exec "$@"' >> /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh && \

    # GitHub Actions overrides ENTRYPOINT with the --entrypoint CLI option to execute a long-running
    # tail command so that once created the container does not exit until explicitly stopped.
    #
    # So on GitHub Actions docker-entrypoint.sh is never executed. CircleCI allowed the use of a metadata
    # LABEL com.circleci.preserve-entrypoint=true, but unfortunately GitHub Actions does not appear
    # to have any mechanism to preserve the entrypoint.
    #
    # To exacerbate the confusion newer versions of ChromeDriver such as used in the CircleCI images,
    # which are tied to newer version of Chrome, do not appear to require Xvfb to be running. The
    # version of ChromeDriver that we are using currently does require Xvfb to be started beforehand.
    #
    # To workaround this issue so that we don't need to start Xvfb manually in every GitHub Action
    # workflow YAML we replace /usr/bin/tail with our own script that first executes
    # docker-entrypoint.sh (and thus Xvfb) before executing a backed up copy of tail at /usr/bin/tail.original
    #
    mv /usr/bin/tail /usr/bin/tail.original && \
    echo '#!/bin/sh' > /usr/bin/tail && \
    echo 'exec /docker-entrypoint.sh /usr/bin/tail.original $@' >> /usr/bin/tail && \
    chmod +x /usr/bin/tail && \

    # Strip binaries of debugging symbols that are not stripped already so save
    # some space:
    strip --strip-unneeded \
        /usr/bin/git-lfs \
        /usr/local/bin/docker \
        /usr/local/bin/dockerd \
        /usr/local/bin/docker-proxy && \

    # Save about ~22MB by deleting the pip cache:
    rm -rf /root/.cache && \

    # Delete npm's cache:
    rm -rf /root/.npm && \

    # Delete the .m2 repository because we cache this with actions/cache in GitHub Actions:
    rm -rf /root/.m2 && \

    # Cleanup
    rm -rf /usr/share/icons/* \
           /var/lib/apt/lists/*

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
