
## Requesting Access

**To access and use Cypress, a Palmetto account is required.** Clemson students, faculty, and staff can request a Palmetto account by completing the online account request form <a href="http://citi.clemson.edu/new-account/" target="_blank">available here</a>.
- **NOTE:** If you are requesting a Palmetto account primarily to use Cypress, then write that in the *Research Abstract* answer box of the form. You don't have to provide a detailed explanation on that form.

**Next, you must request access to Cypress** by filling out <a href="https://goo.gl/forms/lkTVwO7zDARqhfrP2" target="_blank">this simple form</a>. Please write a few sentences about how you intend to use Cypress under the "Research Abstract" on this form. Once you receive notification of your account being created on Cypress you'll be able to log into the Cypress Cluster *User Node*.

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
