From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 31 Oct 2016 15:58:13 -0600
Subject: [RFC PATCH 0/6] Sed Opal
Message-ID: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>

This Patch series implements a large portion of the Opal protocol for
self encrypting devices. The driver has the capability of storing a
locking range's password, either directly in the driver, or in the
Kernel's key managment. The password can then be replayed during a
resume from previous suspend-to-RAM.

The driver also supports logic to bring the device out of a factory
default-inactive state into a functional Opal state.

The following logic is supported in order to bring the tper into a
working state:

1) Taking Ownership of the drive (Setting the Admin CPIN).
2) Activating the Locking SP (In Single User Mode or Normal Mode).
3) Setting up Locking Ranges (Single User or Normal Mode).
4) Adding users to Locking Ranges (Normal Mode Only).
5) Locking or Unlocking Locking Rangs (Single User Mode or Normal Mode).
6) Reverting the TPer (Restore to factory default).
7) Setting LR/User passwords (Single User Mode or Normal Mode).
8) Eabling/disabling Shadow MBR.
9) Enabling Users in the LockingSP (Normal Mode Only).
10) Saving Password for resume from suspend.


Each command above is exported through an ioctl in the block layer.

We have userland tooling staged in nvme-cli which can be used for
testing:
https://github.com/linux-nvme/nvme-cli/pull/137

Once we've fixed any nits and issues we will merge the userland tooling
into the master branch of nvme-cli.

I have a series of test scripts I've been using which can be helpful if
people want to test or immediately start using and testing the code:

https://github.com/ScottyBauer/nvme-cli-sed-sh


At a high level the code works by declaring a set of opal_step functions,
which we save in our opal_dev structure. The opal_step functions declare
the functions which are necessary to do the opal command. We start
dispatching the commands to the device, which return immediately. The
thread from userland calls into wait_for_cmd_completion to wait until
all the commands have finished. Each new command is issued in an interrupt
that signaled the completion of the previous command.

If a command requires information to complete we pass that information in
the opal_dev structure in the func_data. If a command needs to save data
to give to a future command it is saved in the prev_data.



On a side note, since these files are new I assume we will need to add
a new entry into MAINTAINERS for this code base, can anyone confirm that?
