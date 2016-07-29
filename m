From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 29 Jul 2016 22:57:17 +0300
Subject: [PATCH 0/5] Some fabrics fixes
Message-ID: <1469822242-3477-1-git-send-email-sagi@grimberg.me>

A set of fixes to the nvme-rdma host driver. First two patches relate
to bug reports from Steve Wise on dervice removal handling (and go
together with Steve's iwcm patch set).

Third patch fixes the host behavior that it never shutdown the
controller (wrong check on the controller state).

Last two patches remove redundant calls to nvme_remove_namespaces
which is called from nvme_uninit_ctrl.

Sagi Grimberg (5):
  nvme-rdma: Fix device removal handling
  nvme-rdma: Free the I/O tags when we delete the controller
  nvme-rdma: Make sure to shutdown the controller if we can
  nvme-rdma: Remove duplicate call to nvme_remove_namespaces
  nvme-loop: Remove duplicate call to nvme_remove_namespaces

 drivers/nvme/host/rdma.c   | 62 ++++++++++++++++++++++++----------------------
 drivers/nvme/target/loop.c |  4 +--
 2 files changed, 34 insertions(+), 32 deletions(-)

-- 
1.9.1
