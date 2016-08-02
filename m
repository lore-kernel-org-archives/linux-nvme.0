From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  2 Aug 2016 10:53:34 +0300
Subject: [PATCH v2 0/5] Some fabrics fixes
Message-ID: <1470124419-30405-1-git-send-email-sagi@grimberg.me>

A set of fixes to the nvme-rdma host driver. First two patches relate
to bug reports from Steve Wise on dervice removal handling (and go
together with Steve's iwcm patch set).

Next two patches remove redundant calls to nvme_remove_namespaces
which is called from nvme_uninit_ctrl.

The last patch fixes the host behavior that it never shutdown the
controller (wrong check on the controller state). Christoph,
we can either go with this and change the behavior incrementally
(currently we never shutdown the controller) or I can just remove
the patch altogether.

Changes from v1:
- rearranged nvme ctrl remove to avoid code duplication
- added some change log info to rdma and loop uninit and
  shutdown reordering.
- collected some review tags

Sagi Grimberg (5):
  nvme-rdma: Fix device removal handling
  nvme-rdma: Remove duplicate call to nvme_remove_namespaces
  nvme-rdma: Free the I/O tags when we delete the controller
  nvme-loop: Remove duplicate call to nvme_remove_namespaces
  nvme-rdma: Make sure to shutdown the controller if we can

 drivers/nvme/host/rdma.c   | 72 +++++++++++++++++++++++++---------------------
 drivers/nvme/target/loop.c |  4 +--
 2 files changed, 40 insertions(+), 36 deletions(-)

-- 
1.9.1
