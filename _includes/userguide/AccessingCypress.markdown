
## Requesting Access

**To access and use Cypress, both a Palmetto account and a Cypress account are required.** Clemson students, faculty, and staff can request a Palmetto account by completing the online account request form <a href="http://citi.clemson.edu/new-account/" target="_blank" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer">available here</a>.
- **NOTE:** If you are requesting a Palmetto account primarily to use Cypress, then write that in the *Research Abstract* answer box of the form. You don't have to provide a detailed explanation on that form.

**Next, you must request access to Cypress** by filling out <a href="https://goo.gl/forms/lkTVwO7zDARqhfrP2" target="_blank" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer" rel="noopener noreferrer">this simple form</a>. Please write a few sentences about how you intend to use Cypress under the "Research Abstract" on this form. Once you receive notification of your account being created on Cypress you'll be able to log into the Cypress Cluster *User Node*.

## The Cypress Cluster User Node

The purpose of the Cypress Cluster User Node is to provide access to users via SSH which enables users to:

- access the various services and programs
- transfer data between HDFS and other systems (both local and remote)
- access web interfaces (via Firefox running on the user node)

### Connecting to the User Node

To access the Cypress User Node (dsciutil), first connect to Palmetto's login node via SSH at the following address: **login.palmetto.clemson.edu**

e.g.

    ssh username@login.palmetto.clemson.edu

Then ssh to dsciutil at the following address: **dsciutil**

    ssh username@dsciutil

### Connecting to the User Node from any node on Palmetto

*dsciutil* is the hostname of the Cypress Cluster User Node, and this short address only works if you are already on the Palmetto network.

You may connect to the Cypress User Node from any Palmetto node using the following short hostname: **dsciutil**

e.g.

    ssh dsciutil

### Password problems?

Usernames and passwords should always be entered in a case-sensitive fashion (not all-caps).
The Palmetto support team is unable to help with password problems, so you'll need to call the CCIT
Support HelpDesk at **864-656-3494**. They may be able to help you with verifying or resetting your password.

### Web Interfaces

There are web interfaces for many of the various services included with HDP, but the *Ambari* interface is one of the most important for understanding the status and configuration of the cluster.

- This interface can be accessed at: http://dscim003.palmetto.clemson.edu:8080
- The public (read-only) login/password to use Ambari is *user/user*

**NOTE:** This web interface, as well as all of the other web interfaces are only available internally to Palmetto nodes. To view these interfaces, you must open a Firefox browser on login.palmetto.clemson.edu via X11 tunnel. Instructions detailing how to set up X11 tunneling can be found <a href="https://www.palmetto.clemson.edu/palmetto/userguide_howto_run_graphical_applications.html" target="_blank">here</a>.

- Once your computer is configured for X11 tunneling, you may open Ambari like this:
  - ```ssh -X username@login.palmetto.clemson.edu 'firefox http://dscim003.palmetto.clemson.edu:8080'```
- **NOTE:** You will achieve the best results if you use a wired network connection located on campus.
