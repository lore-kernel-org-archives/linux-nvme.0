From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:27 +0300
Subject: [PATCH 00/12] Few more patches from the centralization set
Message-ID: <1499667759-15965-1-git-send-email-sagi@grimberg.me>

Mostly nvme-rdma. I'm trying to work my way incrementally so I can
start moving logic to nvme core in steps.

In the next set, I'll start detaching transport specific from
the reset, delete and error recovery flows.

In the set after that, I'll start adding the new transport ctrl->ops
and move some logic to the core.

Currently the new ctrl ops I'm shooting for are:
* ->alloc_admin_queue()
* ->free_admin_queue()
* ->start_admin_queue()
* ->stop_admin_queue()
* ->alloc_io_queues()	/* admin/io separation is due to how pci releases queues */
* ->free_io_queues()
* ->start_io_queues()
* ->stop_io_queues()
* ->alloc_tagset()
* ->free_tagset()
* ->transport_enable()	/* for pcie mostly */
* ->verify_ctrl()	/* for post features sanity checks */
* ->fast_fail_io()	/* for fc aborts handling */

Feedback and discussion is welcome.

Sagi Grimberg (12):
  nvme-rdma: move nvme_rdma_configure_admin_queue code location
  nvme: Add admin_tagset pointer to nvme_ctrl
  nvme-rdma: move tagset allocation to a dedicated routine
  nvme-rdma: disable the controller on resets
  nvme-rdma: don't free tagset on resets
  nvme-rdma: reuse configure/destroy_admin_queue
  nvme-rdma: introduce configure/destroy io queues
  nvme-rdma: stop queues instead of simply flipping their state
  nvme-rdma: rename nvme_rdma_init_queue to nvme_rdma_alloc_queue
  nvme-rdma: introduce nvme_rdma_start_queue
  nvme-rdma: cleanup error path in controller reset
  nvme-rdma: call ops->reg_read64 instead of nvmf_reg_read64

 drivers/nvme/host/fc.c     |   1 +
 drivers/nvme/host/nvme.h   |   1 +
 drivers/nvme/host/pci.c    |   1 +
 drivers/nvme/host/rdma.c   | 545 +++++++++++++++++++++++----------------------
 drivers/nvme/target/loop.c |   1 +
 5 files changed, 284 insertions(+), 265 deletions(-)

-- 
2.7.4
