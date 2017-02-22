From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 10:15:05 -0700
Subject: Final opal patches for rc1
Message-ID: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>

These are the final changes for rc1.

Patch 1 contains some code to clean up an opal structure if something changes
at runtime. (already reviewed by Christoph)

Patch 2 contains changes to the nvme driver to use the above patch. If a new
FW is loaded and we no longer support opal we clean up. This patch is based off
code from Keith and Christoph.

Patch 3 is a one line change to propagate an original error messaage to user
land instead of the return status of the session termination code.
