From: scott.bauer@intel.com (Scott Bauer)
Date: Mon,  6 Feb 2017 17:22:48 -0700
Subject: No subject
Message-ID: <1486426969-27549-1-git-send-email-scott.bauer@intel.com>

I screwed up and had size_t's in the uapi structures which of course
differ in size on 32 and 64 bit platforms. This caused issues running
32 bit userland on a 64 bit kernel. We're hoping to sneak this
patch in so we don't have to maintain a compat layer.
