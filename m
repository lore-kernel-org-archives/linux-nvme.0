From: keith.busch@intel.com (Keith Busch)
Date: Tue,  9 Jul 2013 14:20:36 -0600
Subject: [PATCHv4 0/5] NVMe: suspend resume
Message-ID: <1373401241-20259-1-git-send-email-keith.busch@intel.com>

Next version of suspend resume.

v3->v4:

Changed bool to u8 in struct nvme_queue so it has a known size.

Simplified getting the extra data allocated per queue into a function
since the calculation is used in multiple places.

Removed ioremap failure; this is unrelated to this patch set and will
be corrected in a different patch.

Used list_del_init so that we may call it multiple times if resume fails.

Re-ordered some of the changes into later patches where the code is
actually used.

Keith Busch (5):
  NVMe: Group pci related actions in functions
  NVMe: Separate queue alloc/free from create/delete
  NVMe: Separate controller init from disk discovery
  NVMe: Use normal shutdown
  NVMe: Add pci suspend/resume driver callbacks

 drivers/block/nvme-core.c |  409 +++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h      |    2 +
 2 files changed, 288 insertions(+), 123 deletions(-)
