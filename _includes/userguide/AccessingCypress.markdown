In order to gain access to the Cypress node (**resourcemgr**) where job can be submitted, one must first have access to Palmetto. Clemson students, faculty, and staff can request a Palmetto  account by completing the online account request form, 
available here:  <http://citi.clemson.edu/new-account/>

After access to Palmetto is granted, users can request access to Cypress by contacting the Data Science Group at {lngo,denton}[at]{clemson.edu}.

**Connecting to the Head/Log-in Node of Palmetto**

MacOSX & Linux/Unix users, simply open a Terminal window and connect via SSH:

    ssh username@user.palmetto.clemson.edu 

Windows users,  connect using SSH Secure Shell 
(available at  <http://www.clemson.edu/softrepo/Win/SSH/sshclient.exe>):

Field | Value
----- | --------
Host Name |  `user.palmetto.clemson.edu`
User Name | `username`
Port Number |  `22`
Authentication Method |  `[none specified]`


**Password problems?**  

Usernames and passwords should always be entered in a case-sensitive fashion (not all-caps). 
The Palmetto support team is unable to help with password problems, so you'll need to call the CCIT 
Support HelpDesk at **864-656-3494**. They may be able to help you with verifying or resetting your password.

**Connecting to the Staging Node of Cypress from any node on Palmetto**

    ssh resourcemgr
