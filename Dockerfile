FROM kalilinux/kali-rolling

# docker build -t bugbounty_env -f Dockerfile .
LABEL maintainer="Ismail BOZKURT <ismailbozkurtr@gmail.com>"

ENV GO111MODULE=on

RUN apt-get update \
    && apt-get install -yq apt-utils build-essential curl gcc wget net-tools \
    readline-common neovim git \
    # zsh zsh-syntax-highlighting zsh-autosuggestions \
    jq build-essential python3-pip unzip git p7zip libpcap-dev rubygems ruby-dev grc

RUN apt update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew dist-upgrade -qq && \
    wget -q https://golang.org/dl/go1.17.1.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz && rm go1.17.1.linux-amd64.tar.gz && \
    export GOPATH=/home/root/go

ENV PATH=/root/go/bin:$PATH

RUN mkdir /wordlists && cd /wordlists && \
    git clone https://github.com/xm1k3/cent.git && \
    git clone https://github.com/ayoubfathi/leaky-paths.git && \
    wget -q -O /wordlists/permutations.txt https://gist.github.com/six2dez/ffc2b14d283e8f8eff6ac83e20a3c4b4/raw && \
    git clone https://github.com/danielmiessler/SecLists.git

RUN mkdir /tools && cd /tools && \
    git clone https://github.com/blark/aiodnsbrute.git && \
    /usr/local/go/bin/go install github.com/tomnomnom/anew@latest && \
    /usr/local/go/bin/go install github.com/tomnomnom/hacks/anti-burl@latest && \
    /usr/local/go/bin/go install github.com/tomnomnom/assetfinder@latest && \
    wget -q -O /tmp/amass.zip https://github.com/OWASP/Amass/releases/download/v3.13.4/amass_linux_amd64.zip && cd /tmp/ && unzip /tmp/amass.zip && mv /tmp/amass_linux_amd64/amass /usr/bin/amass && cd /tools && \
    wget -q -O /tmp/aquatone.zip https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && cd /tmp/ && unzip /tmp/aquatone.zip && mv /tmp/aquatone /usr/bin/aquatone && cd /tools && \
    cd /tmp && git clone https://github.com/s0md3v/Arjun && cd Arjun && python3 setup.py install && cd /tools && \
    /usr/local/go/bin/go install github.com/dwisiswant0/cf-check@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/chaos-client/cmd/chaos@latest && \
    git clone https://github.com/commixproject/commix.git && \
    /usr/local/go/bin/go install github.com/tomnomnom/hacks/concurl@latest && \
    git clone https://github.com/s0md3v/Corsy.git && cd /tools/Corsy && pip3 install -r requirements.txt && cd /tools &&\
    GO111MODULE=on /usr/local/go/bin/go install github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/hahwul/dalfox/v2@latest && \
    /usr/local/go/bin/go install github.com/m4dm0e/dirdar@latest && \
    wget -q -O /tmp/DNSCewl https://github.com/codingo/DNSCewl/raw/master/DNScewl && mv /tmp/DNSCewl /usr/bin/DNSCewl && chmod +x /usr/bin/DNSCewl && \
    git clone https://github.com/ProjectAnte/dnsgen && cd /tools/dnsgen && pip3 install -r requirements.txt && python3 setup.py install && cd /tools && \
    git clone https://github.com/darkoperator/dnsrecon.git && cd /tools/dnsrecon && pip3 install -r requirements.txt && cd /tools && \
    git clone https://github.com/vortexau/dnsvalidator.git && cd /tools/dnsvalidator/ && python3 setup.py install && cd /tools && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    git clone https://github.com/maikthulhu/ERLPopper.git && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/Cgboal/exclude-cdn@latest && \
    curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash && mv feroxbuster /usr/bin/ && \
    /usr/local/go/bin/go install github.com/tomnomnom/fff@latest && \
    /usr/local/go/bin/go install github.com/ffuf/ffuf@latest && \
    wget -q -O /tmp/findomain https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux && mv /tmp/findomain /usr/bin/findomain && chmod +x /usr/bin/findomain && cd /tools && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/lc/gau@latest && \
    GO111MODULE=on /usr/local/go/bin/go install -v github.com/bp0lr/gauplus@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/003random/getJS@latest && \
    # GO111MODULE=off /usr/local/go/bin/go install github.com/tomnomnom/gf@latest && \
    # git clone https://github.com/1ndianl33t/Gf-Patterns /root/.gf && \
    /usr/local/go/bin/go install github.com/gwen001/github-endpoints@latest && \
    cd /tmp && wget -q -O /tmp/gobuster.7z https://github.com/OJ/gobuster/releases/download/v3.1.0/gobuster-linux-amd64.7z && p7zip -d /tmp/gobuster.7z && mv /tmp/gobuster-linux-amd64/gobuster /usr/bin/gobuster && chmod +x /usr/bin/gobuster && cd /tools && \
    git clone https://github.com/pry0cc/gorgo.git && cd gorgo && pip3 install -r requirements.txt && cd /tools && \
    /usr/local/go/bin/go install github.com/jaeles-project/gospider@latest && \
    /usr/local/go/bin/go install github.com/sensepost/gowitness@latest && \
    /usr/local/go/bin/go install github.com/tomnomnom/gron@latest && \
    /usr/local/go/bin/go install github.com/KathanP19/Gxss@latest && \
    /usr/local/go/bin/go install github.com/hakluke/hakrawler@latest && \
    /usr/local/go/bin/go install github.com/hakluke/hakrevdns@latest && \
    /usr/local/go/bin/go install github.com/tomnomnom/httprobe@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/jaeles-project/jaeles@latest && /root/go/bin/jaeles config init && \
    /usr/local/go/bin/go install github.com/tomnomnom/hacks/kxss@latest && \
    git clone https://github.com/GerbenJavado/LinkFinder && cd /tools/LinkFinder && pip3 install -r requirements.txt && python3 setup.py install && cd /tools && \
    apt install masscan -y -qq && \
    # git clone https://github.com/blechschmidt/massdns.git /tmp/massdns; cd /tmp/massdns; make -s; mv bin/massdns /usr/bin/massdns && cd /tools && \
    apt install medusa -y -qq && \
    /usr/local/go/bin/go install github.com/tomnomnom/meg@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    apt-get -qy --no-install-recommends install build-essential libssl-dev flex bison && \
    # wget https://nmap.org/dist/nmap-7.92.tgz -O /tools/nmap.tar.gz && cd /tools/ && tar zxf nmap.tar.gz --transform s/nmap-7.92/nmap/ && rm nmap.tar.gz && cd /tools/nmap/ && ./configure --without-ndiff --without-zenmap --without-nping  --without-ncat --without-nmap-update --with-libpcap=included && make && make install && cd /tools && \
    # git clone --depth 1  https://github.com/ivre/ivre.git /tools/nmap_scripts && cd /tools/nmap_scripts && git filter-branch --prune-empty --subdirectory-filter  nmap_scripts HEAD && \
    # cp /tools/nmap_scripts/* /usr/local/share/nmap/scripts && nmap --script-update && \
    # cp /tools/nmap_scripts/* /tools/nmap/scripts/ && cd /tools/nmap && ./nmap --script-update && cd /tools && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    git clone https://github.com/devanshbatham/OpenRedireX.git && cd /tools/OpenRedireX && pip3 install aiohttp -q && cd /tools && \
    git clone https://github.com/devanshbatham/ParamSpider.git /tools/ParamSpider && cd /tools/ParamSpider && pip3 install -r requirements.txt && cd /tools && \
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 && tar jxf phantomjs-1.9.8-linux-x86_64.tar.bz2 phantomjs-1.9.8-linux-x86_64/bin/phantomjs && rm phantomjs-1.9.8-linux-x86_64.tar.bz2 && mv phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/ && cd /tools && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/d3mondev/puredns/v2@latest && \
    /usr/local/go/bin/go install github.com/tomnomnom/qsreplace@latest && \
    git clone https://github.com/lgandx/Responder.git && \
    wget -q -O /tmp/rustscan.deb https://github.com/brandonskerritt/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb && apt install /tmp/rustscan.deb -y -qq && \
    pip3 install s3scanner && \
    # wget -q -O /tmp/scrying.deb https://github.com/nccgroup/scrying/releases/download/v0.9.0-alpha.2/scrying_0.9.0-alpha.2_amd64.deb && apt install /tmp/scrying.deb -y -qq && apt install xvfb -y -qq && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest && \
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git && \
    /usr/local/go/bin/go install github.com/haccer/subjack@latest && \
    GO111MODULE=on /usr/local/go/bin/go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    GO111MODULE=on /usr/local/go/bin/go install -v github.com/lc/subjs@latest && \
    git clone --depth 1 https://github.com/drwetter/testssl.sh.git && \
    wget -q -O /tmp/unimap https://github.com/Edu4rdSHL/unimap/releases/download/0.5.1/unimap-linux && mv /tmp/unimap /usr/bin/unimap && chmod +x /usr/bin/unimap && \
    cd /tmp && git clone https://github.com/EnableSecurity/wafw00f && cd wafw00f && python3 setup.py install && cd /tools && \
    /usr/local/go/bin/go install github.com/tomnomnom/waybackurls@latest && \
    /usr/local/go/bin/go install -v github.com/tillson/git-hound@latest && \
    pip3 install webscreenshot && \
    gem install wpscan && \
    /usr/local/go/bin/go  clean -modcache && \
    # wget -q -O gf-completion.zsh https://raw.githubusercontent.com/tomnomnom/gf/master/gf-completion.zsh && cat gf-completion.zsh >> /root/.zshrc && rm gf-completion.zsh && cd /tools && \
    apt-get clean

