
## Requesting Access

**To access and use Cypress, a Palmetto account is required.** Clemson students, faculty, and staff can request a Palmetto account by completing the online account request form <a href="http://citi.clemson.edu/new-account/" target="_blank">available here</a>.

**Next, you must request access to Cypress** by filling out <a href="https://goo.gl/forms/lkTVwO7zDARqhfrP2" target="_blank">this simple form</a>. Once you receive notification of your account being created on Cypress you'll be able to log into the Cypress Cluster *User Node*.

## The Cypress Cluster User Node

The purpose of the Cypress Cluster User Node is to provide access to users via SSH which enables users to:

- access the various services and programs
- transfer data between HDFS and other systems (both local and remote)
- access web interfaces (via Firefox running on the user node)

### Connecting to the User Node

The best way to access the Cypress User Node is to connect directly to it via SSH at the following address: **dsciu001-ext.palmetto.clemson.edu**

e.g.

    ssh username@dsciu001-ext.palmetto.clemson.edu

- **NOTE:** If you are connecting from outside the Clemson network, then you must establish a VPN session before attempting to use the dsciu001-ext.palmetto.clemson.edu address. See [this link](https://www.clemson.edu/ccit/get_connected/vpn/) for more information on using VPN.

### Connecting to the User Node from any node on Palmetto**

You may connect to the Cypress User Node from any Palmetto node using the following short hostname: **dsciu001**

e.g.

    ssh dsciu001

**Enabling Kerberos authentication for the Hadoop infrastructure on Cypress**

As part of the authentication and authorization mechanism of Cypress to ensure
individual security, we utilize Kerberos to enable interactions between users
and the Hadoop infrastructure on Cypress. In the future, Kerberos will be
authenticated against Clemson University's LDAP server. At the moment, a
separate Kerberos account is needed for each user, which will be created with a
default password at the time that the user is granted access to Cypress.

When you first log into **dsciu001**, you need to change the default Kerberos
password. We recommend that you change Kerberos password to match Clemson password. The steps to change Keberos password are as followed:

1. Connect to the dsciu001 node:
```sh
ssh user@dsciu001-ext.palmetto.clemson.edu
```
2. Type your Clemson password and press enter.

3. Run kpasswd to change your Kerberos password:
```sh
kpasswd
```
4. Type the provided temporary password for Kerberos and press enter.
5. Type your new password and press enter.
6. Type your new password and press enter again.

In order for you to run hdfs or yarn commands successfully, you must be authenticated by Kerberos on the dsciu001 node.

1. Connect to the dsciu001 node (if you are not already connected to it):
```sh
ssh user@dsciu001-ext.palmetto.clemson.edu
```

2. Run the following command:
```sh
kinit
```
3. Type your Kerberos password and press enter.

Now, you should be able to interact with Hadoop components on Cypress.

**NOTE:** The authentication ticket will expire (default is 1 day), so you will need to run kinit again to renew the ticket.

To check when your ticket will expire:

1. Run the following on the dsciu001 node:
```sh
klist
```

Which produces output similar to this if you have already run kinit successfully:

    Ticket cache: FILE:/tmp/krb5cc_137830
    Default principal: user@PALMETTO.CLEMSON.EDU

    Valid starting       Expires              Service principal
    06/10/2016 11:06:49  06/11/2016 11:06:49  krbtgt/PALMETTO.CLEMSON.EDU@PALMETTO.CLEMSON.EDU

**Password problems?**  

Usernames and passwords should always be entered in a case-sensitive fashion (not all-caps).
The Palmetto support team is unable to help with password problems, so you'll need to call the CCIT
Support HelpDesk at **864-656-3494**. They may be able to help you with verifying or resetting your password.
