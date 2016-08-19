
## Kerberos Authentication for the Hadoop infrastructure on Cypress

As part of the authentication and authorization mechanism of Cypress to ensure
individual security, we utilize Kerberos to enable interactions between users
and the Hadoop infrastructure on Cypress. In the future, Kerberos will be
authenticated against Clemson University's LDAP server, but at the moment, a
separate Kerberos account is needed for each user. The Kerberos account will be created with a
default password at the time that the user is granted access to Cypress.

### First Login - Change Kerberos Account Password
When you log into **dsciu001** for the first time, you need to change your Kerberos
password to something different than the default password assigned to you. We recommend that you change your Kerberos password to match your Clemson password. The steps to change Kerberos password are as follows:

1. Connect to the dsciu001 node: ```ssh user@dsciu001-ext.palmetto.clemson.edu```
2. Type your Clemson password and press enter.
3. Run kpasswd to change your Kerberos password: ```kpasswd```
4. Type the provided temporary password for Kerberos and press enter.
5. Type your new password and press enter.
6. Type your new password and press enter again.

### How to Authenticate

In order for you to run ```hdfs``` or ```yarn``` commands successfully, you must be authenticated by Kerberos on the dsciu001 node.

1. Connect to the dsciu001 node (if you are not already connected to it): ```ssh username@dsciu001-ext.palmetto.clemson.edu```
2. Run the following command: ```kinit```
3. Type your Kerberos password and press enter.

Now, you should be able to interact with Hadoop components on Cypress.

### Verify

**NOTE:** The authentication ticket will expire (default is 1 day), so you will need to run kinit again to renew the ticket.

To check when your ticket will expire:

1. Run the following on the **dsciu001** node: ```klist```

```klist``` produces output similar to this if you have already run kinit successfully:

    Ticket cache: FILE:/tmp/krb5cc_137830
    Default principal: username@PALMETTO.CLEMSON.EDU

    Valid starting       Expires              Service principal
    06/10/2016 11:06:49  06/11/2016 11:06:49  krbtgt/PALMETTO.CLEMSON.EDU@PALMETTO.CLEMSON.EDU

## Environment Customization

Instructions detailing how to customize your environment (especially important for streaming jobs that drive external applications) can be found at <a href="http://www.palmetto.clemson.edu/pages/userguide.html#software" target="_blank">Palmetto's User Guide</a>.
