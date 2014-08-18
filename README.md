--  Script based on https://github.com/brantje/xbian-touch -- 


-- works for xbian, trying to make it work on raspbmc with Sainsmart 7" touchscreen @ 720 x 576 --

---------------------------------------------------------------------------------------------------
Install notes:

- get you'r fresh copy from http://www.raspbmc.com/download/
- fire it up and let the raspbmc do its upgrade work (takes a while)
- do apt-get update and apt-get upgrade (just to be sure everything is up do date)
- when everything is done and xbmc is up, start with calibrating the touchscreen


Open a ssh connection to raspbmc
Then type:

wget --no-check-certificate https://github.com/Schlump/raspbmc-touch/raw/master/install.sh

after installation is done type:

sudo sh install.sh 


---------------------------------------------------------------------------------------------------

Thanks to branjte (https://github.com/brantje/xbian-touch) and  markamc (http://markamc.traki-iski.co.uk/)
as 99% of the work in this script is from them, i just changed a few lines for raspbmc compability.
