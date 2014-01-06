From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 Jan 2014 12:04:10 -0700
Subject: [PATCHv2 0/2] NVMe: Use after free on removal fixes
Message-ID: <1389035052-30007-1-git-send-email-keith.busch@intel.com>

v1->v2:

I split this in two from the previous version: one to reference count
open block handles and another use rcu protect queues. The two are not
dependent on each other.

Changed synchronize_rcu() for each nvmeq to call_rcu() + rcu_barrier()
instead. On my test setup, the previous version took 4x longer on an
otherwise idle system to unload the module compared this one, so that
was a good suggestion. I think it was recommended to use rcu_barrier()
in the module_exit, but I put it in the pci_driver's 'remove' because
the nvme_queue's q_dmadev isn't valid after the remove. We could call
get/put_device to keep the q_dmadev valid, but I thought this was simpler.

Removed the cancel_ios call in nvme_free_queues since this function is
not called while the queues have active commands.

Removed the the part_stat_lock macro usage for the rcu locking and
get_cpu.

Fixed freeing namespaces on probe failure.

Keith Busch (2):
  NVMe: Namespace use after free on surprise removal
  NVMe: RCU access to nvme_queue

 drivers/block/nvme-core.c |   93 +++++++++++++++++++++++++++------------------
 include/linux/nvme.h      |    2 +-
 2 files changed, 56 insertions(+), 39 deletions(-)

-- 
1.7.10.4
