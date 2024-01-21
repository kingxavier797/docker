# docker
The Ultimate Docker Fundamentals at udemy.com

# Project Title

The Ultimate Docker Fundamentals Class at Udemy.com labs materials to be downloaded by students. You can access this class The Ultimate Docker Fundamentals: https://www.udemy.com/course/the-ultimate-docker-fundamentals/?referralCode=40D4234DC26C51494583



## Lab directories structures

[asokone@hpi7vboel82 docker]$ tree -d ./*
./compose
├── lms
│   ├── db
│   │   └── sql
│   │       └── mailit
│   │           ├── code
│   │           └── logs
│   └── web
│       └── conf
├── mailit
│   ├── db
│   │   └── sql
│   │       └── mailit
│   │           ├── code
│   │           └── logs
│   └── web
│       └── conf
├── microservices
│   ├── nginx
│   └── weather-app
│       └── src
│           ├── bin
│           ├── public
│           │   └── stylesheets
│           ├── routes
│           └── views
├── network
├── proj-01
│   └── PUBIMG
├── proj-02
│   └── __pycache__
├── proj-03
└── wordpress
    └── wphtml
./env
./images
./myweb
./network
./PostGres
./python
./storage
./tmp
└── www
./ubuntu
./webpub
└── PUBIMG

35 directories
[asokone@hpi7vboel82 docker]$

## Lab files

[asokone@hpi7vboel82 docker]$ tree ./*
./compose
├── lms
│   ├── db
│   │   ├── Dockerfile
│   │   └── sql
│   │       └── mailit
│   │           ├── code
│   │           ├── grant_apache_access_to_dbserver.sql
│   │           ├── logs
│   │           ├── mailittables.sql
│   │           ├── newdoitall.ksh
│   │           ├── readme.txt
│   │           └── README.TXT
│   ├── docker-compose.yml
│   ├── lms_readme.txt
│   ├── update_dbcontainer_and_webcontainer.ksh
│   └── web
│       ├── conf
│       │   ├── apache2-httpd.conf
│       │   └── httpd.conf
│       ├── Dockerfile
│       ├── docker_mailit_20200919-old.tgz
│       └── docker_mailit_20200919.tgz
├── mailit
│   ├── db
│   │   ├── docker-entrypoint.sh
│   │   ├── Dockerfile
│   │   ├── healthcheck.sh
│   │   └── sql
│   │       └── mailit
│   │           ├── code
│   │           ├── grant_apache_access_to_dbserver.sql
│   │           ├── logs
│   │           ├── mailittables.sql
│   │           ├── newdoitall.ksh
│   │           ├── readme.txt
│   │           └── README.TXT
│   ├── docker-compose.yml
│   ├── mailit_readme.txt
│   └── web
│       ├── conf
│       │   ├── apache2-httpd.conf
│       │   └── httpd.conf
│       ├── Dockerfile
│       └── docker_mailit_20200919.tgz
├── microservices
│   ├── docker-compose.yml
│   ├── nginx
│   │   ├── Dockerfile
│   │   └── nginx.conf
│   ├── README.txt
│   └── weather-app
│       ├── Dockerfile
│       └── src
│           ├── app.js
│           ├── bin
│           │   └── www
│           ├── config.js
│           ├── package.json
│           ├── package-lock.json
│           ├── public
│           │   └── stylesheets
│           │       └── style.css
│           ├── routes
│           │   └── index.js
│           └── views
│               ├── error.ejs
│               └── index.ejs
├── network
│   ├── docker-compose_network.yml
│   ├── docker-compose_no_network.yml
│   ├── docker-compose.yml
│   └── Dockerfile
├── proj-01
│   ├── 0.html
│   ├── 10.html
│   ├── 11.html
│   ├── 12.html
│   ├── 13.html
│   ├── 14.html
│   ├── 15.html
│   ├── 16.html
│   ├── 17.html
│   ├── 18.html
│   ├── 19.html
│   ├── 1.html
│   ├── 2.html
│   ├── 3.html
│   ├── 4.html
│   ├── 5.html
│   ├── 6.html
│   ├── 7.html
│   ├── 8.html
│   ├── 9.html
│   ├── AndialySokone.html
│   ├── AndialySokone.jpg
│   ├── copyright.html
│   ├── copyright.txt
│   ├── counter.txt
│   ├── customer0.html
│   ├── customer10.html
│   ├── customer1.html
│   ├── customer2.html
│   ├── customer3.html
│   ├── customer4.html
│   ├── customer5.html
│   ├── customer6.html
│   ├── customer7.html
│   ├── customer8.html
│   ├── customer9.html
│   ├── customer.html
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── index.html
│   ├── javapubscript.txt
│   ├── preface.cgi
│   ├── PUBIMG
│   │   ├── black_am_banner.gif
│   │   ├── customer0.png
│   │   ├── customer10.png
│   │   ├── customer1.png
│   │   ├── customer2.png
│   │   ├── customer3.png
│   │   ├── customer4.png
│   │   ├── customer5.png
│   │   ├── customer6.png
│   │   ├── customer7.png
│   │   ├── customer8.png
│   │   ├── customer9.png
│   │   ├── DockerArchitecture.png
│   │   ├── frontpub-0.gif
│   │   ├── frontpub-0.png
│   │   ├── frontpub-10.gif
│   │   ├── frontpub-10.png
│   │   ├── frontpub-11.gif
│   │   ├── frontpub-12.gif
│   │   ├── frontpub-13.gif
│   │   ├── frontpub-14.gif
│   │   ├── frontpub-15.gif
│   │   ├── frontpub-16.gif
│   │   ├── frontpub-17.gif
│   │   ├── frontpub-18.gif
│   │   ├── frontpub-19.gif
│   │   ├── frontpub-19.jpg
│   │   ├── frontpub-1.gif
│   │   ├── frontpub-1.jpg
│   │   ├── frontpub-1.png
│   │   ├── frontpub-2.gif
│   │   ├── frontpub-2.jpg
│   │   ├── frontpub-2.png
│   │   ├── frontpub-3.gif
│   │   ├── frontpub-3.jpg
│   │   ├── frontpub-3.png
│   │   ├── frontpub-4.gif
│   │   ├── frontpub-4.jpg
│   │   ├── frontpub-4.png
│   │   ├── frontpub-5.gif
│   │   ├── frontpub-5.png
│   │   ├── frontpub-6.gif
│   │   ├── frontpub-6.png
│   │   ├── frontpub-7.gif
│   │   ├── frontpub-7.png
│   │   ├── frontpub-8.gif
│   │   ├── frontpub-8.png
│   │   ├── frontpub-9.gif
│   │   ├── frontpub-9.png
│   │   ├── frontpub.ksh
│   │   ├── javapubscript.txt
│   │   ├── line2.gif
│   │   ├── line2.jpg
│   │   └── world-map-sm.gif
│   └── README.txt
├── proj-02
│   ├── application.py
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── __pycache__
│   │   └── application.cpython-37.pyc
│   └── requirements.txt
├── proj-03
│   ├── api.env
│   ├── docker-compose-01.yml
│   ├── docker-compose-02.yml
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── Dockerfile-01
│   ├── Dockerfile-02
│   └── hello-world.js
└── wordpress
    ├── docker-compose.yml
    └── wphtml
./env
├── AndialySokone.jpg
├── application.py
├── Dockerfile
└── index.html
./images
./myweb
├── AndialySokone.jpg
├── application.py
├── counter.pl
├── counter.txt
├── Dockerfile
├── Dockerfile.Alpine
├── Dockerfile.oraclelunix8.2
└── index.html
./network
├── AndialySokone.jpg
├── application.py
├── counter.pl
├── counter.txt
├── Dockerfile
├── Dockerfile.Alpine
├── Dockerfile.oraclelunix8.2
└── index.html
./PostGres
├── my-postgreSQL-DB.pem
└── PostGres_db_setup_in_docker_container_page_103.sh
./python
├── AndialySokone.jpg
├── application.py
├── Dockerfile
├── Dockerfile.01
├── Dockerfile.02
├── Dockerfile.03
├── Dockerfile.04
├── Dockerfile.05
└── index.html
./storage
├── Dockerfile
└── index.html
./tmp
├── Dockerfile
├── example-bash.sh
├── README.md
├── serve-cgi-bin.conf
└── www
    ├── index.html
    └── logo.png
./ubuntu
├── Dockerfile
└── Dockerfile.01
./webpub
├── 0.html
├── 10.html
├── 11.html
├── 12.html
├── 13.html
├── 14.html
├── 15.html
├── 16.html
├── 17.html
├── 18.html
├── 19.html
├── 1.html
├── 2.html
├── 3.html
├── 4.htl
├── 4.html
├── 5.html
├── 6.html
├── 7.html
├── 8.html
├── 9.html
├── AndialySokone.html
├── AndialySokone.jpg
├── copyright.html
├── copyright.txt
├── counter.txt
├── customer0.html
├── customer10.html
├── customer1.html
├── customer2.html
├── customer3.html
├── customer4.html
├── customer5.html
├── customer6.html
├── customer7.html
├── customer8.html
├── customer9.html
├── customer.html
├── Dockerfile
├── Dockerfile.linux8.0
├── Dockerfile.ubuntu20
├── Dockerfile.ubuntu_reddit
├── example-bash.sh
├── index.html
├── javapubscript.txt
├── preface.cgi
├── PUBIMG
│   ├── black_am_banner.gif
│   ├── customer0.png
│   ├── customer10.png
│   ├── customer1.png
│   ├── customer2.png
│   ├── customer3.png
│   ├── customer4.png
│   ├── customer5.png
│   ├── customer6.png
│   ├── customer7.png
│   ├── customer8.png
│   ├── customer9.png
│   ├── DockerArchitecture.png
│   ├── frontpub-0.gif
│   ├── frontpub-0.png
│   ├── frontpub-10.gif
│   ├── frontpub-10.png
│   ├── frontpub-11.gif
│   ├── frontpub-12.gif
│   ├── frontpub-13.gif
│   ├── frontpub-14.gif
│   ├── frontpub-15.gif
│   ├── frontpub-16.gif
│   ├── frontpub-17.gif
│   ├── frontpub-18.gif
│   ├── frontpub-19.gif
│   ├── frontpub-19.jpg
│   ├── frontpub-1.gif
│   ├── frontpub-1.jpg
│   ├── frontpub-1.png
│   ├── frontpub-2.gif
│   ├── frontpub-2.jpg
│   ├── frontpub-2.png
│   ├── frontpub-3.gif
│   ├── frontpub-3.jpg
│   ├── frontpub-3.png
│   ├── frontpub-4.gif
│   ├── frontpub-4.jpg
│   ├── frontpub-4.png
│   ├── frontpub-5.gif
│   ├── frontpub-5.png
│   ├── frontpub-6.gif
│   ├── frontpub-6.png
│   ├── frontpub-7.gif
│   ├── frontpub-7.png
│   ├── frontpub-8.gif
│   ├── frontpub-8.png
│   ├── frontpub-9.gif
│   ├── frontpub-9.png
│   ├── frontpub.ksh
│   ├── javapubscript.txt
│   ├── line2.gif
│   ├── line2.jpg
│   └── world-map-sm.gif
├── README.txt
└── serve-cgi-bin.conf

35 directories, 300 files
[asokone@hpi7vboel82 docker]$
[asokone@hpi7vboel82 docker]$
