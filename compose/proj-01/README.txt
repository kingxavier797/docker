# ----------------
NOTE: Few important files we need to explain the role.

[0-9].html, are the files, of your sponsors, each time, someone click on the banner, on top of the page, it takes him to, the corresponding sponsor’s website
customer[0-9].html are, your customers, the one, you are building, a web site for. Each time, you create a container, using that image, login into the container, and copy, the customerX.html into customer.html
preface.cgi is, the CGI program, that we are to hit, as http://<IP OF DOCKER SERVER>:PORT/cgi-bin/preface.cgi
Javapubscript.txt is handling the advertisement banner on top the web page.
Dockerfile from which we are to build an image from, when everything is fine, then push the image to docker hub, clean up all images, from our docker server,  then pull it back, to use it, to create our customers web sites.
PUBIMG directory, contains all images, to be used, in the advertisement banner
counter.txt is, to keep track of, the number of visitors, hitting the web site.


# ----------------


Once the container is created and running, with the command let say

$ docker run -it -p 5000:80 --name adv_httpserver -d adv_httpserver

on the docker server where the daemon is running, then on that server
if the IP of it s let say 192.168.0.164, then you should be on the sever
pull out browser and access the container application adv_httpserver
like this.

http://192.168.0.164:5000/cgi-bin/preface.cgi  

or you can test it at the docker server unix prompt with curl command

$ curl http://192.168.0.164:5000/cgi-bin/preface.cgi

# ----------------

Please note that the advertisement banner images can be changed.
It's matter of replacing the images in PUBIMG directory with different
images giving them the same names frontpub-[0-9].gif or frontpub-[0-9][0-9].gif
up to 19.
Please look at the PUBIMG directory for reference on how to name your images.
The size in LARGE X WIDTH should the same as the ones you will see when the
page comes up. If you put in larger images when your page is likely to look
ugly.

But if you want to go over 19 images you can change the value of
	var numberofpubimages = 19;
to your desired number of images in the file .javapubscript.txt And each image 
should correspond to its [0-9].html or [0-9][0-9].html so that when someone 
click on the banner it takes him the website of the advertiser paying money
to put the link in your page..
# ----------------
