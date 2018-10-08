From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:38 -0700
Subject: [PATCH 00/16] Fixes for issues detected by static analyzers
Message-ID: <20181008212854.68310-1-bvanassche@acm.org>

Hi Keith, Christoph and Sagi,

This patch series addresses several issues reported by static analyzers like
sparse, smatch and Coverity. Please consider these patches for Linux kernel
v4.20.

Thanks,

Bart.

Bart Van Assche (16):
  nvme-core: Declare local symbols static
  nvme-core: Refuse out-of-range integrity data seeds
  nvme-core: Rework a NQN copying operation
  nvme-core: Complain if nvme_init_identify() fails
  nvme-pci: Fix nvme_suspend_queue() kernel-doc header
  nvme-fc: Fix kernel-doc headers
  nvme-fc: Introduce struct nvme_fcp_op_w_sgl
  nvme-fc: Rework the request initialization code
  nvmet-fc: Fix kernel-doc headers
  nvmet-fcloop: Suppress a compiler warning
  nvmet: Use strcmp() instead of strncmp() for subsystem lookup
  nvmet: Remove unreachable code from nvmet_parse_discovery_cmd()
  nvmet: Use strlcpy() instead of strcpy()
  nvmet: Avoid integer overflow in the discard code
  nvmet-rdma: Declare local symbols static
  nvmet-rdma: Check for timeout in nvme_rdma_wait_for_cm()

 drivers/nvme/host/core.c          | 14 +++++++---
 drivers/nvme/host/fc.c            | 45 ++++++++++++++++++-------------
 drivers/nvme/host/pci.c           |  2 +-
 drivers/nvme/host/rdma.c          |  9 ++++++-
 drivers/nvme/target/Makefile      |  2 ++
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        |  3 +--
 drivers/nvme/target/discovery.c   |  7 ++---
 drivers/nvme/target/fc.c          |  6 ++---
 drivers/nvme/target/io-cmd-file.c |  3 ++-
 drivers/nvme/target/rdma.c        |  2 +-
 11 files changed, 59 insertions(+), 36 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
