FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y zsh \
                       git \
                       silversearcher-ag \
                       nmap \
                       exuberant-ctags \
                       tmux \
                       curl \
                       postgresql-client \
                       redis-tools \
                       vim

RUN apt-get install -y man
# Do without git?
# TODO configure usrname
WORKDIR /root
RUN git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
RUN git clone https://github.com/mlovic/dotfiles

WORKDIR /root/dotfiles
RUN chmod +x install.sh
RUN ./install.sh
WORKDIR /root
RUN vim +PlugInstall +qall


#mongodb-org-shell	

#RUN chsh -s $(which zsh)

CMD "zsh"
