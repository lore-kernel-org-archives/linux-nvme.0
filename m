From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:46 +0100
Subject: [PATCH 00/14] NVMe: Cleanup device initialization
Message-ID: <cover.1390897693.git.agordeev@redhat.com>

Hi Keith, Matthew,

Here are few fixes to the code that caught my eye.

These are unrelated to the patch "nvme: Use pci_enable_msi_range()
and pci_enable_msix_range()" I sent earlier, which still waits for
your review.

Thanks!

Alexander Gordeev (14):
  NVMe: Fix setup of affinity hint for unallocated queues
  NVMe: Cleanup nvme_alloc_queue() and nvme_free_queue()
  NVMe: Cleanup nvme_create_queue() and nvme_disable_queue()
  NVMe: Cleanup adapter_alloc_cq/sg() and adapter_delete_cq/sg()
  NVMe: Get rid of superfluous qid parameter to nvme_init_queue()
  NVMe: Get rid of superfluous dev parameter to queue_request_irq()
  NVMe: Make returning value consistent across all functions
  NVMe: nvme_dev_map() is a bad place to set admin queue IRQ number
  NVMe: Access interrupt vectors using nvme_queue::cq_vector only
  NVMe: Factor out nvme_set_queue_count()
  NVMe: Factor out nvme_init_bar()
  NVMe: Factor out nvme_init_interrupts()
  NVMe: Factor out nvme_setup_interrupts()
  NVMe: Rework "NVMe: Disable admin queue on init failure" commit

 drivers/block/nvme-core.c |  205 +++++++++++++++++++++++++++++----------------
 1 files changed, 133 insertions(+), 72 deletions(-)

-- 
1.7.7.6
