From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 17 May 2013 09:35:17 -0400
Subject: Tree updated 2013-05-17
Message-ID: <20130517133517.GO6057@linux.intel.com>


I've pulled in a few fixes:

Dan Carpenter (2):
      MAINTAINERS: update NVM EXPRESS DRIVER file list
      NVMe: check for integer overflow in nvme_map_user_pages()

Keith Busch (1):
      NVMe: Do not cancel command multiple times

Sachin Kamat (1):
      NVMe: Remove redundant version.h header include

Vishal Verma (1):
      NVMe: Fix a signedness bug in nvme_trans_modesel_get_mp

Wei Yongjun (1):
      NVMe: fix error return code in nvme_submit_bio_queue()

I'll ask Linus to pull them next week, and they should be in 3.10.

I've also set up separate branches for "just fixes" (fixes-3.10) and
features / improvements that aren't bug fixes (master).  Right now,
they're the same, but I would expect them to diverge fairly shortly.
