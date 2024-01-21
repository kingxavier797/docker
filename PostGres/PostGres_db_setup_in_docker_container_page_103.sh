#!/bin/sh

# SINCE I HAVE ON THIS HOST DOCKER INSTALLED
# I COMMENTED OUT ALL OF THE DOCKER STUFF.

#echo "Updating and installing Docker"
#sudo yum update -y
#sudo yum upgrade -y
#sudo yum remove docker \
#  docker-client \
#  docker-client-latest \
#  docker-common \
#  docker-latest \
#  docker-latest-logrotate \
#  docker-logrotate \
#  docker-engine
#sudo yum install -y yum-utils \
#  device-mapper-persistent-data \
#  lvm2
#sudo yum-config-manager -y \
#    --add-repo \
#    https://download.docker.com/linux/centos/docker-ce.repo
#sudo yum install -y docker-ce docker-ce-cli containerd.io
#
#echo "Starting and enabling Docker"
#sudo systemctl start docker
#sudo systemctl enable docker

# Make sure that Postgres command psql is installed on this system firt.
which psql > /dev/null 2>&1
if [ $? != 0 ]
then
	echo
	echo "Please install on this host the Postgres command psql first"
	echo "by running the command: [sudo dnf install -y postgres*]"
	echo
fi


echo
echo
echo -n "Please enter the local port you are to map into the container Postgres port 5432 - i.e: 8282: "
read MYPORT

# Let us make sure this port is not in already locally by another service
curl localhost:$MYPORT > /dev/null 2>&1
if [ $? == 0 ]
then
	echo
	echo "This port: $MYPORT is in use, please use a different port"
	echo
	exit 1
fi

echo "Configure database user"
read -p "Postgres user name: " name
read -s -p "Postgres user password: " password

export POSTGRES_USER=$name
export POSTGRES_PASSWORD=$password


# Remove any previous postgres container
echo 
echo
echo "Cleaning up any previous postgres container let over"
echo
echo
sudo docker rm --force postgres || true

echo
echo "Creating database container (and seed 'sample' database)"
export POSTGRES_INSTANCE="sample"

sudo docker run -d \
  --name postgres \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_DB=$POSTGRES_INSTANCE \
  -p $MYPORT:5432 \
  -p 5432:5432 \
  --restart always \
  postgres:9.6.8-alpine

sleep 20 # Ensure enough time for postgres database to initialize and create role

echo
echo
echo "Let us populate the database instance: [$POSTGRES_INSTANCE] - as user [$POSTGRES_USER]"
echo
echo
sudo docker exec -i postgres psql -U $POSTGRES_USER -d $POSTGRES_INSTANCE <<-EOF
create table employees (
  id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  gender VARCHAR(50),
  favorite_color VARCHAR(50)
);
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (0, 'Mamadou', 'Diatta', 'mamadou.diatta@thecloudedu.com', 'Male', '#6fd569');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (1, 'Lauralee', 'Morkham', 'lmorkham0@thecloudedu.com', 'Female', '#878922');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (2, 'Hillery', 'Langland', 'hlangland1@thecloudedu.com', 'Male', '#6fd569');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (3, 'Regan', 'Kroger', 'rkroger2@thecloudedu.com', 'Male', '#d9c547');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (4, 'George', 'Treasaden', 'gtreasaden3@thecloudedu.com', 'Male', '#d5e6c2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (5, 'Raddy', 'Curley', 'rcurley4@thecloudedu.com', 'Male', '#83974a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (6, 'Waylen', 'Tott', 'wtott5@thecloudedu.com', 'Male', '#90532b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (7, 'Filmore', 'Chartre', 'fchartre6@thecloudedu.com', 'Male', '#6a1fb5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (8, 'Ulberto', 'Pimme', 'upimme7@thecloudedu.com', 'Male', '#7560c1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (9, 'Sigfried', 'Lowre', 'slowre8@thecloudedu.com', 'Male', '#37c45b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (10, 'Edwina', 'Henrichsen', 'ehenrichsen9@thecloudedu.com', 'Female', '#00ef5c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (11, 'Emmeline', 'Harty', 'ehartya@thecloudedu.com', 'Female', '#004399');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (12, 'Nolan', 'Cansdall', 'ncansdallb@thecloudedu.com', 'Male', '#fff920');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (13, 'Chrystel', 'Wickey', 'cwickeyc@thecloudedu.com', 'Female', '#33b833');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (14, 'Ezequiel', 'McCart', 'emccartd@thecloudedu.com', 'Male', '#0437d5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (15, 'Diarmid', 'Main', 'dmaine@thecloudedu.com', 'Male', '#f3f435');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (16, 'Jessamine', 'Jansik', 'jjansikf@thecloudedu.com', 'Female', '#db3da9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (17, 'Linell', 'Brimicombe', 'lbrimicombeg@thecloudedu.com', 'Female', '#68e029');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (18, 'Faber', 'Netting', 'fnettingh@thecloudedu.com', 'Male', '#9c772e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (19, 'Roz', 'Caple', 'rcaplei@thecloudedu.com', 'Female', '#cc5cb2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (20, 'Caleb', 'Milch', 'cmilchj@thecloudedu.com', 'Male', '#8f1c39');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (21, 'Krystalle', 'Gibling', 'kgiblingk@thecloudedu.com', 'Female', '#78254d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (22, 'Felipa', 'Pardy', 'fpardyl@thecloudedu.com', 'Female', '#b8b32e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (23, 'Krystalle', 'Inkster', 'kinksterm@thecloudedu.com', 'Female', '#70144a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (24, 'Loralyn', 'Hoofe', 'lhoofen@thecloudedu.com', 'Female', '#da0b31');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (25, 'Mirella', 'Sandars', 'msandarso@thecloudedu.com', 'Female', '#27a0ac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (26, 'Stacee', 'Megahey', 'smegaheyp@thecloudedu.com', 'Male', '#8bcb37');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (27, 'Benetta', 'Olivelli', 'bolivelliq@thecloudedu.com', 'Female', '#0940f9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (28, 'Ericka', 'Waylen', 'ewaylenr@thecloudedu.com', 'Female', '#3696d7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (29, 'Virgie', 'Meiklam', 'vmeiklams@thecloudedu.com', 'Female', '#34fc78');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (30, 'Felecia', 'Tow', 'ftowt@thecloudedu.com', 'Female', '#bfd7db');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (31, 'Fanya', 'Elmhirst', 'felmhirstu@thecloudedu.com', 'Female', '#3c02a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (32, 'Rafi', 'Juschka', 'rjuschkav@thecloudedu.com', 'Male', '#e3ab10');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (33, 'Ruggiero', 'Buttriss', 'rbuttrissw@thecloudedu.com', 'Male', '#7ea766');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (34, 'Spenser', 'Shepton', 'ssheptonx@thecloudedu.com', 'Male', '#ca1ef4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (35, 'Leann', 'Gooch', 'lgoochy@thecloudedu.com', 'Female', '#b96ca9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (36, 'Livy', 'Cockton', 'lcocktonz@thecloudedu.com', 'Female', '#c4cf2e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (37, 'Vernor', 'Bramah', 'vbramah10@thecloudedu.com', 'Male', '#cc8f0c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (38, 'Lexy', 'Naile', 'lnaile11@thecloudedu.com', 'Female', '#1b4250');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (39, 'Marjie', 'Ewebank', 'mewebank12@thecloudedu.com', 'Female', '#69d9d4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (40, 'Malvina', 'Dodsworth', 'mdodsworth13@thecloudedu.com', 'Female', '#3455e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (41, 'Earlie', 'Wishkar', 'ewishkar14@thecloudedu.com', 'Male', '#741ddf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (42, 'Elsa', 'Older', 'eolder15@thecloudedu.com', 'Female', '#5844b7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (43, 'Davine', 'Grimsdell', 'dgrimsdell16@thecloudedu.com', 'Female', '#3c3900');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (44, 'Howie', 'Stillwell', 'hstillwell17@thecloudedu.com', 'Male', '#e93925');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (45, 'Noel', 'Kilcoyne', 'nkilcoyne18@thecloudedu.com', 'Female', '#a4a117');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (46, 'Nikolai', 'Fernyhough', 'nfernyhough19@thecloudedu.com', 'Male', '#64c3d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (47, 'Garvey', 'Beckles', 'gbeckles1a@thecloudedu.com', 'Male', '#e8a2c0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (48, 'Corrine', 'Bladen', 'cbladen1b@thecloudedu.com', 'Female', '#d80160');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (49, 'Godart', 'Worham', 'gworham1c@thecloudedu.com', 'Male', '#886559');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (50, 'Adrien', 'Hynde', 'ahynde1d@thecloudedu.com', 'Male', '#23e863');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (51, 'Hally', 'Cripwell', 'hcripwell1e@thecloudedu.com', 'Female', '#0af12f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (52, 'Rochester', 'King', 'rking1f@thecloudedu.com', 'Male', '#326e53');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (53, 'Millard', 'Ruddom', 'mruddom1g@thecloudedu.com', 'Male', '#5c8c34');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (54, 'Darnall', 'Bownde', 'dbownde1h@thecloudedu.com', 'Male', '#9f84ea');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (55, 'Sayres', 'Dyball', 'sdyball1i@thecloudedu.com', 'Male', '#c72eac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (56, 'Hagen', 'Brown', 'hbrown1j@thecloudedu.com', 'Male', '#ea261f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (57, 'Derrick', 'Aireton', 'daireton1k@thecloudedu.com', 'Male', '#67744e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (58, 'Jameson', 'Smedley', 'jsmedley1l@thecloudedu.com', 'Male', '#6fe3d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (59, 'Conway', 'Conyer', 'cconyer1m@thecloudedu.com', 'Male', '#d5ecea');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (60, 'Sarene', 'Sambeck', 'ssambeck1n@thecloudedu.com', 'Female', '#2152e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (61, 'Alonso', 'Dunford', 'adunford1o@thecloudedu.com', 'Male', '#aa1a55');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (62, 'Gabie', 'Mallord', 'gmallord1p@thecloudedu.com', 'Male', '#ae25d7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (63, 'Trueman', 'Campbell-Dunlop', 'tcampbelldunlop1q@thecloudedu.com', 'Male', '#566a9f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (64, 'Viviana', 'Assante', 'vassante1r@thecloudedu.com', 'Female', '#e72101');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (65, 'Cam', 'Baiss', 'cbaiss1s@thecloudedu.com', 'Male', '#cfa1f6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (66, 'Elvis', 'Glenwright', 'eglenwright1t@thecloudedu.com', 'Male', '#982014');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (67, 'Rudy', 'Currall', 'rcurrall1u@thecloudedu.com', 'Male', '#d94226');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (68, 'Pauletta', 'Mosco', 'pmosco1v@thecloudedu.com', 'Female', '#dd387d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (69, 'Dael', 'Gaytor', 'dgaytor1w@thecloudedu.com', 'Male', '#d30a7e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (70, 'Mitchell', 'Joao', 'mjoao1x@thecloudedu.com', 'Male', '#a4ba38');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (71, 'Tully', 'Grestie', 'tgrestie1y@thecloudedu.com', 'Male', '#0dc4ad');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (72, 'Terrel', 'Greet', 'tgreet1z@thecloudedu.com', 'Male', '#a93052');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (73, 'Tonya', 'Kiefer', 'tkiefer20@thecloudedu.com', 'Female', '#d07da3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (74, 'Kingsly', 'Hupe', 'khupe21@thecloudedu.com', 'Male', '#3d6b7a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (75, 'Anthony', 'Yoodall', 'ayoodall22@thecloudedu.com', 'Male', '#b37b54');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (76, 'Wenonah', 'Ianno', 'wianno23@thecloudedu.com', 'Female', '#564386');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (77, 'Mair', 'Spivie', 'mspivie24@thecloudedu.com', 'Female', '#6d49e7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (78, 'Kimble', 'Pedrocchi', 'kpedrocchi25@thecloudedu.com', 'Male', '#df9bb2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (79, 'Rudd', 'Osbaldstone', 'rosbaldstone26@thecloudedu.com', 'Male', '#cfd169');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (80, 'Hailee', 'Coneybeare', 'hconeybeare27@thecloudedu.com', 'Female', '#26a33a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (81, 'Arabel', 'Eles', 'aeles28@thecloudedu.com', 'Female', '#926e4b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (82, 'Antons', 'Hazlehurst', 'ahazlehurst29@thecloudedu.com', 'Male', '#f3b521');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (83, 'Blondell', 'Collard', 'bcollard2a@thecloudedu.com', 'Female', '#1afc09');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (84, 'Giorgi', 'Bootyman', 'gbootyman2b@thecloudedu.com', 'Male', '#587604');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (85, 'Tamma', 'Eleshenar', 'teleshenar2c@thecloudedu.com', 'Female', '#0752f6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (86, 'Trefor', 'McCaighey', 'tmccaighey2d@thecloudedu.com', 'Male', '#e58ecf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (87, 'Frannie', 'Chazier', 'fchazier2e@thecloudedu.com', 'Male', '#e0edc1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (88, 'Arnie', 'Leathwood', 'aleathwood2f@thecloudedu.com', 'Male', '#065894');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (89, 'Markus', 'Golly', 'mgolly2g@thecloudedu.com', 'Male', '#0281eb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (90, 'Sylvester', 'Lerway', 'slerway2h@thecloudedu.com', 'Male', '#1ce5bf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (91, 'Meredithe', 'Bearn', 'mbearn2i@thecloudedu.com', 'Female', '#dfd5a1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (92, 'Delia', 'Strafford', 'dstrafford2j@thecloudedu.com', 'Female', '#c51e7b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (93, 'Kaitlyn', 'Tomankiewicz', 'ktomankiewicz2k@thecloudedu.com', 'Female', '#e13ed4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (94, 'Lucius', 'Horburgh', 'lhorburgh2l@thecloudedu.com', 'Male', '#4ca5ec');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (95, 'Nanni', 'Sultan', 'nsultan2m@thecloudedu.com', 'Female', '#7a049a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (96, 'Adria', 'Farnaby', 'afarnaby2n@thecloudedu.com', 'Female', '#fa77c6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (97, 'Evvie', 'Derges', 'ederges2o@thecloudedu.com', 'Female', '#b42097');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (98, 'Beverlee', 'Butting', 'bbutting2p@thecloudedu.com', 'Female', '#b9bae1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (99, 'Brandtr', 'de Broke', 'bdebroke2q@thecloudedu.com', 'Male', '#5ec300');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (100, 'Anders', 'Okker', 'aokker2r@thecloudedu.com', 'Male', '#c7a903');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (101, 'Ash', 'Fyfield', 'afyfield2s@thecloudedu.com', 'Male', '#f6565e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (102, 'Julian', 'Karolovsky', 'jkarolovsky2t@thecloudedu.com', 'Male', '#a7a764');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (103, 'Marris', 'Murty', 'mmurty2u@thecloudedu.com', 'Female', '#337446');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (104, 'Dorian', 'Shipway', 'dshipway2v@thecloudedu.com', 'Male', '#c4014e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (105, 'Wait', 'Rignold', 'wrignold2w@thecloudedu.com', 'Male', '#cba7e9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (106, 'Perla', 'Zanneli', 'pzanneli2x@thecloudedu.com', 'Female', '#feaa71');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (107, 'Bill', 'Manton', 'bmanton2y@thecloudedu.com', 'Female', '#e637b9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (108, 'Debra', 'Rickarsey', 'drickarsey2z@thecloudedu.com', 'Female', '#611cc3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (109, 'Mano', 'Kerin', 'mkerin30@thecloudedu.com', 'Male', '#5b1e05');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (110, 'Thayne', 'Audrey', 'taudrey31@thecloudedu.com', 'Male', '#573dc0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (111, 'Livvy', 'Cay', 'lcay32@thecloudedu.com', 'Female', '#b3bfb1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (112, 'Traver', 'Bleythin', 'tbleythin33@thecloudedu.com', 'Male', '#3638f3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (113, 'Dimitri', 'Wallman', 'dwallman34@thecloudedu.com', 'Male', '#e47341');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (114, 'Carolynn', 'Browell', 'cbrowell35@thecloudedu.com', 'Female', '#ae7dc3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (115, 'Jessy', 'Grinikhin', 'jgrinikhin36@thecloudedu.com', 'Female', '#4f68b8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (116, 'Devon', 'Winfred', 'dwinfred37@thecloudedu.com', 'Female', '#6c0d7b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (117, 'Eleen', 'Loughran', 'eloughran38@thecloudedu.com', 'Female', '#68c521');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (118, 'Zabrina', 'Edlin', 'zedlin39@thecloudedu.com', 'Female', '#c0d59a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (119, 'Jeno', 'Donisthorpe', 'jdonisthorpe3a@thecloudedu.com', 'Male', '#7d39f8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (120, 'Darci', 'Kettles', 'dkettles3b@thecloudedu.com', 'Female', '#ea1608');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (121, 'Lauritz', 'Coryndon', 'lcoryndon3c@thecloudedu.com', 'Male', '#c2eed3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (122, 'Cass', 'Brearton', 'cbrearton3d@thecloudedu.com', 'Female', '#3b4e3d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (123, 'Tyler', 'Bolles', 'tbolles3e@thecloudedu.com', 'Male', '#7d3f54');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (124, 'York', 'Chaudhry', 'ychaudhry3f@thecloudedu.com', 'Male', '#99c7a7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (125, 'Dosi', 'Janc', 'djanc3g@thecloudedu.com', 'Female', '#5ce623');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (126, 'Galen', 'Whannel', 'gwhannel3h@thecloudedu.com', 'Male', '#6519b6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (127, 'Jennee', 'Simmins', 'jsimmins3i@thecloudedu.com', 'Female', '#5096dd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (128, 'Jaclyn', 'Checcuzzi', 'jcheccuzzi3j@thecloudedu.com', 'Female', '#bed8fa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (129, 'Candra', 'O''Bruen', 'cobruen3k@thecloudedu.com', 'Female', '#f5e679');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (130, 'Lena', 'Fleay', 'lfleay3l@thecloudedu.com', 'Female', '#d3d907');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (131, 'Glad', 'Olenov', 'golenov3m@thecloudedu.com', 'Female', '#ec83fc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (132, 'Farrell', 'Hardstaff', 'fhardstaff3n@thecloudedu.com', 'Male', '#654ca2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (133, 'Arvy', 'Dmych', 'admych3o@thecloudedu.com', 'Male', '#e47868');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (134, 'Montague', 'Rowney', 'mrowney3p@thecloudedu.com', 'Male', '#7927a6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (135, 'Abelard', 'Macenzy', 'amacenzy3q@thecloudedu.com', 'Male', '#4e9513');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (136, 'Pauline', 'Brimson', 'pbrimson3r@thecloudedu.com', 'Female', '#b5d03b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (137, 'Tiebout', 'Freemantle', 'tfreemantle3s@thecloudedu.com', 'Male', '#fd39c8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (138, 'Cly', 'Gerring', 'cgerring3t@thecloudedu.com', 'Male', '#7b8f0f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (139, 'Peter', 'Deinhard', 'pdeinhard3u@thecloudedu.com', 'Male', '#bf29ab');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (140, 'Blythe', 'Armstead', 'barmstead3v@thecloudedu.com', 'Female', '#aff6af');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (141, 'Lorne', 'Tibbs', 'ltibbs3w@thecloudedu.com', 'Female', '#c577e0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (142, 'Desirae', 'Muffett', 'dmuffett3x@thecloudedu.com', 'Female', '#d77540');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (143, 'Rachael', 'Well', 'rwell3y@thecloudedu.com', 'Female', '#b1c0d2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (144, 'Heywood', 'Turfes', 'hturfes3z@thecloudedu.com', 'Male', '#7a6ebc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (145, 'Martita', 'Stiff', 'mstiff40@thecloudedu.com', 'Female', '#05a4a2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (146, 'Hadria', 'Bridgland', 'hbridgland41@thecloudedu.com', 'Female', '#a9da34');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (147, 'Anders', 'McLoney', 'amcloney42@thecloudedu.com', 'Male', '#da8340');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (148, 'Valeda', 'Loney', 'vloney43@thecloudedu.com', 'Female', '#1d6d83');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (149, 'Cale', 'Neville', 'cneville44@thecloudedu.com', 'Male', '#841ff6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (150, 'Thekla', 'Buten', 'tbuten45@thecloudedu.com', 'Female', '#8591e7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (151, 'Hymie', 'Purse', 'hpurse46@thecloudedu.com', 'Male', '#85da34');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (152, 'Isidro', 'Yeskov', 'iyeskov47@thecloudedu.com', 'Male', '#5e0960');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (153, 'Jerry', 'Eberdt', 'jeberdt48@thecloudedu.com', 'Male', '#a24782');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (154, 'Frasquito', 'Earland', 'fearland49@thecloudedu.com', 'Male', '#0930c5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (155, 'Dorise', 'Baiyle', 'dbaiyle4a@thecloudedu.com', 'Female', '#11c39e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (156, 'Hirsch', 'McBride', 'hmcbride4b@thecloudedu.com', 'Male', '#60bd13');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (157, 'Dane', 'Norheny', 'dnorheny4c@thecloudedu.com', 'Male', '#dc4e66');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (158, 'Dannie', 'Pesselt', 'dpesselt4d@thecloudedu.com', 'Female', '#5a1eb9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (159, 'Hollis', 'Pearsall', 'hpearsall4e@thecloudedu.com', 'Male', '#f6a591');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (160, 'Walsh', 'Lemmens', 'wlemmens4f@thecloudedu.com', 'Male', '#0a4551');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (161, 'Zelma', 'Gronno', 'zgronno4g@thecloudedu.com', 'Female', '#b8d660');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (162, 'Konrad', 'Gooding', 'kgooding4h@thecloudedu.com', 'Male', '#c1ac46');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (163, 'Corrie', 'Bromehed', 'cbromehed4i@thecloudedu.com', 'Female', '#e342e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (164, 'Christabel', 'Lovett', 'clovett4j@thecloudedu.com', 'Female', '#5fc98d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (165, 'Dar', 'Dorset', 'ddorset4k@thecloudedu.com', 'Male', '#eb823f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (166, 'Loretta', 'Holburn', 'lholburn4l@thecloudedu.com', 'Female', '#45bbd1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (167, 'Jacky', 'Fargie', 'jfargie4m@thecloudedu.com', 'Female', '#a48b66');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (168, 'Prudi', 'Matissoff', 'pmatissoff4n@thecloudedu.com', 'Female', '#c362c5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (169, 'Evelina', 'Ayliffe', 'eayliffe4o@thecloudedu.com', 'Female', '#3dd7c1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (170, 'Joellyn', 'Pettisall', 'jpettisall4p@thecloudedu.com', 'Female', '#8b839d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (171, 'Elisabetta', 'Averall', 'eaverall4q@thecloudedu.com', 'Female', '#67585e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (172, 'Mitchell', 'Lankester', 'mlankester4r@thecloudedu.com', 'Male', '#435a98');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (173, 'Christalle', 'McCoid', 'cmccoid4s@thecloudedu.com', 'Female', '#ebeeb3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (174, 'Regina', 'Verheijden', 'rverheijden4t@thecloudedu.com', 'Female', '#5b8765');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (175, 'Nickey', 'Kornacki', 'nkornacki4u@thecloudedu.com', 'Male', '#709e3f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (176, 'Toinette', 'Howieson', 'thowieson4v@thecloudedu.com', 'Female', '#72bd27');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (177, 'Randie', 'Guerrazzi', 'rguerrazzi4w@thecloudedu.com', 'Male', '#519fdd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (178, 'Benedikt', 'Extence', 'bextence4x@thecloudedu.com', 'Male', '#78cf16');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (179, 'Ansell', 'Orehead', 'aorehead4y@thecloudedu.com', 'Male', '#476f14');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (180, 'Pooh', 'Goford', 'pgoford4z@thecloudedu.com', 'Male', '#fb00b2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (181, 'Cosetta', 'Lidgate', 'clidgate50@thecloudedu.com', 'Female', '#45d0ec');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (182, 'Giacomo', 'Gooding', 'ggooding51@thecloudedu.com', 'Male', '#3e5c46');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (183, 'Noell', 'Wickey', 'nwickey52@thecloudedu.com', 'Female', '#7c5bfa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (184, 'Burke', 'Worvell', 'bworvell53@thecloudedu.com', 'Male', '#c8822c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (185, 'Rodrick', 'Mohammad', 'rmohammad54@thecloudedu.com', 'Male', '#efaa9c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (186, 'Gennifer', 'Muddiman', 'gmuddiman55@thecloudedu.com', 'Female', '#c0522f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (187, 'Paton', 'Gilcriest', 'pgilcriest56@thecloudedu.com', 'Male', '#2967ee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (188, 'Pat', 'Bogart', 'pbogart57@thecloudedu.com', 'Female', '#fc4ce6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (189, 'Micaela', 'Edmondson', 'medmondson58@thecloudedu.com', 'Female', '#2ec117');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (190, 'Carma', 'Cottrell', 'ccottrell59@thecloudedu.com', 'Female', '#962cfb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (191, 'Ole', 'Buzin', 'obuzin5a@thecloudedu.com', 'Male', '#cae58a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (192, 'Shell', 'Capun', 'scapun5b@thecloudedu.com', 'Female', '#272c15');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (193, 'Kelsi', 'Olliffe', 'kolliffe5c@thecloudedu.com', 'Female', '#48f4c3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (194, 'Hanson', 'Leyton', 'hleyton5d@thecloudedu.com', 'Male', '#2fd820');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (195, 'Donetta', 'Lidierth', 'dlidierth5e@thecloudedu.com', 'Female', '#164314');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (196, 'Bordy', 'Gentner', 'bgentner5f@thecloudedu.com', 'Male', '#a4e472');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (197, 'Harlie', 'Paula', 'hpaula5g@thecloudedu.com', 'Female', '#034928');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (198, 'Frederique', 'Grills', 'fgrills5h@thecloudedu.com', 'Female', '#27f427');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (199, 'Babs', 'Senecaut', 'bsenecaut5i@thecloudedu.com', 'Female', '#ebc4b6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (200, 'Meridel', 'Jahner', 'mjahner5j@thecloudedu.com', 'Female', '#88632b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (201, 'Bearnard', 'Thoresbie', 'bthoresbie5k@thecloudedu.com', 'Male', '#04471b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (202, 'Lem', 'Welden', 'lwelden5l@thecloudedu.com', 'Male', '#98553b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (203, 'Kristel', 'Worsell', 'kworsell5m@thecloudedu.com', 'Female', '#8d8193');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (204, 'Christoforo', 'Ismail', 'cismail5n@thecloudedu.com', 'Male', '#83ff68');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (205, 'Scotty', 'Hentze', 'shentze5o@thecloudedu.com', 'Male', '#ca777f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (206, 'Ludovika', 'Itzkovwitch', 'litzkovwitch5p@thecloudedu.com', 'Female', '#4aec43');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (207, 'Kimmy', 'Sabates', 'ksabates5q@thecloudedu.com', 'Female', '#aa08b0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (208, 'Fredia', 'Oxenbury', 'foxenbury5r@thecloudedu.com', 'Female', '#48a43b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (209, 'Kim', 'Custy', 'kcusty5s@thecloudedu.com', 'Female', '#7a809d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (210, 'Rochester', 'Foale', 'rfoale5t@thecloudedu.com', 'Male', '#80cf3f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (211, 'Beale', 'Maystone', 'bmaystone5u@thecloudedu.com', 'Male', '#74c79b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (212, 'Ines', 'Nadin', 'inadin5v@thecloudedu.com', 'Female', '#f51e7e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (213, 'Patty', 'Pindar', 'ppindar5w@thecloudedu.com', 'Female', '#b27e26');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (214, 'Joelie', 'McLoney', 'jmcloney5x@thecloudedu.com', 'Female', '#070e08');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (215, 'Bekki', 'Farres', 'bfarres5y@thecloudedu.com', 'Female', '#404bbe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (216, 'Amelia', 'Eakins', 'aeakins5z@thecloudedu.com', 'Female', '#758a78');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (217, 'Morgen', 'Toyer', 'mtoyer60@thecloudedu.com', 'Male', '#a2f701');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (218, 'Oran', 'Burston', 'oburston61@thecloudedu.com', 'Male', '#865b4f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (219, 'Cart', 'Duprey', 'cduprey62@thecloudedu.com', 'Male', '#bce93f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (220, 'Priscella', 'Nairn', 'pnairn63@thecloudedu.com', 'Female', '#67295c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (221, 'Lynne', 'Pert', 'lpert64@thecloudedu.com', 'Female', '#e8db31');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (222, 'Gael', 'Mebes', 'gmebes65@thecloudedu.com', 'Male', '#86e172');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (223, 'Rich', 'Smallbone', 'rsmallbone66@thecloudedu.com', 'Male', '#f2565e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (224, 'Nell', 'Shipp', 'nshipp67@thecloudedu.com', 'Female', '#554f65');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (225, 'Bernie', 'Heale', 'bheale68@thecloudedu.com', 'Male', '#00f8f5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (226, 'Lorry', 'Workes', 'lworkes69@thecloudedu.com', 'Male', '#9c952f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (227, 'Amby', 'Checketts', 'achecketts6a@thecloudedu.com', 'Male', '#de32e4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (228, 'Aluino', 'Vieyra', 'avieyra6b@thecloudedu.com', 'Male', '#7efe6c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (229, 'Sax', 'Matkovic', 'smatkovic6c@thecloudedu.com', 'Male', '#428d1d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (230, 'Harp', 'Boat', 'hboat6d@thecloudedu.com', 'Male', '#755d93');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (231, 'Agatha', 'Bouda', 'abouda6e@thecloudedu.com', 'Female', '#9e43c6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (232, 'Sutherland', 'Dudleston', 'sdudleston6f@thecloudedu.com', 'Male', '#420b8e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (233, 'Tony', 'Burt', 'tburt6g@thecloudedu.com', 'Male', '#5ff87d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (234, 'Abbe', 'Nestor', 'anestor6h@thecloudedu.com', 'Female', '#2d1035');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (235, 'Shandie', 'McMenamy', 'smcmenamy6i@thecloudedu.com', 'Female', '#2e20ad');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (236, 'Maury', 'Oller', 'moller6j@thecloudedu.com', 'Male', '#5cce34');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (237, 'Sandi', 'Truman', 'struman6k@thecloudedu.com', 'Female', '#9a724d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (238, 'Andreas', 'Perchard', 'aperchard6l@thecloudedu.com', 'Male', '#bae8d9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (239, 'Aldin', 'Fallanche', 'afallanche6m@thecloudedu.com', 'Male', '#cdc48b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (240, 'Hayes', 'Ansell', 'hansell6n@thecloudedu.com', 'Male', '#157963');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (241, 'Garold', 'Wallice', 'gwallice6o@thecloudedu.com', 'Male', '#e741fb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (242, 'Jerry', 'Crathorne', 'jcrathorne6p@thecloudedu.com', 'Male', '#a08072');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (243, 'Ally', 'Hilhouse', 'ahilhouse6q@thecloudedu.com', 'Female', '#96f3b4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (244, 'Packston', 'Edie', 'pedie6r@thecloudedu.com', 'Male', '#99588d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (245, 'Asher', 'Fettis', 'afettis6s@thecloudedu.com', 'Male', '#cca6be');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (246, 'Shamus', 'Poluzzi', 'spoluzzi6t@thecloudedu.com', 'Male', '#f3dd8d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (247, 'Roberto', 'Popescu', 'rpopescu6u@thecloudedu.com', 'Male', '#2fda7f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (248, 'Kathrine', 'Van Halle', 'kvanhalle6v@thecloudedu.com', 'Female', '#464ddc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (249, 'Skye', 'MacArd', 'smacard6w@thecloudedu.com', 'Male', '#d39b0d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (250, 'Lynda', 'Sarvar', 'lsarvar6x@thecloudedu.com', 'Female', '#0e6fc1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (251, 'Hagan', 'Sclater', 'hsclater6y@thecloudedu.com', 'Male', '#19a37f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (252, 'Emlynne', 'Ipsly', 'eipsly6z@thecloudedu.com', 'Female', '#2ca6f0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (253, 'Maria', 'Colebourne', 'mcolebourne70@thecloudedu.com', 'Female', '#7243d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (254, 'Lukas', 'Breeds', 'lbreeds71@thecloudedu.com', 'Male', '#1f55fe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (255, 'Averell', 'Murricanes', 'amurricanes72@thecloudedu.com', 'Male', '#1a60af');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (256, 'Sheree', 'Rawlence', 'srawlence73@thecloudedu.com', 'Female', '#bb310e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (257, 'Lulita', 'Rapp', 'lrapp74@thecloudedu.com', 'Female', '#f30dc7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (258, 'Lenette', 'Betteriss', 'lbetteriss75@thecloudedu.com', 'Female', '#9bb973');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (259, 'Bree', 'Muscott', 'bmuscott76@thecloudedu.com', 'Female', '#7b7b2c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (260, 'Bald', 'Impson', 'bimpson77@thecloudedu.com', 'Male', '#0e306c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (261, 'Cairistiona', 'Berrycloth', 'cberrycloth78@thecloudedu.com', 'Female', '#f5f784');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (262, 'Virgie', 'Malsher', 'vmalsher79@thecloudedu.com', 'Male', '#fdc162');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (263, 'Abrahan', 'Capoun', 'acapoun7a@thecloudedu.com', 'Male', '#b37a5c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (264, 'Neall', 'Knappett', 'nknappett7b@thecloudedu.com', 'Male', '#5c5489');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (265, 'Dyanne', 'Doddemeade', 'ddoddemeade7c@thecloudedu.com', 'Female', '#75a691');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (266, 'Melania', 'Warlowe', 'mwarlowe7d@thecloudedu.com', 'Female', '#6880ea');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (267, 'Brand', 'Amber', 'bamber7e@thecloudedu.com', 'Male', '#05d633');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (268, 'Alfy', 'Tottem', 'atottem7f@thecloudedu.com', 'Female', '#667637');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (269, 'Alphard', 'MacClinton', 'amacclinton7g@thecloudedu.com', 'Male', '#4558e3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (270, 'Evonne', 'Farey', 'efarey7h@thecloudedu.com', 'Female', '#48aa4c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (271, 'Johanna', 'Dobkin', 'jdobkin7i@thecloudedu.com', 'Female', '#557aa0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (272, 'Noah', 'Lickorish', 'nlickorish7j@thecloudedu.com', 'Male', '#33b134');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (273, 'Jannel', 'Beevens', 'jbeevens7k@thecloudedu.com', 'Female', '#ed1c61');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (274, 'Onida', 'Whenham', 'owhenham7l@thecloudedu.com', 'Female', '#27ed8a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (275, 'Dorelle', 'Bernard', 'dbernard7m@thecloudedu.com', 'Female', '#68867e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (276, 'Virginia', 'Coultass', 'vcoultass7n@thecloudedu.com', 'Female', '#43d953');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (277, 'Uta', 'Attawell', 'uattawell7o@thecloudedu.com', 'Female', '#426213');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (278, 'Nolly', 'Bayle', 'nbayle7p@thecloudedu.com', 'Male', '#9bc1a4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (279, 'Dory', 'Vedeneev', 'dvedeneev7q@thecloudedu.com', 'Male', '#56d2ed');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (280, 'Garnet', 'Ghidini', 'gghidini7r@thecloudedu.com', 'Female', '#256a6d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (281, 'Jacquette', 'Eslinger', 'jeslinger7s@thecloudedu.com', 'Female', '#f830ac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (282, 'Mikkel', 'Beatty', 'mbeatty7t@thecloudedu.com', 'Male', '#9acd67');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (283, 'Van', 'Onge', 'vonge7u@thecloudedu.com', 'Male', '#00b083');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (284, 'Malva', 'Wethers', 'mwethers7v@thecloudedu.com', 'Female', '#165b48');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (285, 'Karrie', 'Kemmet', 'kkemmet7w@thecloudedu.com', 'Female', '#c88d89');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (286, 'Cristi', 'Doig', 'cdoig7x@thecloudedu.com', 'Female', '#f133bf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (287, 'Tyrus', 'Burkhill', 'tburkhill7y@thecloudedu.com', 'Male', '#e37e82');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (288, 'Eamon', 'Hawksby', 'ehawksby7z@thecloudedu.com', 'Male', '#f40233');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (289, 'Eliot', 'Tomaszczyk', 'etomaszczyk80@thecloudedu.com', 'Male', '#f9ee35');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (290, 'Timothee', 'Grigolon', 'tgrigolon81@thecloudedu.com', 'Male', '#30a4c8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (291, 'Otho', 'Bencher', 'obencher82@thecloudedu.com', 'Male', '#7b86c4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (292, 'Greer', 'Mulcahy', 'gmulcahy83@thecloudedu.com', 'Female', '#4ecee6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (293, 'Maye', 'Terbrugge', 'mterbrugge84@thecloudedu.com', 'Female', '#b962c0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (294, 'Way', 'Brockie', 'wbrockie85@thecloudedu.com', 'Male', '#d6d7de');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (295, 'Francyne', 'Baggiani', 'fbaggiani86@thecloudedu.com', 'Female', '#64c12b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (296, 'Sidnee', 'Henner', 'shenner87@thecloudedu.com', 'Male', '#f1b66d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (297, 'Genny', 'Peartree', 'gpeartree88@thecloudedu.com', 'Female', '#e47352');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (298, 'Guntar', 'De Avenell', 'gdeavenell89@thecloudedu.com', 'Male', '#4322f6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (299, 'Jacob', 'Pochon', 'jpochon8a@thecloudedu.com', 'Male', '#f9eddc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (300, 'Rod', 'Wadelin', 'rwadelin8b@thecloudedu.com', 'Male', '#a12076');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (301, 'Charmion', 'Espinas', 'cespinas8c@thecloudedu.com', 'Female', '#066b91');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (302, 'Homere', 'Le Breton', 'hlebreton8d@thecloudedu.com', 'Male', '#27f3db');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (303, 'Georgie', 'Renoden', 'grenoden8e@thecloudedu.com', 'Male', '#d6cb46');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (304, 'Lyle', 'Flicker', 'lflicker8f@thecloudedu.com', 'Male', '#c9d5d1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (305, 'Mariellen', 'Kettley', 'mkettley8g@thecloudedu.com', 'Female', '#ce3cc4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (306, 'Ira', 'Nortcliffe', 'inortcliffe8h@thecloudedu.com', 'Male', '#fdc685');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (307, 'Broddie', 'Dmiterko', 'bdmiterko8i@thecloudedu.com', 'Male', '#481f2a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (308, 'Gus', 'Plumm', 'gplumm8j@thecloudedu.com', 'Female', '#ae690f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (309, 'Theobald', 'Ashall', 'tashall8k@thecloudedu.com', 'Male', '#02690b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (310, 'Delly', 'Philpin', 'dphilpin8l@thecloudedu.com', 'Female', '#19fc4b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (311, 'Pen', 'Hawke', 'phawke8m@thecloudedu.com', 'Female', '#964408');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (312, 'Barby', 'Binden', 'bbinden8n@thecloudedu.com', 'Female', '#7eaee8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (313, 'Nellie', 'Shillaker', 'nshillaker8o@thecloudedu.com', 'Female', '#c25a6d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (314, 'Pasquale', 'Gerritzen', 'pgerritzen8p@thecloudedu.com', 'Male', '#84534c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (315, 'Pincus', 'Pitfield', 'ppitfield8q@thecloudedu.com', 'Male', '#b5a840');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (316, 'Yul', 'Poynzer', 'ypoynzer8r@thecloudedu.com', 'Male', '#b3ff33');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (317, 'Richardo', 'Badrick', 'rbadrick8s@thecloudedu.com', 'Male', '#aa5338');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (318, 'Cornela', 'Frusher', 'cfrusher8t@thecloudedu.com', 'Female', '#1a8866');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (319, 'Moses', 'Coady', 'mcoady8u@thecloudedu.com', 'Male', '#948108');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (320, 'Adolphus', 'Geator', 'ageator8v@thecloudedu.com', 'Male', '#dc5272');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (321, 'Yalonda', 'McMorland', 'ymcmorland8w@thecloudedu.com', 'Female', '#95741b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (322, 'Carver', 'Wolfindale', 'cwolfindale8x@thecloudedu.com', 'Male', '#81e1d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (323, 'Cassius', 'Dohms', 'cdohms8y@thecloudedu.com', 'Male', '#7403ac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (324, 'Randolf', 'Cobley', 'rcobley8z@thecloudedu.com', 'Male', '#b0e995');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (325, 'Cherilyn', 'Challiner', 'cchalliner90@thecloudedu.com', 'Female', '#ed633b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (326, 'Bethena', 'McKinley', 'bmckinley91@thecloudedu.com', 'Female', '#caaa0d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (327, 'Torr', 'Gozzett', 'tgozzett92@thecloudedu.com', 'Male', '#ea49c7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (328, 'Carmina', 'McKim', 'cmckim93@thecloudedu.com', 'Female', '#92d8f5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (329, 'Loni', 'Vogl', 'lvogl94@thecloudedu.com', 'Female', '#411884');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (330, 'Patsy', 'Valti', 'pvalti95@thecloudedu.com', 'Male', '#d31ed0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (331, 'Candra', 'Fitt', 'cfitt96@thecloudedu.com', 'Female', '#e93bde');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (332, 'Arthur', 'Redford', 'aredford97@thecloudedu.com', 'Male', '#acae1e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (333, 'Katy', 'Duprey', 'kduprey98@thecloudedu.com', 'Female', '#7385b0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (334, 'Wood', 'Macrae', 'wmacrae99@thecloudedu.com', 'Male', '#b8afd8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (335, 'Howard', 'Elwin', 'helwin9a@thecloudedu.com', 'Male', '#0b123c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (336, 'Juana', 'Cestard', 'jcestard9b@thecloudedu.com', 'Female', '#845374');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (337, 'Lacie', 'Atheis', 'latheis9c@thecloudedu.com', 'Female', '#ce20d4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (338, 'Adamo', 'Edgerton', 'aedgerton9d@thecloudedu.com', 'Male', '#9d0325');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (339, 'Jefferey', 'Bowie', 'jbowie9e@thecloudedu.com', 'Male', '#242d55');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (340, 'Editha', 'Baigrie', 'ebaigrie9f@thecloudedu.com', 'Female', '#37d676');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (341, 'Kathrine', 'Hennington', 'khennington9g@thecloudedu.com', 'Female', '#42d757');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (342, 'Enos', 'Tyas', 'etyas9h@thecloudedu.com', 'Male', '#be3f16');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (343, 'Lianne', 'Tytherton', 'ltytherton9i@thecloudedu.com', 'Female', '#0c9eac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (344, 'Whitby', 'Turfs', 'wturfs9j@thecloudedu.com', 'Male', '#4b74df');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (345, 'Fernanda', 'Doerrling', 'fdoerrling9k@thecloudedu.com', 'Female', '#90f979');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (346, 'Aluino', 'Rickword', 'arickword9l@thecloudedu.com', 'Male', '#c4e2b7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (347, 'Cobby', 'Bushel', 'cbushel9m@thecloudedu.com', 'Male', '#32e5e7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (348, 'Wilt', 'Janaszewski', 'wjanaszewski9n@thecloudedu.com', 'Male', '#6db42c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (349, 'Saw', 'Juzek', 'sjuzek9o@thecloudedu.com', 'Male', '#3ec513');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (350, 'Lanna', 'Duffitt', 'lduffitt9p@thecloudedu.com', 'Female', '#f1604e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (351, 'Aimee', 'Wincer', 'awincer9q@thecloudedu.com', 'Female', '#37e7fe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (352, 'Selig', 'Cowtherd', 'scowtherd9r@thecloudedu.com', 'Male', '#e17244');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (353, 'Clarie', 'Whinray', 'cwhinray9s@thecloudedu.com', 'Female', '#bcb90a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (354, 'Morrie', 'Taillant', 'mtaillant9t@thecloudedu.com', 'Male', '#591674');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (355, 'Izak', 'Reddy', 'ireddy9u@thecloudedu.com', 'Male', '#52b1e5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (356, 'Kennett', 'Mangenet', 'kmangenet9v@thecloudedu.com', 'Male', '#b8ae07');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (357, 'Dell', 'Tootin', 'dtootin9w@thecloudedu.com', 'Female', '#ef29ba');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (358, 'Karlis', 'Pawlett', 'kpawlett9x@thecloudedu.com', 'Male', '#104886');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (359, 'Yanaton', 'Faircley', 'yfaircley9y@thecloudedu.com', 'Male', '#ea4ae8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (360, 'Blondie', 'Priddey', 'bpriddey9z@thecloudedu.com', 'Female', '#3fff64');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (361, 'Zsa zsa', 'Crucetti', 'zcrucettia0@thecloudedu.com', 'Female', '#2ad93c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (362, 'Ariela', 'Warne', 'awarnea1@thecloudedu.com', 'Female', '#97dfae');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (363, 'Ellissa', 'Boxer', 'eboxera2@thecloudedu.com', 'Female', '#ea34a0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (364, 'Shari', 'Patrie', 'spatriea3@thecloudedu.com', 'Female', '#bbb173');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (365, 'Meir', 'Petche', 'mpetchea4@thecloudedu.com', 'Male', '#d82a3e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (366, 'Gallard', 'Cairney', 'gcairneya5@thecloudedu.com', 'Male', '#d45813');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (367, 'Pinchas', 'Pearch', 'ppearcha6@thecloudedu.com', 'Male', '#0739dc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (368, 'Lewie', 'Hillborne', 'lhillbornea7@thecloudedu.com', 'Male', '#b37b2b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (369, 'Anne-corinne', 'Bowick', 'abowicka8@thecloudedu.com', 'Female', '#58d7db');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (370, 'Whitney', 'Parris', 'wparrisa9@thecloudedu.com', 'Male', '#bc3c63');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (371, 'Perkin', 'Goudie', 'pgoudieaa@thecloudedu.com', 'Male', '#19397a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (372, 'August', 'Byng', 'abyngab@thecloudedu.com', 'Male', '#0e32d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (373, 'Charissa', 'Worsnip', 'cworsnipac@thecloudedu.com', 'Female', '#27c901');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (374, 'Jaymee', 'McDermid', 'jmcdermidad@thecloudedu.com', 'Female', '#40d18b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (375, 'Caty', 'Duberry', 'cduberryae@thecloudedu.com', 'Female', '#7e1261');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (376, 'Conrade', 'Vayne', 'cvayneaf@thecloudedu.com', 'Male', '#251959');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (377, 'Costa', 'Goldhawk', 'cgoldhawkag@thecloudedu.com', 'Male', '#452f87');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (378, 'Theodora', 'Cartin', 'tcartinah@thecloudedu.com', 'Female', '#60012c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (379, 'Lind', 'Stimpson', 'lstimpsonai@thecloudedu.com', 'Male', '#f19d15');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (380, 'Shae', 'Willingam', 'swillingamaj@thecloudedu.com', 'Male', '#1bc120');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (381, 'Hildagarde', 'Rillatt', 'hrillattak@thecloudedu.com', 'Female', '#b50b4f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (382, 'Blane', 'Bragger', 'bbraggeral@thecloudedu.com', 'Male', '#3bde3b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (383, 'Issiah', 'Morgue', 'imorgueam@thecloudedu.com', 'Male', '#b8a67f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (384, 'Cyb', 'Levi', 'clevian@thecloudedu.com', 'Female', '#39d033');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (385, 'Bobbye', 'Dilley', 'bdilleyao@thecloudedu.com', 'Female', '#ba7c9f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (386, 'Sanford', 'Beauman', 'sbeaumanap@thecloudedu.com', 'Male', '#c8fff2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (387, 'Heidi', 'Jobb', 'hjobbaq@thecloudedu.com', 'Female', '#3b59da');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (388, 'Camella', 'Walstow', 'cwalstowar@thecloudedu.com', 'Female', '#78d537');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (389, 'Alva', 'Hoffner', 'ahoffneras@thecloudedu.com', 'Male', '#349bdd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (390, 'Tiebout', 'Jinkinson', 'tjinkinsonat@thecloudedu.com', 'Male', '#787f35');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (391, 'Flossy', 'Thornthwaite', 'fthornthwaiteau@thecloudedu.com', 'Female', '#f7491a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (392, 'Casey', 'McCrossan', 'cmccrossanav@thecloudedu.com', 'Male', '#57b5d4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (393, 'Silvano', 'Rapps', 'srappsaw@thecloudedu.com', 'Male', '#a24a88');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (394, 'Hendrick', 'Bertomeu', 'hbertomeuax@thecloudedu.com', 'Male', '#0764d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (395, 'Dre', 'MacAughtrie', 'dmacaughtrieay@thecloudedu.com', 'Female', '#51807b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (396, 'Faythe', 'Spandley', 'fspandleyaz@thecloudedu.com', 'Female', '#fcd52e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (397, 'Francisco', 'Muncey', 'fmunceyb0@thecloudedu.com', 'Male', '#ca267f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (398, 'Mommy', 'Newis', 'mnewisb1@thecloudedu.com', 'Female', '#8cc62a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (399, 'Clarette', 'Merveille', 'cmerveilleb2@thecloudedu.com', 'Female', '#65b27d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (400, 'Hewet', 'Turnock', 'hturnockb3@thecloudedu.com', 'Male', '#e00027');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (401, 'Garwood', 'Clue', 'gclueb4@thecloudedu.com', 'Male', '#050664');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (402, 'Wolfgang', 'Pocknoll', 'wpocknollb5@thecloudedu.com', 'Male', '#1b1dfc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (403, 'Kalvin', 'Wholesworth', 'kwholesworthb6@thecloudedu.com', 'Male', '#9705c3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (404, 'Stephana', 'Dubois', 'sduboisb7@thecloudedu.com', 'Female', '#74eabe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (405, 'Cherilyn', 'Franke', 'cfrankeb8@thecloudedu.com', 'Female', '#b71b0c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (406, 'Filip', 'Caldron', 'fcaldronb9@thecloudedu.com', 'Male', '#77a8c1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (407, 'Lori', 'Darlasson', 'ldarlassonba@thecloudedu.com', 'Female', '#5e9ea1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (408, 'Bernete', 'Branwhite', 'bbranwhitebb@thecloudedu.com', 'Female', '#76535a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (409, 'Kippie', 'Roebuck', 'kroebuckbc@thecloudedu.com', 'Female', '#c79eee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (410, 'Orran', 'Pumphrey', 'opumphreybd@thecloudedu.com', 'Male', '#8e00ac');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (411, 'Brita', 'Tolotti', 'btolottibe@thecloudedu.com', 'Female', '#7ef490');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (412, 'Alia', 'Dansken', 'adanskenbf@thecloudedu.com', 'Female', '#f13926');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (413, 'Saba', 'Wymer', 'swymerbg@thecloudedu.com', 'Female', '#6a3ae8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (414, 'Anjela', 'Chapellow', 'achapellowbh@thecloudedu.com', 'Female', '#925c2c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (415, 'Phil', 'Breakspear', 'pbreakspearbi@thecloudedu.com', 'Male', '#2da9ad');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (416, 'Porty', 'Tabbitt', 'ptabbittbj@thecloudedu.com', 'Male', '#e7224b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (417, 'Aeriell', 'Powlesland', 'apowleslandbk@thecloudedu.com', 'Female', '#136f07');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (418, 'Abbe', 'Habbeshaw', 'ahabbeshawbl@thecloudedu.com', 'Female', '#4f6fb1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (419, 'Alaric', 'McEnery', 'amcenerybm@thecloudedu.com', 'Male', '#1d1fe4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (420, 'Marvin', 'Coniam', 'mconiambn@thecloudedu.com', 'Male', '#9975bd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (421, 'Denny', 'Lamputt', 'dlamputtbo@thecloudedu.com', 'Male', '#d19fab');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (422, 'Dannie', 'Geely', 'dgeelybp@thecloudedu.com', 'Male', '#50c440');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (423, 'Jerald', 'Conyers', 'jconyersbq@thecloudedu.com', 'Male', '#9aa8f0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (424, 'Mariya', 'Baron', 'mbaronbr@thecloudedu.com', 'Female', '#9b9ff3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (425, 'Niel', 'Figure', 'nfigurebs@thecloudedu.com', 'Male', '#3cf4ee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (426, 'Gabbie', 'Peyes', 'gpeyesbt@thecloudedu.com', 'Male', '#56835b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (427, 'Natassia', 'Tournie', 'ntourniebu@thecloudedu.com', 'Female', '#879bbe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (428, 'Maximilianus', 'Callar', 'mcallarbv@thecloudedu.com', 'Male', '#131915');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (429, 'Natalie', 'Crinidge', 'ncrinidgebw@thecloudedu.com', 'Female', '#0842e4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (430, 'Renell', 'Thirst', 'rthirstbx@thecloudedu.com', 'Female', '#c1143e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (431, 'Madelene', 'Joris', 'mjorisby@thecloudedu.com', 'Female', '#40f6b5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (432, 'Laverna', 'Cowdray', 'lcowdraybz@thecloudedu.com', 'Female', '#b9a7ae');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (433, 'Lee', 'Roselli', 'lrosellic0@thecloudedu.com', 'Male', '#39c8a7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (434, 'Norry', 'Sainte Paul', 'nsaintepaulc1@thecloudedu.com', 'Male', '#0bc467');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (435, 'Teddy', 'Tregiddo', 'ttregiddoc2@thecloudedu.com', 'Male', '#91d711');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (436, 'Gretta', 'Tambling', 'gtamblingc3@thecloudedu.com', 'Female', '#dd5fdf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (437, 'Frans', 'Lyddiatt', 'flyddiattc4@thecloudedu.com', 'Male', '#2bf3e5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (438, 'Merle', 'Shirt', 'mshirtc5@thecloudedu.com', 'Female', '#fa2aff');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (439, 'Remus', 'Dronsfield', 'rdronsfieldc6@thecloudedu.com', 'Male', '#ac8518');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (440, 'Francisco', 'Coggeshall', 'fcoggeshallc7@thecloudedu.com', 'Male', '#de3b2d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (441, 'Tanitansy', 'MacCrackan', 'tmaccrackanc8@thecloudedu.com', 'Female', '#eb849f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (442, 'Eadmund', 'Shiell', 'eshiellc9@thecloudedu.com', 'Male', '#480ca7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (443, 'Nikolaus', 'Nodes', 'nnodesca@thecloudedu.com', 'Male', '#a0b98f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (444, 'Pinchas', 'Yoakley', 'pyoakleycb@thecloudedu.com', 'Male', '#a21aee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (445, 'Alfredo', 'Kuschke', 'akuschkecc@thecloudedu.com', 'Male', '#12622d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (446, 'Jenda', 'Basini-Gazzi', 'jbasinigazzicd@thecloudedu.com', 'Female', '#e6f274');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (447, 'Christina', 'Braven', 'cbravence@thecloudedu.com', 'Female', '#16e016');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (448, 'Merle', 'Riditch', 'mriditchcf@thecloudedu.com', 'Male', '#6b7457');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (449, 'Kati', 'Simson', 'ksimsoncg@thecloudedu.com', 'Female', '#5de438');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (450, 'Peri', 'Slaney', 'pslaneych@thecloudedu.com', 'Female', '#412f4f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (451, 'Guenevere', 'Wilbore', 'gwilboreci@thecloudedu.com', 'Female', '#a7d3c6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (452, 'Sibyl', 'Swindell', 'sswindellcj@thecloudedu.com', 'Male', '#7b3e18');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (453, 'Adham', 'Featherby', 'afeatherbyck@thecloudedu.com', 'Male', '#7af52e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (454, 'Ruthie', 'Dwelley', 'rdwelleycl@thecloudedu.com', 'Female', '#66df8f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (455, 'Loella', 'McKeeman', 'lmckeemancm@thecloudedu.com', 'Female', '#0a7a7a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (456, 'Olivia', 'Caush', 'ocaushcn@thecloudedu.com', 'Female', '#65ff37');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (457, 'Yvonne', 'Siburn', 'ysiburnco@thecloudedu.com', 'Female', '#e00340');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (458, 'Kylie', 'Kinnon', 'kkinnoncp@thecloudedu.com', 'Female', '#5ab464');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (459, 'Allistir', 'Lawful', 'alawfulcq@thecloudedu.com', 'Male', '#795af2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (460, 'Lenci', 'Skough', 'lskoughcr@thecloudedu.com', 'Male', '#8a43e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (461, 'Gerard', 'Gert', 'ggertcs@thecloudedu.com', 'Male', '#f7be1a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (462, 'Shanie', 'Orbell', 'sorbellct@thecloudedu.com', 'Female', '#3e0318');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (463, 'Beniamino', 'Boorer', 'bboorercu@thecloudedu.com', 'Male', '#4260d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (464, 'Inglebert', 'Bonn', 'ibonncv@thecloudedu.com', 'Male', '#4f595e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (465, 'Guillermo', 'Jencey', 'gjenceycw@thecloudedu.com', 'Male', '#ff1f2b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (466, 'Dane', 'Sollitt', 'dsollittcx@thecloudedu.com', 'Male', '#da27c4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (467, 'Wallache', 'Dubble', 'wdubblecy@thecloudedu.com', 'Male', '#d4d598');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (468, 'Lauren', 'Cranke', 'lcrankecz@thecloudedu.com', 'Female', '#b3e6ee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (469, 'Luis', 'Letson', 'lletsond0@thecloudedu.com', 'Male', '#114b00');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (470, 'Merry', 'Constant', 'mconstantd1@thecloudedu.com', 'Male', '#503af8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (471, 'Kennie', 'Stewartson', 'kstewartsond2@thecloudedu.com', 'Male', '#2180e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (472, 'Bertina', 'Jeram', 'bjeramd3@thecloudedu.com', 'Female', '#3c4328');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (473, 'Shoshana', 'Malster', 'smalsterd4@thecloudedu.com', 'Female', '#19f42b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (474, 'Conant', 'Baff', 'cbaffd5@thecloudedu.com', 'Male', '#885ab0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (475, 'Chaim', 'Pilsworth', 'cpilsworthd6@thecloudedu.com', 'Male', '#772417');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (476, 'Hendrik', 'Simioli', 'hsimiolid7@thecloudedu.com', 'Male', '#7b21e0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (477, 'Kiah', 'Benedtti', 'kbenedttid8@thecloudedu.com', 'Female', '#faaf1f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (478, 'Evangelin', 'MacElholm', 'emacelholmd9@thecloudedu.com', 'Female', '#eb404e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (479, 'Fairfax', 'Moogan', 'fmooganda@thecloudedu.com', 'Male', '#9e8e37');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (480, 'Libbey', 'D''eathe', 'ldeathedb@thecloudedu.com', 'Female', '#31b805');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (481, 'Evangelin', 'Salvadore', 'esalvadoredc@thecloudedu.com', 'Female', '#425e49');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (482, 'Jemmy', 'Monte', 'jmontedd@thecloudedu.com', 'Female', '#ce6b11');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (483, 'Emlen', 'Clothier', 'eclothierde@thecloudedu.com', 'Male', '#90c4e4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (484, 'Nefen', 'Iannitti', 'niannittidf@thecloudedu.com', 'Male', '#c824aa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (485, 'Rodolphe', 'Greeding', 'rgreedingdg@thecloudedu.com', 'Male', '#2f96d2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (486, 'Celestia', 'Levens', 'clevensdh@thecloudedu.com', 'Female', '#d75c08');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (487, 'Abbey', 'Shercliff', 'ashercliffdi@thecloudedu.com', 'Female', '#381ff8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (488, 'Gusella', 'Klaassens', 'gklaassensdj@thecloudedu.com', 'Female', '#9e19d5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (489, 'Rudd', 'Wolfe', 'rwolfedk@thecloudedu.com', 'Male', '#be4810');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (490, 'Lucita', 'Lambrecht', 'llambrechtdl@thecloudedu.com', 'Female', '#0b8d3a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (491, 'Gillan', 'Kepling', 'gkeplingdm@thecloudedu.com', 'Female', '#855f8f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (492, 'Humbert', 'Skeete', 'hskeetedn@thecloudedu.com', 'Male', '#579eb7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (493, 'Berri', 'Bullick', 'bbullickdo@thecloudedu.com', 'Female', '#858dcf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (494, 'Cazzie', 'Malletratt', 'cmalletrattdp@thecloudedu.com', 'Male', '#e87199');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (495, 'Petronella', 'Gilbride', 'pgilbridedq@thecloudedu.com', 'Female', '#914ccf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (496, 'Merl', 'Terbeek', 'mterbeekdr@thecloudedu.com', 'Female', '#cdb84b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (497, 'Angie', 'Oddey', 'aoddeyds@thecloudedu.com', 'Male', '#357580');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (498, 'Katalin', 'Mellody', 'kmellodydt@thecloudedu.com', 'Female', '#050cdb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (499, 'Lamont', 'Biasotti', 'lbiasottidu@thecloudedu.com', 'Male', '#13f4c2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (500, 'Martainn', 'Streeting', 'mstreetingdv@thecloudedu.com', 'Male', '#0852c0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (501, 'Frankie', 'Coneau', 'fconeaudw@thecloudedu.com', 'Female', '#3b5824');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (502, 'Arabela', 'Heinke', 'aheinkedx@thecloudedu.com', 'Female', '#26ed59');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (503, 'Charita', 'Duckerin', 'cduckerindy@thecloudedu.com', 'Female', '#ca9b71');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (504, 'Lock', 'McGeagh', 'lmcgeaghdz@thecloudedu.com', 'Male', '#d1da2f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (505, 'Kellen', 'Standfield', 'kstandfielde0@thecloudedu.com', 'Male', '#590f89');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (506, 'Betti', 'Jarred', 'bjarrede1@thecloudedu.com', 'Female', '#1c64f0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (507, 'Paige', 'Bernolet', 'pbernolete2@thecloudedu.com', 'Female', '#71585e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (508, 'Arturo', 'Gruszczak', 'agruszczake3@thecloudedu.com', 'Male', '#0c3cb3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (509, 'Kermy', 'Brosel', 'kbrosele4@thecloudedu.com', 'Male', '#3db464');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (510, 'Hermie', 'Matiewe', 'hmatiewee5@thecloudedu.com', 'Male', '#c2851d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (511, 'Devi', 'Clohisey', 'dclohiseye6@thecloudedu.com', 'Female', '#c261fe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (512, 'Meghann', 'Filppetti', 'mfilppettie7@thecloudedu.com', 'Female', '#f91423');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (513, 'Halsy', 'Trays', 'htrayse8@thecloudedu.com', 'Male', '#0ec99e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (514, 'Pierre', 'Gaffey', 'pgaffeye9@thecloudedu.com', 'Male', '#5f90d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (515, 'Fleur', 'Stoller', 'fstollerea@thecloudedu.com', 'Female', '#068712');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (516, 'Rufe', 'Possa', 'rpossaeb@thecloudedu.com', 'Male', '#452252');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (517, 'Rosemaria', 'Dearnaly', 'rdearnalyec@thecloudedu.com', 'Female', '#cf1b46');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (518, 'Margo', 'Ridgway', 'mridgwayed@thecloudedu.com', 'Female', '#4543f2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (519, 'Marjy', 'Ionesco', 'mionescoee@thecloudedu.com', 'Female', '#f7876b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (520, 'Huntley', 'Keoghane', 'hkeoghaneef@thecloudedu.com', 'Male', '#1dc757');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (521, 'Melita', 'McGoldrick', 'mmcgoldrickeg@thecloudedu.com', 'Female', '#43d77c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (522, 'Case', 'Harvett', 'charvetteh@thecloudedu.com', 'Male', '#05eeaf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (523, 'Ilyssa', 'Stiling', 'istilingei@thecloudedu.com', 'Female', '#3d675d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (524, 'Antonius', 'Blissitt', 'ablissittej@thecloudedu.com', 'Male', '#759967');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (525, 'Amaleta', 'Normant', 'anormantek@thecloudedu.com', 'Female', '#12b242');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (526, 'Ricki', 'Rogans', 'rrogansel@thecloudedu.com', 'Male', '#2888d4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (527, 'Hamid', 'Tennewell', 'htennewellem@thecloudedu.com', 'Male', '#9c8f34');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (528, 'Geri', 'Meadows', 'gmeadowsen@thecloudedu.com', 'Female', '#b74c63');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (529, 'Parnell', 'Readhead', 'preadheadeo@thecloudedu.com', 'Male', '#50ac08');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (530, 'Cordell', 'Copsey', 'ccopseyep@thecloudedu.com', 'Male', '#ca2eb6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (531, 'Dominica', 'Pinnegar', 'dpinnegareq@thecloudedu.com', 'Female', '#8698e7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (532, 'Lee', 'Gosden', 'lgosdener@thecloudedu.com', 'Male', '#914bea');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (533, 'Rosalinde', 'Longhorne', 'rlonghornees@thecloudedu.com', 'Female', '#381e3f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (534, 'Ashil', 'O''Sheeryne', 'aosheeryneet@thecloudedu.com', 'Female', '#53ed8d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (535, 'Dotty', 'Doidge', 'ddoidgeeu@thecloudedu.com', 'Female', '#c2b834');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (536, 'Frankie', 'Pablo', 'fpabloev@thecloudedu.com', 'Male', '#695023');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (537, 'Edsel', 'Beams', 'ebeamsew@thecloudedu.com', 'Male', '#52673f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (538, 'Rudy', 'Bunney', 'rbunneyex@thecloudedu.com', 'Male', '#0b796e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (539, 'Raine', 'Brade', 'rbradeey@thecloudedu.com', 'Female', '#196631');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (540, 'Chelsae', 'Makinson', 'cmakinsonez@thecloudedu.com', 'Female', '#e4bb85');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (541, 'Oona', 'Halse', 'ohalsef0@thecloudedu.com', 'Female', '#bd72cc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (542, 'Stanleigh', 'Pockett', 'spockettf1@thecloudedu.com', 'Male', '#1e91da');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (543, 'Dougy', 'Durbin', 'ddurbinf2@thecloudedu.com', 'Male', '#25dfc0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (544, 'Joyan', 'Tills', 'jtillsf3@thecloudedu.com', 'Female', '#398a7f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (545, 'Archaimbaud', 'Jahnig', 'ajahnigf4@thecloudedu.com', 'Male', '#9e8107');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (546, 'Taddeusz', 'Goldby', 'tgoldbyf5@thecloudedu.com', 'Male', '#04e5b5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (547, 'Holden', 'Rockell', 'hrockellf6@thecloudedu.com', 'Male', '#64cf68');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (548, 'Hallie', 'Jest', 'hjestf7@thecloudedu.com', 'Female', '#5ddb9c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (549, 'Jeanine', 'Ragat', 'jragatf8@thecloudedu.com', 'Female', '#a9794d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (550, 'Janos', 'Iglesia', 'jiglesiaf9@thecloudedu.com', 'Male', '#7906b3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (551, 'Artie', 'Rowantree', 'arowantreefa@thecloudedu.com', 'Male', '#a2ee17');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (552, 'Nicky', 'Beddis', 'nbeddisfb@thecloudedu.com', 'Male', '#903793');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (553, 'Mair', 'Pulham', 'mpulhamfc@thecloudedu.com', 'Female', '#88fd80');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (554, 'Whittaker', 'Bugg', 'wbuggfd@thecloudedu.com', 'Male', '#115701');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (555, 'Iona', 'Deave', 'ideavefe@thecloudedu.com', 'Female', '#4e126d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (556, 'Shirley', 'Vondruska', 'svondruskaff@thecloudedu.com', 'Female', '#845231');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (557, 'Niall', 'Satch', 'nsatchfg@thecloudedu.com', 'Male', '#b8b02d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (558, 'Saidee', 'Smithen', 'ssmithenfh@thecloudedu.com', 'Female', '#3918d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (559, 'Reggis', 'Barraclough', 'rbarracloughfi@thecloudedu.com', 'Male', '#115652');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (560, 'Georgetta', 'Rampage', 'grampagefj@thecloudedu.com', 'Female', '#3194e7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (561, 'Dianne', 'Myott', 'dmyottfk@thecloudedu.com', 'Female', '#ed0d2c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (562, 'Berny', 'Ruby', 'brubyfl@thecloudedu.com', 'Female', '#c2d4a1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (563, 'Kenna', 'Voff', 'kvofffm@thecloudedu.com', 'Female', '#8f3586');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (564, 'Averil', 'Riach', 'ariachfn@thecloudedu.com', 'Male', '#9e8210');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (565, 'Verna', 'MacCafferty', 'vmaccaffertyfo@thecloudedu.com', 'Female', '#cafd9a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (566, 'Hi', 'Van Saltsberg', 'hvansaltsbergfp@thecloudedu.com', 'Male', '#042602');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (567, 'Ahmad', 'Lambourn', 'alambournfq@thecloudedu.com', 'Male', '#3c8f9c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (568, 'Cyrille', 'Heeley', 'cheeleyfr@thecloudedu.com', 'Male', '#e9fc37');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (569, 'Emmett', 'MacConneely', 'emacconneelyfs@thecloudedu.com', 'Male', '#d5487e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (570, 'Mavis', 'Aberkirder', 'maberkirderft@thecloudedu.com', 'Female', '#433a4a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (571, 'Ingmar', 'Joul', 'ijoulfu@thecloudedu.com', 'Male', '#0d46c2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (572, 'Kimble', 'Duffy', 'kduffyfv@thecloudedu.com', 'Male', '#c66087');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (573, 'Germain', 'Woodhead', 'gwoodheadfw@thecloudedu.com', 'Female', '#038f56');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (574, 'Kelsy', 'Stonard', 'kstonardfx@thecloudedu.com', 'Female', '#c8ab7e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (575, 'Cordula', 'Winchcombe', 'cwinchcombefy@thecloudedu.com', 'Female', '#e17a47');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (576, 'Cam', 'Chable', 'cchablefz@thecloudedu.com', 'Male', '#6b5b61');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (577, 'Gilligan', 'Dunthorn', 'gdunthorng0@thecloudedu.com', 'Female', '#a0040d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (578, 'Alden', 'Buret', 'aburetg1@thecloudedu.com', 'Male', '#ffa210');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (579, 'Mechelle', 'Dignum', 'mdignumg2@thecloudedu.com', 'Female', '#00e838');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (580, 'Salomi', 'Loyd', 'sloydg3@thecloudedu.com', 'Female', '#57983b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (581, 'Sebastian', 'Exrol', 'sexrolg4@thecloudedu.com', 'Male', '#b3ce24');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (582, 'Pen', 'Gullivent', 'pgulliventg5@thecloudedu.com', 'Female', '#8431b4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (583, 'Jamey', 'Causer', 'jcauserg6@thecloudedu.com', 'Male', '#7b7c4e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (584, 'Jillayne', 'Heffernan', 'jheffernang7@thecloudedu.com', 'Female', '#472084');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (585, 'Calley', 'Fullick', 'cfullickg8@thecloudedu.com', 'Female', '#96de5c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (586, 'Vanya', 'Standbrook', 'vstandbrookg9@thecloudedu.com', 'Male', '#dbe78b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (587, 'Oliviero', 'MacPhail', 'omacphailga@thecloudedu.com', 'Male', '#b7d4e4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (588, 'Quintilla', 'Farquarson', 'qfarquarsongb@thecloudedu.com', 'Female', '#6899af');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (589, 'Elga', 'Gallie', 'egalliegc@thecloudedu.com', 'Female', '#c7773f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (590, 'Elvin', 'Tschirasche', 'etschiraschegd@thecloudedu.com', 'Male', '#bcde32');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (591, 'Tawnya', 'Fairnie', 'tfairniege@thecloudedu.com', 'Female', '#c6d9d4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (592, 'Ole', 'Gorges', 'ogorgesgf@thecloudedu.com', 'Male', '#bff313');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (593, 'Michal', 'Alexandrou', 'malexandrougg@thecloudedu.com', 'Male', '#e52e58');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (594, 'Cristen', 'Pollok', 'cpollokgh@thecloudedu.com', 'Female', '#ab38f4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (595, 'Nixie', 'Redsull', 'nredsullgi@thecloudedu.com', 'Female', '#33e6bd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (596, 'Marcos', 'Blant', 'mblantgj@thecloudedu.com', 'Male', '#b6c490');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (597, 'Adelaide', 'Lowers', 'alowersgk@thecloudedu.com', 'Female', '#fec12b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (598, 'Ayn', 'Olenchenko', 'aolenchenkogl@thecloudedu.com', 'Female', '#cad481');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (599, 'Aristotle', 'Lunney', 'alunneygm@thecloudedu.com', 'Male', '#1eebd9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (600, 'Bud', 'Rowen', 'browengn@thecloudedu.com', 'Male', '#f5bdee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (601, 'Sunny', 'Ogilby', 'sogilbygo@thecloudedu.com', 'Male', '#271f57');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (602, 'Timi', 'Weale', 'twealegp@thecloudedu.com', 'Female', '#67fdc0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (603, 'Dorri', 'Preshaw', 'dpreshawgq@thecloudedu.com', 'Female', '#64ee94');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (604, 'Nicolis', 'Juster', 'njustergr@thecloudedu.com', 'Male', '#8112fc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (605, 'Dannie', 'Peckitt', 'dpeckittgs@thecloudedu.com', 'Female', '#9be76a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (606, 'Helaina', 'Fielders', 'hfieldersgt@thecloudedu.com', 'Female', '#3f0a5f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (607, 'Udell', 'Sawyers', 'usawyersgu@thecloudedu.com', 'Male', '#2fe546');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (608, 'Egan', 'Bugden', 'ebugdengv@thecloudedu.com', 'Male', '#2c6379');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (609, 'Wynn', 'Blanc', 'wblancgw@thecloudedu.com', 'Female', '#7b4858');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (610, 'Martguerita', 'Leatherborrow', 'mleatherborrowgx@thecloudedu.com', 'Female', '#848922');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (611, 'Elita', 'Radin', 'eradingy@thecloudedu.com', 'Female', '#24d40d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (612, 'Elysha', 'Almon', 'ealmongz@thecloudedu.com', 'Female', '#0219df');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (613, 'Fairfax', 'De Wolfe', 'fdewolfeh0@thecloudedu.com', 'Male', '#faf3d0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (614, 'Westbrooke', 'Mangan', 'wmanganh1@thecloudedu.com', 'Male', '#a8d17b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (615, 'Brittany', 'Cornhill', 'bcornhillh2@thecloudedu.com', 'Female', '#705df8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (616, 'Bibby', 'Keywood', 'bkeywoodh3@thecloudedu.com', 'Female', '#838f95');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (617, 'Liv', 'Vorley', 'lvorleyh4@thecloudedu.com', 'Female', '#581489');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (618, 'Maxie', 'Stillgoe', 'mstillgoeh5@thecloudedu.com', 'Male', '#c54d97');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (619, 'Alan', 'Elegood', 'aelegoodh6@thecloudedu.com', 'Male', '#83cfcf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (620, 'Quincy', 'Peschke', 'qpeschkeh7@thecloudedu.com', 'Male', '#24da30');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (621, 'Frederich', 'Hanshawe', 'fhanshaweh8@thecloudedu.com', 'Male', '#d0fb54');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (622, 'Mar', 'Wilbud', 'mwilbudh9@thecloudedu.com', 'Male', '#1a7222');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (623, 'Xaviera', 'Norledge', 'xnorledgeha@thecloudedu.com', 'Female', '#c5f36c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (624, 'Josiah', 'Stoile', 'jstoilehb@thecloudedu.com', 'Male', '#47873b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (625, 'Georgiana', 'McOnie', 'gmconiehc@thecloudedu.com', 'Female', '#768fd9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (626, 'Chrystal', 'Grimolbie', 'cgrimolbiehd@thecloudedu.com', 'Female', '#666f48');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (627, 'Stern', 'Kennler', 'skennlerhe@thecloudedu.com', 'Male', '#9e3445');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (628, 'Candide', 'Moult', 'cmoulthf@thecloudedu.com', 'Female', '#0d344e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (629, 'Chance', 'Easeman', 'ceasemanhg@thecloudedu.com', 'Male', '#23f593');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (630, 'Alexandre', 'Lugden', 'alugdenhh@thecloudedu.com', 'Male', '#34a003');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (631, 'Zeke', 'Colbourne', 'zcolbournehi@thecloudedu.com', 'Male', '#2e12e6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (632, 'Gerda', 'Newlin', 'gnewlinhj@thecloudedu.com', 'Female', '#810508');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (633, 'Bobina', 'Janas', 'bjanashk@thecloudedu.com', 'Female', '#7e21fa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (634, 'Hyman', 'Iglesias', 'higlesiashl@thecloudedu.com', 'Male', '#2dad16');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (635, 'Perry', 'Dumbleton', 'pdumbletonhm@thecloudedu.com', 'Male', '#0d527c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (636, 'Lacie', 'Lathaye', 'llathayehn@thecloudedu.com', 'Female', '#d29acb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (637, 'Tedra', 'Slucock', 'tslucockho@thecloudedu.com', 'Female', '#83ecbb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (638, 'Orelie', 'Swires', 'oswireshp@thecloudedu.com', 'Female', '#97e596');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (639, 'Allx', 'Dagleas', 'adagleashq@thecloudedu.com', 'Female', '#7c7910');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (640, 'Early', 'Vinau', 'evinauhr@thecloudedu.com', 'Male', '#11b5f5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (641, 'Guy', 'De Simoni', 'gdesimonihs@thecloudedu.com', 'Male', '#8844a0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (642, 'Haskell', 'Mersey', 'hmerseyht@thecloudedu.com', 'Male', '#8cb15f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (643, 'Antonino', 'Andreacci', 'aandreaccihu@thecloudedu.com', 'Male', '#b567ef');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (644, 'Helli', 'Ingledew', 'hingledewhv@thecloudedu.com', 'Female', '#532512');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (645, 'Rickey', 'Giovannini', 'rgiovanninihw@thecloudedu.com', 'Male', '#be2c2f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (646, 'Leonelle', 'Jannequin', 'ljannequinhx@thecloudedu.com', 'Female', '#0ce923');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (647, 'Amil', 'Jobke', 'ajobkehy@thecloudedu.com', 'Female', '#782167');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (648, 'Rebbecca', 'Fearnehough', 'rfearnehoughhz@thecloudedu.com', 'Female', '#f4727c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (649, 'Elinor', 'Schott', 'eschotti0@thecloudedu.com', 'Female', '#9f33b5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (650, 'Karilynn', 'Cosbey', 'kcosbeyi1@thecloudedu.com', 'Female', '#d8fd7e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (651, 'Malvin', 'Hamelyn', 'mhamelyni2@thecloudedu.com', 'Male', '#9b643e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (652, 'Albina', 'Storek', 'astoreki3@thecloudedu.com', 'Female', '#88161f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (653, 'Lonnard', 'Ayerst', 'layersti4@thecloudedu.com', 'Male', '#9ca4a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (654, 'Konstantin', 'Stitfall', 'kstitfalli5@thecloudedu.com', 'Male', '#370d01');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (655, 'Adria', 'Goch', 'agochi6@thecloudedu.com', 'Female', '#1c55eb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (656, 'Brantley', 'Batty', 'bbattyi7@thecloudedu.com', 'Male', '#faf0ad');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (657, 'Raynell', 'Vinten', 'rvinteni8@thecloudedu.com', 'Female', '#367720');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (658, 'Samson', 'Espinoy', 'sespinoyi9@thecloudedu.com', 'Male', '#874d35');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (659, 'Leonelle', 'Camelli', 'lcamelliia@thecloudedu.com', 'Female', '#96f23b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (660, 'Rosalinde', 'Syers', 'rsyersib@thecloudedu.com', 'Female', '#c5daee');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (661, 'Vivianna', 'Alderton', 'valdertonic@thecloudedu.com', 'Female', '#cfdcb3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (662, 'Hyacinthie', 'Baudichon', 'hbaudichonid@thecloudedu.com', 'Female', '#e32ac1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (663, 'Harmon', 'Drysdell', 'hdrysdellie@thecloudedu.com', 'Male', '#964f99');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (664, 'Trip', 'Grigg', 'tgriggif@thecloudedu.com', 'Male', '#b63635');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (665, 'Sigmund', 'Tuft', 'stuftig@thecloudedu.com', 'Male', '#1554f2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (666, 'Karlotta', 'Hackinge', 'khackingeih@thecloudedu.com', 'Female', '#b52fd3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (667, 'Kayley', 'Mattys', 'kmattysii@thecloudedu.com', 'Female', '#c4db68');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (668, 'Adelle', 'Mannering', 'amanneringij@thecloudedu.com', 'Female', '#aad969');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (669, 'Mycah', 'McGaw', 'mmcgawik@thecloudedu.com', 'Male', '#ff9aa4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (670, 'Francyne', 'Adrienne', 'fadrienneil@thecloudedu.com', 'Female', '#0b82a5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (671, 'Nessa', 'Cruickshanks', 'ncruickshanksim@thecloudedu.com', 'Female', '#2eb648');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (672, 'Theda', 'Mandy', 'tmandyin@thecloudedu.com', 'Female', '#3182a1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (673, 'Roanne', 'Topper', 'rtopperio@thecloudedu.com', 'Female', '#ef8401');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (674, 'Hadleigh', 'Attoe', 'hattoeip@thecloudedu.com', 'Male', '#e805cf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (675, 'Sawyer', 'Rickford', 'srickfordiq@thecloudedu.com', 'Male', '#163d88');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (676, 'Adelina', 'Harlin', 'aharlinir@thecloudedu.com', 'Female', '#d70cb2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (677, 'Zara', 'Powelee', 'zpoweleeis@thecloudedu.com', 'Female', '#d44db0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (678, 'Marney', 'Del Checolo', 'mdelchecoloit@thecloudedu.com', 'Female', '#a5af6e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (679, 'Jarrad', 'Parmer', 'jparmeriu@thecloudedu.com', 'Male', '#00c584');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (680, 'Starlene', 'Cammomile', 'scammomileiv@thecloudedu.com', 'Female', '#ecc533');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (681, 'Esme', 'Trebbett', 'etrebbettiw@thecloudedu.com', 'Female', '#3c7656');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (682, 'Marcia', 'Tures', 'mturesix@thecloudedu.com', 'Female', '#934cd0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (683, 'Marve', 'Lawes', 'mlawesiy@thecloudedu.com', 'Male', '#1971a8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (684, 'Cornie', 'Belasco', 'cbelascoiz@thecloudedu.com', 'Female', '#7b3aa4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (685, 'Ferd', 'Gullam', 'fgullamj0@thecloudedu.com', 'Male', '#38d494');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (686, 'Rawley', 'Dadd', 'rdaddj1@thecloudedu.com', 'Male', '#8a24a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (687, 'Harlie', 'Whiteland', 'hwhitelandj2@thecloudedu.com', 'Female', '#68faf4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (688, 'Rabbi', 'Lemm', 'rlemmj3@thecloudedu.com', 'Male', '#dc0f78');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (689, 'Clair', 'Galier', 'cgalierj4@thecloudedu.com', 'Male', '#026f23');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (690, 'Ketti', 'Dunwoody', 'kdunwoodyj5@thecloudedu.com', 'Female', '#abde43');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (691, 'Fin', 'Rapley', 'frapleyj6@thecloudedu.com', 'Male', '#7efdb0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (692, 'Anne-corinne', 'Goymer', 'agoymerj7@thecloudedu.com', 'Female', '#937ac2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (693, 'Jasun', 'Kapiloff', 'jkapiloffj8@thecloudedu.com', 'Male', '#6a6685');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (694, 'Yuri', 'Greatex', 'ygreatexj9@thecloudedu.com', 'Male', '#f510f9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (695, 'Jethro', 'Jozsa', 'jjozsaja@thecloudedu.com', 'Male', '#58438c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (696, 'Celestyna', 'Moynham', 'cmoynhamjb@thecloudedu.com', 'Female', '#540c2d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (697, 'Lincoln', 'Fideler', 'lfidelerjc@thecloudedu.com', 'Male', '#690bf7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (698, 'Jaclin', 'Fedorski', 'jfedorskijd@thecloudedu.com', 'Female', '#e6281a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (699, 'Adeline', 'Janaszkiewicz', 'ajanaszkiewiczje@thecloudedu.com', 'Female', '#3456e8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (700, 'Rosalie', 'Letertre', 'rletertrejf@thecloudedu.com', 'Female', '#c79783');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (701, 'Julina', 'Velten', 'jveltenjg@thecloudedu.com', 'Female', '#92cf1b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (702, 'Jory', 'Blakesley', 'jblakesleyjh@thecloudedu.com', 'Male', '#857c5d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (703, 'Shea', 'Laise', 'slaiseji@thecloudedu.com', 'Female', '#ca33ef');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (704, 'Lodovico', 'Lander', 'llanderjj@thecloudedu.com', 'Male', '#158d07');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (705, 'Cletus', 'Larchiere', 'clarchierejk@thecloudedu.com', 'Male', '#6ac5ca');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (706, 'Hugues', 'St Quenin', 'hstqueninjl@thecloudedu.com', 'Male', '#198996');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (707, 'Tan', 'Haylett', 'thaylettjm@thecloudedu.com', 'Male', '#915690');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (708, 'Darryl', 'Camoys', 'dcamoysjn@thecloudedu.com', 'Female', '#69b218');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (709, 'Romy', 'Getley', 'rgetleyjo@thecloudedu.com', 'Female', '#5069b9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (710, 'Trevar', 'Gosart', 'tgosartjp@thecloudedu.com', 'Male', '#24f20b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (711, 'Susann', 'Claye', 'sclayejq@thecloudedu.com', 'Female', '#5fe33c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (712, 'Sinclare', 'Drezzer', 'sdrezzerjr@thecloudedu.com', 'Male', '#704475');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (713, 'Lu', 'Alwin', 'lalwinjs@thecloudedu.com', 'Female', '#7de318');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (714, 'Pryce', 'Oleshunin', 'poleshuninjt@thecloudedu.com', 'Male', '#b18f5f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (715, 'Avigdor', 'Stonhouse', 'astonhouseju@thecloudedu.com', 'Male', '#b42f27');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (716, 'Robin', 'Huggen', 'rhuggenjv@thecloudedu.com', 'Female', '#12714f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (717, 'Claude', 'Churchyard', 'cchurchyardjw@thecloudedu.com', 'Female', '#d99a6c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (718, 'Petey', 'Stygall', 'pstygalljx@thecloudedu.com', 'Male', '#9c67ae');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (719, 'Fletch', 'Broggini', 'fbrogginijy@thecloudedu.com', 'Male', '#b8d425');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (720, 'Nathanael', 'Massenhove', 'nmassenhovejz@thecloudedu.com', 'Male', '#18dcb5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (721, 'Gardy', 'Searston', 'gsearstonk0@thecloudedu.com', 'Male', '#40901f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (722, 'Corena', 'Farndale', 'cfarndalek1@thecloudedu.com', 'Female', '#9ea9db');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (723, 'Mellisent', 'Barnet', 'mbarnetk2@thecloudedu.com', 'Female', '#7ea300');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (724, 'Geno', 'McGlue', 'gmcgluek3@thecloudedu.com', 'Male', '#21480d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (725, 'Shirlee', 'Murtell', 'smurtellk4@thecloudedu.com', 'Female', '#90d291');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (726, 'Ingelbert', 'Comar', 'icomark5@thecloudedu.com', 'Male', '#af77d5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (727, 'Oliver', 'Allebone', 'oallebonek6@thecloudedu.com', 'Male', '#0ba8d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (728, 'Derrik', 'Pavitt', 'dpavittk7@thecloudedu.com', 'Male', '#e22a15');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (729, 'Henrie', 'Altofts', 'haltoftsk8@thecloudedu.com', 'Female', '#4fc128');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (730, 'Kelcy', 'Garmans', 'kgarmansk9@thecloudedu.com', 'Female', '#1d27d2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (731, 'Bud', 'Findley', 'bfindleyka@thecloudedu.com', 'Male', '#e69380');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (732, 'Kenn', 'Percifer', 'kperciferkb@thecloudedu.com', 'Male', '#0e6b19');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (733, 'Josh', 'Pennycord', 'jpennycordkc@thecloudedu.com', 'Male', '#315305');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (734, 'Veronique', 'Brixey', 'vbrixeykd@thecloudedu.com', 'Female', '#f07d54');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (735, 'Blane', 'Rotge', 'brotgeke@thecloudedu.com', 'Male', '#8a6872');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (736, 'Roscoe', 'Backler', 'rbacklerkf@thecloudedu.com', 'Male', '#43dfba');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (737, 'Phil', 'Stolting', 'pstoltingkg@thecloudedu.com', 'Male', '#860906');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (738, 'Charlena', 'Rief', 'criefkh@thecloudedu.com', 'Female', '#27a748');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (739, 'Quint', 'Flecknell', 'qflecknellki@thecloudedu.com', 'Male', '#fc9d69');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (740, 'Casi', 'Bartrop', 'cbartropkj@thecloudedu.com', 'Female', '#daea01');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (741, 'Agneta', 'Braxay', 'abraxaykk@thecloudedu.com', 'Female', '#3a9428');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (742, 'Berta', 'Lyburn', 'blyburnkl@thecloudedu.com', 'Female', '#f9314a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (743, 'Haskel', 'Pinnocke', 'hpinnockekm@thecloudedu.com', 'Male', '#f3b051');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (744, 'Ibbie', 'Windaybank', 'iwindaybankkn@thecloudedu.com', 'Female', '#c0eaaa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (745, 'Hillie', 'Carette', 'hcaretteko@thecloudedu.com', 'Male', '#d31b81');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (746, 'Caye', 'Scrange', 'cscrangekp@thecloudedu.com', 'Female', '#5341ff');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (747, 'Timotheus', 'Absolon', 'tabsolonkq@thecloudedu.com', 'Male', '#a9d140');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (748, 'Esdras', 'Boustred', 'eboustredkr@thecloudedu.com', 'Male', '#4c946a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (749, 'Zeke', 'Penwell', 'zpenwellks@thecloudedu.com', 'Male', '#7314eb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (750, 'Erhard', 'Oakenfull', 'eoakenfullkt@thecloudedu.com', 'Male', '#dd26af');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (751, 'Tabor', 'Arderne', 'tarderneku@thecloudedu.com', 'Male', '#1389a8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (752, 'Dolph', 'Plues', 'dplueskv@thecloudedu.com', 'Male', '#9accc7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (753, 'Conn', 'Gley', 'cgleykw@thecloudedu.com', 'Male', '#c2583f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (754, 'Johny', 'Tweddle', 'jtweddlekx@thecloudedu.com', 'Male', '#a18f68');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (755, 'Hester', 'Kaygill', 'hkaygillky@thecloudedu.com', 'Female', '#236bd9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (756, 'Boris', 'Dearness', 'bdearnesskz@thecloudedu.com', 'Male', '#1b724f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (757, 'Linn', 'Georg', 'lgeorgl0@thecloudedu.com', 'Male', '#610ea4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (758, 'Lelia', 'Lowin', 'llowinl1@thecloudedu.com', 'Female', '#8b2624');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (759, 'Kenton', 'Vuitte', 'kvuittel2@thecloudedu.com', 'Male', '#56096d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (760, 'Nickey', 'Cleeves', 'ncleevesl3@thecloudedu.com', 'Male', '#1f0325');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (761, 'Lawry', 'Frascone', 'lfrasconel4@thecloudedu.com', 'Male', '#397e70');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (762, 'Alejandro', 'Reymers', 'areymersl5@thecloudedu.com', 'Male', '#e5eaab');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (763, 'Michele', 'Gow', 'mgowl6@thecloudedu.com', 'Male', '#e05be8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (764, 'Alexandros', 'Gerrets', 'agerretsl7@thecloudedu.com', 'Male', '#78187f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (765, 'Shurlock', 'Montford', 'smontfordl8@thecloudedu.com', 'Male', '#b21e29');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (766, 'Tobe', 'Murra', 'tmurral9@thecloudedu.com', 'Male', '#b0384a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (767, 'Colman', 'Oller', 'collerla@thecloudedu.com', 'Male', '#c728cc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (768, 'Sayers', 'Taree', 'stareelb@thecloudedu.com', 'Male', '#38ab26');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (769, 'Stevana', 'Winfield', 'swinfieldlc@thecloudedu.com', 'Female', '#f3ffa8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (770, 'Lloyd', 'Cooke', 'lcookeld@thecloudedu.com', 'Male', '#ff85a1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (771, 'Ashli', 'Duprey', 'adupreyle@thecloudedu.com', 'Female', '#fde540');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (772, 'Augustina', 'Hazlegrove', 'ahazlegrovelf@thecloudedu.com', 'Female', '#dd7175');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (773, 'Yuri', 'Dunnett', 'ydunnettlg@thecloudedu.com', 'Male', '#26a6a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (774, 'Raquel', 'Goathrop', 'rgoathroplh@thecloudedu.com', 'Female', '#4ecd41');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (775, 'Darby', 'Rowlings', 'drowlingsli@thecloudedu.com', 'Female', '#11419a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (776, 'Jeremie', 'Degoey', 'jdegoeylj@thecloudedu.com', 'Male', '#194494');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (777, 'Bobette', 'Josephi', 'bjosephilk@thecloudedu.com', 'Female', '#257e14');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (778, 'Tedie', 'Sciusscietto', 'tsciussciettoll@thecloudedu.com', 'Male', '#9b60af');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (779, 'Cherianne', 'Middas', 'cmiddaslm@thecloudedu.com', 'Female', '#55ea22');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (780, 'Georas', 'Gawthrope', 'ggawthropeln@thecloudedu.com', 'Male', '#bec2c4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (781, 'Agathe', 'Neillans', 'aneillanslo@thecloudedu.com', 'Female', '#a8be99');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (782, 'Lauren', 'Abrey', 'labreylp@thecloudedu.com', 'Male', '#4d71a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (783, 'Cristal', 'Delacroix', 'cdelacroixlq@thecloudedu.com', 'Female', '#e78bd8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (784, 'Odell', 'Gealy', 'ogealylr@thecloudedu.com', 'Male', '#eab9d6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (785, 'Anders', 'Schwier', 'aschwierls@thecloudedu.com', 'Male', '#5ae654');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (786, 'Cybil', 'Stubs', 'cstubslt@thecloudedu.com', 'Female', '#c2f765');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (787, 'Pedro', 'Dumbar', 'pdumbarlu@thecloudedu.com', 'Male', '#182d9b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (788, 'Madalena', 'Dewhirst', 'mdewhirstlv@thecloudedu.com', 'Female', '#24a9a2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (789, 'Scotty', 'Keavy', 'skeavylw@thecloudedu.com', 'Male', '#79498f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (790, 'Alvie', 'Sarchwell', 'asarchwelllx@thecloudedu.com', 'Male', '#92b4a7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (791, 'Merill', 'Macari', 'mmacarily@thecloudedu.com', 'Male', '#6bf984');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (792, 'Terese', 'Mewett', 'tmewettlz@thecloudedu.com', 'Female', '#b43303');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (793, 'Rora', 'Stephens', 'rstephensm0@thecloudedu.com', 'Female', '#c058d7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (794, 'Keefe', 'Stile', 'kstilem1@thecloudedu.com', 'Male', '#fbd4da');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (795, 'Krysta', 'Dayne', 'kdaynem2@thecloudedu.com', 'Female', '#d35c12');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (796, 'Rianon', 'Bradburne', 'rbradburnem3@thecloudedu.com', 'Female', '#7cc57b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (797, 'Cyrill', 'Malyon', 'cmalyonm4@thecloudedu.com', 'Male', '#e94978');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (798, 'Eldridge', 'Pryell', 'epryellm5@thecloudedu.com', 'Male', '#8943e6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (799, 'Kalinda', 'Royden', 'kroydenm6@thecloudedu.com', 'Female', '#5a5d96');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (800, 'Cindelyn', 'Cano', 'ccanom7@thecloudedu.com', 'Female', '#adf44a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (801, 'Emiline', 'Seadon', 'eseadonm8@thecloudedu.com', 'Female', '#c3ee14');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (802, 'Gerti', 'Goodrick', 'ggoodrickm9@thecloudedu.com', 'Female', '#17b6eb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (803, 'Hanni', 'Sneller', 'hsnellerma@thecloudedu.com', 'Female', '#6f979d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (804, 'Randi', 'Mahony', 'rmahonymb@thecloudedu.com', 'Female', '#f56326');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (805, 'Jacinta', 'Andrejs', 'jandrejsmc@thecloudedu.com', 'Female', '#b800ab');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (806, 'Gracia', 'O''Dougherty', 'godoughertymd@thecloudedu.com', 'Female', '#f76fdf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (807, 'Mitch', 'Rainer', 'mrainerme@thecloudedu.com', 'Male', '#27ad91');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (808, 'Ignacius', 'Conisbee', 'iconisbeemf@thecloudedu.com', 'Male', '#fec833');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (809, 'Melissa', 'Eynald', 'meynaldmg@thecloudedu.com', 'Female', '#561432');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (810, 'Sigfrid', 'McBoyle', 'smcboylemh@thecloudedu.com', 'Male', '#fb8e27');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (811, 'Gus', 'Aulton', 'gaultonmi@thecloudedu.com', 'Female', '#55d3ed');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (812, 'Falito', 'Wemm', 'fwemmmj@thecloudedu.com', 'Male', '#6b5c4d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (813, 'Adah', 'Reith', 'areithmk@thecloudedu.com', 'Female', '#c621dc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (814, 'Jaymee', 'Staniford', 'jstanifordml@thecloudedu.com', 'Female', '#f6f8c6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (815, 'Bernette', 'Kahen', 'bkahenmm@thecloudedu.com', 'Female', '#d92a42');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (816, 'Terrence', 'Flight', 'tflightmn@thecloudedu.com', 'Male', '#260749');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (817, 'Kyle', 'Petto', 'kpettomo@thecloudedu.com', 'Male', '#ad6f55');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (818, 'Gregorio', 'Shaplin', 'gshaplinmp@thecloudedu.com', 'Male', '#0237d7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (819, 'Chicky', 'Ramble', 'cramblemq@thecloudedu.com', 'Male', '#154635');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (820, 'Hervey', 'Alexandrescu', 'halexandrescumr@thecloudedu.com', 'Male', '#e5c4dd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (821, 'Denny', 'Poate', 'dpoatems@thecloudedu.com', 'Male', '#b42662');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (822, 'Teresita', 'Easeman', 'teasemanmt@thecloudedu.com', 'Female', '#063459');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (823, 'Bronson', 'McCerery', 'bmccererymu@thecloudedu.com', 'Male', '#830049');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (824, 'Les', 'Eadie', 'leadiemv@thecloudedu.com', 'Male', '#52ef2b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (825, 'Madison', 'Pedley', 'mpedleymw@thecloudedu.com', 'Male', '#282369');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (826, 'Tore', 'Justun', 'tjustunmx@thecloudedu.com', 'Male', '#e49f92');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (827, 'Dal', 'Rennix', 'drennixmy@thecloudedu.com', 'Male', '#c3e0d8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (828, 'Orelie', 'Sharpin', 'osharpinmz@thecloudedu.com', 'Female', '#3578bd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (829, 'Jeniffer', 'Longley', 'jlongleyn0@thecloudedu.com', 'Female', '#46d3b2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (830, 'Freddi', 'Ellit', 'fellitn1@thecloudedu.com', 'Female', '#175009');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (831, 'Aime', 'Goodisson', 'agoodissonn2@thecloudedu.com', 'Female', '#64a887');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (832, 'Correy', 'Novis', 'cnovisn3@thecloudedu.com', 'Male', '#108bb2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (833, 'Kimble', 'MacVay', 'kmacvayn4@thecloudedu.com', 'Male', '#de42fd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (834, 'Jean', 'Morville', 'jmorvillen5@thecloudedu.com', 'Male', '#66d999');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (835, 'Bordie', 'McAdam', 'bmcadamn6@thecloudedu.com', 'Male', '#f00b52');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (836, 'Murvyn', 'Jonin', 'mjoninn7@thecloudedu.com', 'Male', '#d061f5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (837, 'Freddie', 'Beetlestone', 'fbeetlestonen8@thecloudedu.com', 'Male', '#b394ca');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (838, 'Dynah', 'Churchard', 'dchurchardn9@thecloudedu.com', 'Female', '#087bbd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (839, 'Sandy', 'Bouda', 'sboudana@thecloudedu.com', 'Male', '#9b5b1c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (840, 'Elonore', 'Goulston', 'egoulstonnb@thecloudedu.com', 'Female', '#66b1ff');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (841, 'Thornie', 'Forman', 'tformannc@thecloudedu.com', 'Male', '#ce40b4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (842, 'Asa', 'Boulder', 'abouldernd@thecloudedu.com', 'Male', '#fbe129');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (843, 'Ryun', 'Tomet', 'rtometne@thecloudedu.com', 'Male', '#e49ffc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (844, 'Natka', 'Blundel', 'nblundelnf@thecloudedu.com', 'Female', '#ff8aa6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (845, 'Claudie', 'MacNucator', 'cmacnucatorng@thecloudedu.com', 'Female', '#d6b208');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (846, 'Wang', 'Schuelcke', 'wschuelckenh@thecloudedu.com', 'Male', '#612c86');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (847, 'Reyna', 'Klampt', 'rklamptni@thecloudedu.com', 'Female', '#5197c7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (848, 'Emanuele', 'Littrik', 'elittriknj@thecloudedu.com', 'Male', '#02ec55');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (849, 'Morris', 'Sirman', 'msirmannk@thecloudedu.com', 'Male', '#0e8c70');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (850, 'Ryan', 'Loughrey', 'rloughreynl@thecloudedu.com', 'Male', '#9ec991');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (851, 'Mathilde', 'Yakunchikov', 'myakunchikovnm@thecloudedu.com', 'Female', '#ae208b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (852, 'Imelda', 'Gillopp', 'igilloppnn@thecloudedu.com', 'Female', '#35b63c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (853, 'Vicky', 'Larcier', 'vlarcierno@thecloudedu.com', 'Female', '#b19d78');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (854, 'Gardie', 'Chater', 'gchaternp@thecloudedu.com', 'Male', '#f3b405');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (855, 'Ingrim', 'Dowle', 'idowlenq@thecloudedu.com', 'Male', '#95ac08');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (856, 'Ethel', 'Stave', 'estavenr@thecloudedu.com', 'Female', '#39affc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (857, 'Mabel', 'Gresswood', 'mgresswoodns@thecloudedu.com', 'Female', '#b6910a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (858, 'Lethia', 'Sargent', 'lsargentnt@thecloudedu.com', 'Female', '#301df7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (859, 'Annora', 'Curzey', 'acurzeynu@thecloudedu.com', 'Female', '#6a47fa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (860, 'Leanna', 'Swinley', 'lswinleynv@thecloudedu.com', 'Female', '#15837e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (861, 'Fannie', 'Brastead', 'fbrasteadnw@thecloudedu.com', 'Female', '#5c2df9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (862, 'Gauthier', 'Maingot', 'gmaingotnx@thecloudedu.com', 'Male', '#bb51d2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (863, 'Edith', 'Vasilic', 'evasilicny@thecloudedu.com', 'Female', '#6b13b0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (864, 'Dorine', 'Grizard', 'dgrizardnz@thecloudedu.com', 'Female', '#a60062');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (865, 'Esma', 'Duffield', 'eduffieldo0@thecloudedu.com', 'Female', '#6143db');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (866, 'Trenna', 'Rippin', 'trippino1@thecloudedu.com', 'Female', '#a1172d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (867, 'Valaree', 'Shilburne', 'vshilburneo2@thecloudedu.com', 'Female', '#0ce0bd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (868, 'Bellina', 'Kremer', 'bkremero3@thecloudedu.com', 'Female', '#274126');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (869, 'Laurie', 'Mistry', 'lmistryo4@thecloudedu.com', 'Male', '#57c404');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (870, 'Mata', 'Berndt', 'mberndto5@thecloudedu.com', 'Male', '#5f3124');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (871, 'Dorry', 'Astbury', 'dastburyo6@thecloudedu.com', 'Female', '#312805');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (872, 'Rhodie', 'Saunderson', 'rsaundersono7@thecloudedu.com', 'Female', '#720b4f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (873, 'Skippie', 'Adamski', 'sadamskio8@thecloudedu.com', 'Male', '#8ddde5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (874, 'Audre', 'Codi', 'acodio9@thecloudedu.com', 'Female', '#3a77e3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (875, 'Magnum', 'Slatford', 'mslatfordoa@thecloudedu.com', 'Male', '#753920');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (876, 'Nikoletta', 'Paulich', 'npaulichob@thecloudedu.com', 'Female', '#f64f92');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (877, 'Jayne', 'Malins', 'jmalinsoc@thecloudedu.com', 'Female', '#05a4ed');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (878, 'Catrina', 'Poli', 'cpoliod@thecloudedu.com', 'Female', '#50d96e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (879, 'Glyn', 'Andri', 'gandrioe@thecloudedu.com', 'Female', '#a82d6d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (880, 'Rabbi', 'McElmurray', 'rmcelmurrayof@thecloudedu.com', 'Male', '#487500');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (881, 'Barty', 'Parrington', 'bparringtonog@thecloudedu.com', 'Male', '#a38a5c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (882, 'Terencio', 'Kubis', 'tkubisoh@thecloudedu.com', 'Male', '#b851fb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (883, 'Elka', 'Rittmeier', 'erittmeieroi@thecloudedu.com', 'Female', '#f3c5a0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (884, 'Gavin', 'Broderick', 'gbroderickoj@thecloudedu.com', 'Male', '#98e88c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (885, 'Cynthia', 'Lynnitt', 'clynnittok@thecloudedu.com', 'Female', '#6c2999');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (886, 'Modesty', 'Donohue', 'mdonohueol@thecloudedu.com', 'Female', '#1b55f0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (887, 'Elane', 'Jewkes', 'ejewkesom@thecloudedu.com', 'Female', '#73d798');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (888, 'Jaye', 'Plumley', 'jplumleyon@thecloudedu.com', 'Male', '#78e83e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (889, 'Eustacia', 'Meanwell', 'emeanwelloo@thecloudedu.com', 'Female', '#eaecdd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (890, 'Jarrid', 'Hendren', 'jhendrenop@thecloudedu.com', 'Male', '#3cfc91');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (891, 'Mahala', 'Nickless', 'mnicklessoq@thecloudedu.com', 'Female', '#808e5d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (892, 'Laurens', 'Longson', 'llongsonor@thecloudedu.com', 'Male', '#e54a96');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (893, 'Lorinda', 'Locock', 'llocockos@thecloudedu.com', 'Female', '#56dc7c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (894, 'Roslyn', 'Anfonsi', 'ranfonsiot@thecloudedu.com', 'Female', '#33756e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (895, 'Torey', 'Samweyes', 'tsamweyesou@thecloudedu.com', 'Male', '#ee4ea0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (896, 'Bobby', 'Garr', 'bgarrov@thecloudedu.com', 'Male', '#32e9b8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (897, 'Denver', 'Luckey', 'dluckeyow@thecloudedu.com', 'Male', '#1f36ea');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (898, 'Selena', 'Rame', 'srameox@thecloudedu.com', 'Female', '#103c59');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (899, 'Chaddie', 'Imeson', 'cimesonoy@thecloudedu.com', 'Male', '#c2f284');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (900, 'Paulette', 'Guy', 'pguyoz@thecloudedu.com', 'Female', '#cac51d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (901, 'Raimundo', 'Shark', 'rsharkp0@thecloudedu.com', 'Male', '#22783a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (902, 'Kimball', 'Parlet', 'kparletp1@thecloudedu.com', 'Male', '#763097');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (903, 'Hazlett', 'Elsop', 'helsopp2@thecloudedu.com', 'Male', '#042e9e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (904, 'Corny', 'Stegell', 'cstegellp3@thecloudedu.com', 'Male', '#d27d0f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (905, 'Jaquenetta', 'Wipper', 'jwipperp4@thecloudedu.com', 'Female', '#3c80bd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (906, 'Geri', 'Consterdine', 'gconsterdinep5@thecloudedu.com', 'Male', '#cbe64f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (907, 'Pete', 'Royston', 'proystonp6@thecloudedu.com', 'Male', '#efd0f1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (908, 'Tandy', 'Jopke', 'tjopkep7@thecloudedu.com', 'Female', '#9dc742');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (909, 'Wallis', 'Thain', 'wthainp8@thecloudedu.com', 'Female', '#e4fbb7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (910, 'Rebecka', 'Smogur', 'rsmogurp9@thecloudedu.com', 'Female', '#14685d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (911, 'Lorettalorna', 'Rayer', 'lrayerpa@thecloudedu.com', 'Female', '#7f00c7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (912, 'Tait', 'Vickery', 'tvickerypb@thecloudedu.com', 'Male', '#22dcda');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (913, 'William', 'Jossel', 'wjosselpc@thecloudedu.com', 'Male', '#496470');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (914, 'Whit', 'O''Mannion', 'womannionpd@thecloudedu.com', 'Male', '#50f830');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (915, 'Livvie', 'Creaser', 'lcreaserpe@thecloudedu.com', 'Female', '#b09dc8');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (916, 'Angie', 'Carbery', 'acarberypf@thecloudedu.com', 'Female', '#dfe96e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (917, 'Cris', 'Avo', 'cavopg@thecloudedu.com', 'Male', '#49c37e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (918, 'Dotti', 'Erwin', 'derwinph@thecloudedu.com', 'Female', '#1bc4f4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (919, 'Betsey', 'Fierro', 'bfierropi@thecloudedu.com', 'Female', '#f39042');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (920, 'Care', 'Hartridge', 'chartridgepj@thecloudedu.com', 'Male', '#68346b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (921, 'Dara', 'Gasgarth', 'dgasgarthpk@thecloudedu.com', 'Female', '#292abe');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (922, 'Terry', 'Labusch', 'tlabuschpl@thecloudedu.com', 'Female', '#b27b3e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (923, 'Maryl', 'Labon', 'mlabonpm@thecloudedu.com', 'Female', '#02dbdb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (924, 'Adelbert', 'Scoines', 'ascoinespn@thecloudedu.com', 'Male', '#03edab');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (925, 'Dyan', 'Haker', 'dhakerpo@thecloudedu.com', 'Female', '#fc952f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (926, 'Bertram', 'Waskett', 'bwaskettpp@thecloudedu.com', 'Male', '#0f139f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (927, 'Davey', 'Readwin', 'dreadwinpq@thecloudedu.com', 'Male', '#a08527');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (928, 'Jamie', 'Varker', 'jvarkerpr@thecloudedu.com', 'Female', '#ad2003');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (929, 'Millisent', 'Lille', 'mlilleps@thecloudedu.com', 'Female', '#129790');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (930, 'Jonah', 'Seabridge', 'jseabridgept@thecloudedu.com', 'Male', '#ee199b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (931, 'Flossi', 'Ecclestone', 'fecclestonepu@thecloudedu.com', 'Female', '#84dbf2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (932, 'Elysia', 'Scriven', 'escrivenpv@thecloudedu.com', 'Female', '#5d4528');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (933, 'Dalston', 'Keuneke', 'dkeunekepw@thecloudedu.com', 'Male', '#dac9b1');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (934, 'Joseph', 'Riall', 'jriallpx@thecloudedu.com', 'Male', '#27a216');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (935, 'Marylee', 'Rubury', 'mruburypy@thecloudedu.com', 'Female', '#d493a5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (936, 'Ailee', 'Ranns', 'arannspz@thecloudedu.com', 'Female', '#319ba7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (937, 'Averyl', 'Newson', 'anewsonq0@thecloudedu.com', 'Female', '#4c9b23');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (938, 'Vick', 'Fitchew', 'vfitchewq1@thecloudedu.com', 'Male', '#2f333a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (939, 'Jade', 'Forsbey', 'jforsbeyq2@thecloudedu.com', 'Female', '#2271a3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (940, 'Raymond', 'Clemmens', 'rclemmensq3@thecloudedu.com', 'Male', '#1d25aa');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (941, 'Dorie', 'Ivanyukov', 'divanyukovq4@thecloudedu.com', 'Male', '#724850');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (942, 'Garvey', 'De Caroli', 'gdecaroliq5@thecloudedu.com', 'Male', '#dd3a92');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (943, 'Sol', 'Halsted', 'shalstedq6@thecloudedu.com', 'Male', '#825165');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (944, 'Rici', 'Fallowes', 'rfallowesq7@thecloudedu.com', 'Female', '#d97251');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (945, 'Duky', 'Okill', 'dokillq8@thecloudedu.com', 'Male', '#12455b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (946, 'Ulrick', 'Valentine', 'uvalentineq9@thecloudedu.com', 'Male', '#a6847b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (947, 'Ty', 'Honig', 'thonigqa@thecloudedu.com', 'Male', '#0cfd03');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (948, 'Mordy', 'Younge', 'myoungeqb@thecloudedu.com', 'Male', '#c3945c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (949, 'Darrick', 'Gavahan', 'dgavahanqc@thecloudedu.com', 'Male', '#fc2e72');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (950, 'Nariko', 'McDiarmid', 'nmcdiarmidqd@thecloudedu.com', 'Female', '#9297cb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (951, 'Flinn', 'Sackey', 'fsackeyqe@thecloudedu.com', 'Male', '#5a32ec');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (952, 'Carole', 'Nichol', 'cnicholqf@thecloudedu.com', 'Female', '#c68308');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (953, 'Tobe', 'Winfred', 'twinfredqg@thecloudedu.com', 'Male', '#0929bb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (954, 'Otto', 'Bauckham', 'obauckhamqh@thecloudedu.com', 'Male', '#f3d8cb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (955, 'Micheal', 'Bolton', 'mboltonqi@thecloudedu.com', 'Male', '#f7e9c0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (956, 'Michaeline', 'Ligertwood', 'mligertwoodqj@thecloudedu.com', 'Female', '#a2bdf2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (957, 'Krystle', 'Gaylard', 'kgaylardqk@thecloudedu.com', 'Female', '#32d6c7');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (958, 'Georas', 'Whetnall', 'gwhetnallql@thecloudedu.com', 'Male', '#4975e3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (959, 'Lonnard', 'Careless', 'lcarelessqm@thecloudedu.com', 'Male', '#5f226e');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (960, 'Valentin', 'Charrisson', 'vcharrissonqn@thecloudedu.com', 'Male', '#494110');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (961, 'Gracie', 'Eaves', 'geavesqo@thecloudedu.com', 'Female', '#00ebaf');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (962, 'Hastie', 'Dalgarnocht', 'hdalgarnochtqp@thecloudedu.com', 'Male', '#6569d3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (963, 'Staford', 'Romanetti', 'sromanettiqq@thecloudedu.com', 'Male', '#ffea11');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (964, 'Thaxter', 'Symper', 'tsymperqr@thecloudedu.com', 'Male', '#421475');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (965, 'Reube', 'Bartkiewicz', 'rbartkiewiczqs@thecloudedu.com', 'Male', '#cc78c0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (966, 'Alexis', 'Baudy', 'abaudyqt@thecloudedu.com', 'Male', '#a2edeb');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (967, 'Sergeant', 'Punter', 'spunterqu@thecloudedu.com', 'Male', '#02e9b5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (968, 'Koren', 'Beidebeke', 'kbeidebekeqv@thecloudedu.com', 'Female', '#df1ca3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (969, 'Rourke', 'Yansons', 'ryansonsqw@thecloudedu.com', 'Male', '#6ea1b6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (970, 'Percy', 'Pughe', 'ppugheqx@thecloudedu.com', 'Male', '#dd4f91');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (971, 'Jillian', 'Dickey', 'jdickeyqy@thecloudedu.com', 'Female', '#dd9be9');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (972, 'Drucill', 'Dogerty', 'ddogertyqz@thecloudedu.com', 'Female', '#b1becd');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (973, 'Burnaby', 'Irvin', 'birvinr0@thecloudedu.com', 'Male', '#210f63');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (974, 'Marji', 'Gearing', 'mgearingr1@thecloudedu.com', 'Female', '#2690dc');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (975, 'Tandi', 'Kohneke', 'tkohneker2@thecloudedu.com', 'Female', '#b778b4');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (976, 'Irita', 'Willisch', 'iwillischr3@thecloudedu.com', 'Female', '#b419c6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (977, 'Clywd', 'Peebles', 'cpeeblesr4@thecloudedu.com', 'Male', '#33048c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (978, 'Raphael', 'Gallyon', 'rgallyonr5@thecloudedu.com', 'Male', '#091048');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (979, 'Karina', 'Buckam', 'kbuckamr6@thecloudedu.com', 'Female', '#b0319f');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (980, 'Roldan', 'Smorthit', 'rsmorthitr7@thecloudedu.com', 'Male', '#7717f0');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (981, 'Rockwell', 'Playfair', 'rplayfairr8@thecloudedu.com', 'Male', '#22dd26');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (982, 'Jessa', 'Beckson', 'jbecksonr9@thecloudedu.com', 'Female', '#06329a');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (983, 'Mariann', 'Lawful', 'mlawfulra@thecloudedu.com', 'Female', '#db9635');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (984, 'Forester', 'Helkin', 'fhelkinrb@thecloudedu.com', 'Male', '#8323d5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (985, 'Hynda', 'Hall-Gough', 'hhallgoughrc@thecloudedu.com', 'Female', '#c5727b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (986, 'Carena', 'Doleman', 'cdolemanrd@thecloudedu.com', 'Female', '#ca1629');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (987, 'Sheila-kathryn', 'Shadfourth', 'sshadfourthre@thecloudedu.com', 'Female', '#ea90e5');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (988, 'Jdavie', 'Rosel', 'jroselrf@thecloudedu.com', 'Male', '#cabc92');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (989, 'Sheilakathryn', 'Ogus', 'sogusrg@thecloudedu.com', 'Female', '#0f513d');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (990, 'Yolane', 'Jeanes', 'yjeanesrh@thecloudedu.com', 'Female', '#239ef6');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (991, 'Ewan', 'Marcus', 'emarcusri@thecloudedu.com', 'Male', '#1b911b');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (992, 'Marsha', 'Tomasi', 'mtomasirj@thecloudedu.com', 'Female', '#786d5c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (993, 'Vivia', 'Screwton', 'vscrewtonrk@thecloudedu.com', 'Female', '#465af2');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (994, 'Ragnar', 'Brewitt', 'rbrewittrl@thecloudedu.com', 'Male', '#1478c3');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (995, 'Arri', 'Kempton', 'akemptonrm@thecloudedu.com', 'Male', '#bf3e44');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (996, 'Rich', 'Fearnehough', 'rfearnehoughrn@thecloudedu.com', 'Male', '#71a10c');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (997, 'Rosamond', 'Vergine', 'rverginero@thecloudedu.com', 'Female', '#fdc545');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (998, 'Malinde', 'Powell', 'mpowellrp@thecloudedu.com', 'Female', '#766951');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (999, 'Teirtza', 'Loadman', 'tloadmanrq@thecloudedu.com', 'Female', '#096c18');
insert into employees (id, first_name, last_name, email, gender, favorite_color) values (1000, 'Killie', 'Peperell', 'kpeperellrr@thecloudedu.com', 'Male', '#c523eb');
EOF

echo
echo
echo
echo "Now you can query your database this way

psql postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:$MYPORT/$POSTGRES_INSTANCE -c \"SELECT count(id) FROM employees;\"


psql postgres://asokone:asokone@localhost:8282/sample -c \"SELECT * FROM employees WHERE first_name='Mamadou';\"
"
echo
echo
