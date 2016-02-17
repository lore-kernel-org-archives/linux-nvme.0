From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 11:36:50 -0700
Subject: [PATCH-4.5-v3 0/5] NVMe hot plug stuff
Message-ID: <1455734215-20396-1-git-send-email-keith.busch@intel.com>

This is based of the current linux-block/for-linus branch.

Only 4/5 is the same as from v2, and have retained the reviews. The rest
are new or different.

v2->v3:

  Used a different approach to the namespace removal deadlock by reducing
  the scope of the namespace mutex so removal doesn't hold it during
  IO. This has a dependency on the first patch to ensure a scan doesn't
  somehow trigger (however unlikely) during removal.

  Squashed v2's follow up fix for checking namespace state in nvme's queue_rq.

  The final patch doesn't unmap controller registers until removal. This
  makes it safe to run startup and shutdown concurrently. We could
  possibly later micro optimize the IO path since the queue doorbell is
  always mapped. The patch was tested with suspend/resume using rtcwake.

Keith Busch (5):
  NVMe: Add controller removing state
  NVMe: Fix namespace removal deadlock
  NVMe: Simplify device reset failure
  NVMe: Move error handling to failed reset handler
  NVMe: Don't unmap controller registers on reset

 drivers/nvme/host/core.c |  62 +++++++++++++++--------
 drivers/nvme/host/nvme.h |   6 +++
 drivers/nvme/host/pci.c  | 125 ++++++++++++++++++++++++++---------------------
 3 files changed, 118 insertions(+), 75 deletions(-)

-- 
2.6.2.307.g37023ba
