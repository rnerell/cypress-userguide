**Requesting Access**

In order to use Cypress, one must first have an account on Palmetto. Clemson students, faculty, and staff can request a Palmetto account by completing the online account request form,
available here:  <http://citi.clemson.edu/new-account/>

After a Palmetto account has been created for you, you may request access to Cypress by filling out [this form](https://goo.gl/forms/lkTVwO7zDARqhfrP2). Once you receive notification of your account being created on Cypress you'll be able to log into the Cypress Cluster *User Node*.

**The Cypress Cluster *User Node***

The purpose of the Cypress Cluster *User Node* is to provide access to users via SSH which enables users to:
  - access the various services and programs
  - transfer data between HDFS and other systems (both local and remote)
  - access web interfaces (via Firefox running on the user node)

**Connecting to The Cypress Cluster *User Node***

The best way to access the Cypress User Node is to connect directly to it via SSH at the following address: **dsciu001-ext.palmetto.clemson.edu**

e.g.

    ssh username@dsciu001-ext.palmetto.clemson.edu

  - **NOTE:** If you are connecting from outside the Clemson network, then you must establish a VPN session before attempting to use the dsciu001-ext.palmetto.clemson.edu address. See [this link](https://www.clemson.edu/ccit/get_connected/vpn/) for more information on using VPN.

**Connecting to the User Node of Cypress From Any Node on Palmetto**

You may connect to the Cypress User Node directly from any Palmetto node using the following short hostname: **dsciu001**

e.g.

    ssh dsciu001

**Password problems?**  

Usernames and passwords should always be entered in a case-sensitive fashion (not all-caps).
The Palmetto support team is unable to help with password problems, so you'll need to call the CCIT
Support HelpDesk at **864-656-3494**. They may be able to help you with verifying or resetting your password.
