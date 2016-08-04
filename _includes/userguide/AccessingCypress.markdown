
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

### Connecting to the User Node from any node on Palmetto

You may connect to the Cypress User Node from any Palmetto node using the following short hostname: **dsciu001**

e.g.

    ssh dsciu001

### Password problems?

Usernames and passwords should always be entered in a case-sensitive fashion (not all-caps).
The Palmetto support team is unable to help with password problems, so you'll need to call the CCIT
Support HelpDesk at **864-656-3494**. They may be able to help you with verifying or resetting your password.

### Web Interfaces

There are web interfaces for many of the various services included with HDP, but the *Ambari* interface is one of the most important for understanding the status and configuration of the cluster.

- This interface can be accessed at: http://dscim003.palmetto.clemson.edu:8080
- The public (read-only) login/password to use Ambari is *user/user*

**NOTE:** This web interface, as well as all of the other web interfaces are only available internally to Palmetto nodes. To view these interfaces, you must open a Firefox browser on dsciu001-ext.palmetto.clemson.edu or user.palmetto.clemson.edu via X11 tunnel. Instructions detailing how to set up X11 tunneling can be found <a href="http://www.palmetto.clemson.edu/pages/userguide.html#graphical" target="_blank">here</a>.

- Once your computer is configured for X11 tunneling, opening Ambari is as simple as this:
  - ```ssh -X username@dsciu001-ext.palmetto.clemson.edu 'firefox http://dscim003.palmetto.clemson.edu:8080'```
- **NOTE:** You will achieve the best results if you use a wired network connection located on campus.

### Kerberos Authentication for the Hadoop infrastructure on Cypress

As part of the authentication and authorization mechanism of Cypress to ensure
individual security, we utilize Kerberos to enable interactions between users
and the Hadoop infrastructure on Cypress. In the future, Kerberos will be
authenticated against Clemson University's LDAP server, but at the moment, a
separate Kerberos account is needed for each user. The Kerberos account will be created with a
default password at the time that the user is granted access to Cypress.

#### First Login - Change Kerberos Account Password
When you log into **dsciu001** for the first time, you need to change your Kerberos
password to something different than the default password assigned to you. We recommend that you change your Kerberos password to match your Clemson password. The steps to change Kerberos password are as follows:

1. Connect to the dsciu001 node: ```ssh user@dsciu001-ext.palmetto.clemson.edu```
2. Type your Clemson password and press enter.
3. Run kpasswd to change your Kerberos password: ```kpasswd```
4. Type the provided temporary password for Kerberos and press enter.
5. Type your new password and press enter.
6. Type your new password and press enter again.

#### Authenticate

In order for you to run ```hdfs``` or ```yarn``` commands successfully, you must be authenticated by Kerberos on the dsciu001 node.

1. Connect to the dsciu001 node (if you are not already connected to it): ```ssh username@dsciu001-ext.palmetto.clemson.edu```
2. Run the following command: ```kinit```
3. Type your Kerberos password and press enter.

Now, you should be able to interact with Hadoop components on Cypress.

#### Verify

**NOTE:** The authentication ticket will expire (default is 1 day), so you will need to run kinit again to renew the ticket.

To check when your ticket will expire:

1. Run the following on the **dsciu001** node: ```klist```

```klist``` produces output similar to this if you have already run kinit successfully:

    Ticket cache: FILE:/tmp/krb5cc_137830
    Default principal: username@PALMETTO.CLEMSON.EDU

    Valid starting       Expires              Service principal
    06/10/2016 11:06:49  06/11/2016 11:06:49  krbtgt/PALMETTO.CLEMSON.EDU@PALMETTO.CLEMSON.EDU
