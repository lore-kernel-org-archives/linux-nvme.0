From: keith.busch@intel.com (Keith Busch)
Date: Thu,  1 Oct 2015 17:14:09 -0600
Subject: [PATCH 0/2] Namespace attachment fixes/simplifications
Message-ID: <1443741251-13274-1-git-send-email-keith.busch@intel.com>

This started off investigating a suggestion Christoph made on the awkward
way the driver removes disks if the controller can't handle IO after
attempting a resume from suspend.

It turns out that it has been a LONG time since the error path from
resume was tested. It definitely was broken, so this turned into a two
part series. I can split 2/2 into a two more if anyone thinks changes
are unrelated.

>From testing it became clear that it is not sufficient to reference count
only the controller anymore. Jens suggested a while back to reference
count the namespaces, but I didn't think there was a need since namespaces
couldn't be deleted while the controller had active references anyway. Now
that namespaces can be deleted independent of the controller, we really
do need a separate reference count.

Keith Busch (2):
  NVMe: Reference count open namespaces
  NVMe: Simplify device resume on io queue failure

 drivers/block/nvme-core.c |   80 ++++++++++++++++++---------------------------
 include/linux/nvme.h      |    2 +-
 2 files changed, 32 insertions(+), 50 deletions(-)

-- 
1.7.10.4
