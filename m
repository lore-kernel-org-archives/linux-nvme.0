From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 10 Feb 2017 09:00:52 -0700
Subject: Sed-opal Fixes
Message-ID: <1486742454-3254-1-git-send-email-scott.bauer@intel.com>

changes from v3->v4:

Changed manual kzalloc + copy from user to memdup_user.

This small series fixes a small ABI issue when using the _IOC_SIZE
with the Activate Locking SP ioctl. I had put the wrong structure
in the IOW macro in the uapi header which caused issues when trying
to copy in the contents for the command.
