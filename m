From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Jul 2013 15:02:18 -0600
Subject: [PATCHv5 0/6] NVMe: suspend resume
Message-ID: <1373922144-24341-1-git-send-email-keith.busch@intel.com>

... yet another version.

v4->v5:

Renamed 'nvme_free_queue_mem' to 'nvme_free_queue' since it does more
than simply freeing the queue's memory; the bio_list is cleared here
instead of when disabling the queue since it doesn't appear anything
stops IO from being submitted while the device is being suspended.
The driver should be able to complete these bio requests after resume,
so we clear the bio_list only when we don't expect the device to start
handling IO again.

Moved the check for freeing previously allocated IO queues that are
no longer usable to the 'suspend/resume' patch since it would not be
possible to hit that code in the patch where it was initially added.

Added the patch to handle ioremap failure at the end of this change set
since we can use the newly added q_suspended flag to know whether or
not to call free_irq on the admin queue on initialization failure.

Fixed previous merge error setting dma coherent mask twice.

A few checkpatch issues.

Keith Busch (6):
  NVMe: Group pci related actions in functions
  NVMe: Separate queue alloc/free from create/delete
  NVMe: Separate controller init from disk discovery
  NVMe: Use normal shutdown
  NVMe: Add pci suspend/resume driver callbacks
  NVMe: Handle ioremap failure

 drivers/block/nvme-core.c |  437 +++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h      |    2 +
 2 files changed, 308 insertions(+), 131 deletions(-)
