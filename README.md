# AdoPiSoft
AdoPiSoft Automatic Install Script<br>You need to have Ubuntu Server installled before using this script<br>Tested using Ubuntu 22.04<br>

Copy and paste this command in the terminal<br><br>

wget https://raw.githubusercontent.com/kcaBmask/adopisoft/main/ado.sh && sudo chmod a+x ado.sh && bash ado.sh<br>


##############################

Postgres Database Information<br>
Database Type: postgres<br>
Host/IP: localhost<br>
Port Number:<br>
Database Name: adopisoft<br>
Username: adopisoft<br>
Password: adopisoft<br>

##############################

AdoPiSoft fail2ban install script.<br>

wget https://raw.githubusercontent.com/kcaBmask/adopisoft/main/f2b.sh && sudo chmod a+x f2b.sh && bash f2b.sh<br>
Default ban time for sshd and adopisoft 10 minutes.<br>
To check all the banned ip address type this command: fail2ban-client banned<br>
To unban ip address type this command: fail2ban-client unban ipaddresshere
