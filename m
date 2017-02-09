From: scott.bauer@intel.com (Scott Bauer)
Date: Thu,  9 Feb 2017 10:19:59 -0700
Subject: Sed-opal fixups 
Message-ID: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>

It may be too late to change anyhting in the uapi header. When we
switched over to using IOC_SIZE I found a bug where I had switched
up a structure in one of the series from v4 to v5 but never changed
the structure in the IOW. The structure that was in there was to small
so when we kzalloc on it we don't request enough space. It worked before
because we were using the cmd strictly as a command #, not using the IOC
and friends.

If it's too late to modify that IOW, I can work around it by reallocing
on the correct size for that command only. I verified the rest of the
commands and the structures are the same.

Let me know what you think, please.
