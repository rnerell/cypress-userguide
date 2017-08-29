
## Kerberos Authentication for the Hadoop infrastructure on Cypress

As part of the authentication and authorization mechanism of Cypress to ensure individual security, we utilize Kerberos to enable interactions between users and the Hadoop infrastructure on Cypress. Your Kerberos account will be created with a random key at the time that you are granted access to Cypress. The key is made available to you via a special file, called a keytab, which is written to your home directory on Palmetto. **In the documentation that follows, substitute "username" with your Clemson username.**

The precise location of your keytab file is: **/home/username/.username-keytab**

### How to Authenticate

In order for you to run ```hdfs``` or ```yarn``` commands successfully, you must be authenticated by Kerberos on the Cypress user node.

1. Connect to the Cypress user node (if you are not already connected to it): ```ssh username@login.palmetto.clemson.edu -t ssh username@dsciutil```
2. Run the following command: ```kinit -k -t ~/.username-keytab username```

Now, you should be able to interact with Hadoop components on Cypress.

### Verify

**NOTE:** The authentication ticket will expire in 7 days, so you will need to run kinit again to renew the ticket.

To check when your ticket will expire:

1. Run the following on the Cypress user node: ```klist```

```klist``` produces output similar to this if you have already run kinit successfully:


    Ticket cache: FILE:/home/username/.krb5cc
    Default principal: username@PALMETTO.CLEMSON.EDU

    Valid starting       Expires              Service principal
    08/14/2017 16:08:17  08/21/2017 16:08:17  krbtgt/PALMETTO.CLEMSON.EDU@PALMETTO.CLEMSON.EDU


## Environment Customization

Instructions detailing how to customize your environment (especially important for streaming jobs that drive external applications) can be found at <a href="https://www.palmetto.clemson.edu/palmetto/pages/userguide.html#software" target="_blank" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer">Palmetto's User Guide</a>.
