From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 13 Feb 2017 09:11:08 -0700
Subject: SED Opal Fixups
Message-ID: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>

So we have a few patches here, they're pretty small. First patch changes
the sed-opal ioctl function parameters to take a void __user* instead of
an unsigned long, this required a small cast in the nvme driver.
Patch 2 is a UAPI fixup for the IOW to make an ioctl
the right size. Patch 3 fixes a compiliation error when building using
KSAN due to the stack frame being too large. And lastly we move the
Maintainers list from nvme to linux-block.
