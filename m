From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:05 +0300
Subject: [RFC PATCH 00/17] T10-PI support for NVMeoF/RDMA host
Message-ID: <1527436222-15494-1-git-send-email-maxg@mellanox.com>

Hello Sagi, Christoph, Keith, Jason and Co

This patchset adds T10-PI support for NVMeoF/RDMA host side, using signature
verbs API. This set starts with a few preparation commits to the RDMA/core
layer + a bug fix in iSER target ref_tag check mask. It continues with a few
fixes in the NVMe core layer and enablement of metadata support over fabrics.
The patchset ends with preparation patches in the RDMA transport that include
minor functionality changes.

The code was tested using Mellanox's ConnectX-4/ConnectX-5 HCA in the initiator
side vs. Mellanox offloaded target implementation using ConnectX-5 adapter (Currently
not upstream, but can be found in MLNX_OFED-4.1 and above packages).

This series applies on top of kernel 4.17-rc3 tag cleanly.

Currently, T10 support for the target side is in it's initial plans for implementation
but I decided to get some feadback first and push it incrementaly.

Most of the first patches can be pushed without waiting for final version of the later patches
in the series.

My next steps are:
 - run a nightly regression test suite to check that old functionality works properly
 - run performance benchmark with/without T10-PI
 - compare the results of the non T10-PI runs to previous results
 - run long IO run (using tools like ezFio/fio)
 - test the code using HCA's that don't support T10-PI offload (such as ConnectX-3)

Meanwhile, I would be happy to hear a feadback on this series :)
(also it will be great if someone can run it in his testing environments).

Max Gurtovoy (17):
  IB/isert: fix T10-pi check mask setting
  RDMA/core: introduce check masks for T10-PI offload
  IB/iser: use T10-PI check mask definitions from core layer
  IB/isert: use T10-PI check mask definitions from core layer
  nvme: Fix extended data LBA supported setting
  nvme: Add WARN in case fabrics ctrl was set with wrong metadata caps
  nvme: introduce max_integrity_segments ctrl attribute
  nvme: limit integrity segments to be <= data segments
  nvme: reduce the metadata size in case the ctrl doesn't support it
  nvme: export nvme_ns_has_pi function
  nvme-rdma: Introduce cqe for local invalidation
  nvme-rdma: Introduce nvme_rdma_set_keyed_sgl helper func
  nvme-rdma: introduce nvme_rdma_sgl structure
  nvme-rdma: refactor cmd mapping/unmapping mechanism
  nvme-rdma: Add helper function for preparing sg list to RDMA operation
  nvme-rdma: Introduce nvme_rdma_first_wr helper function
  nvme-rdma: Add T10-PI support

 drivers/infiniband/ulp/iser/iscsi_iser.h  |   4 -
 drivers/infiniband/ulp/iser/iser_memory.c |   4 +-
 drivers/infiniband/ulp/isert/ib_isert.c   |   6 +-
 drivers/nvme/host/core.c                  |  41 +-
 drivers/nvme/host/nvme.h                  |   2 +
 drivers/nvme/host/pci.c                   |   6 +
 drivers/nvme/host/rdma.c                  | 761 +++++++++++++++++++++++++-----
 include/rdma/ib_verbs.h                   |  13 +
 8 files changed, 701 insertions(+), 136 deletions(-)

-- 
1.8.3.1
