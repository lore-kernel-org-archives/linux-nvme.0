From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue, 13 Feb 2018 13:49:15 +0100
Subject: [RFC PATCH 0/1] nvme: implement get log page offset and dwords
Message-ID: <20180213124916.28653-1-mb@lightnvm.io>

This patch introduces support for get log page offset and extends
the number of dwords to be 32 bits.

A function is introduced that takes the offset and implements the
support. This is needed for ocssd to retrieve the report chunk log
page, which can span a couple of megabytes.

The patch is based on Javier's report chunk implementation patch,
and is generalized to make it part of the nvme core. A follow up
patch will expose the extended function and let the lightnvm module
call it to retrieve the report chunk log page.

A couple of questions with respect to the function:

 1. Should we check the offset in the extended function to be dword
    aligned?
 2. Verify that when offset is defined, the nvme controller version
    is at least 1.2.1?
 3. Handle requests that are larger than supported by the mdts field?

My take is that the caller should handle all of the above.

Thanks!

Matias Bj?rling (1):
  nvme: implement log page low/high offset and dwords

 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.11.0
