From: matthew.r.wilcox@intel.com (Matthew Wilcox)
Date: Wed, 29 Jan 2014 12:00:14 -0500
Subject: [PATCH 0/2] Fixes that just showed up in the NVMe tree
Message-ID: <cover.1391014509.git.matthew.r.wilcox@intel.com>

A couple of patches I'm going to be submitting to Linus as part of this
pull request; sending them out by email as a courtesy.  I did just modify
a couple of Keith's patches; Fengguang's buildbot pointed out some new
sparse warnings and checkpatch pointed out some things I'd missed.

I'm also going to pull in a couple of Keith's recent patches; the ones
that fix bugs.  The cleanups are being left until a later date.

Matthew Wilcox (2):
  NVMe: Include device and queue numbers in interrupt name
  NVMe: Correct uses of INIT_WORK

 drivers/block/nvme-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
1.8.5.3
