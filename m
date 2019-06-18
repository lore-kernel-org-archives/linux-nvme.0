From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 12:10:23 +0200
Subject: [PATCH 0/2] nvme: flush rescan worker before resetting
Message-ID: <20190618101025.78840-1-hare@suse.de>

Hi all,

There is a race condition between namespace rescanning and controller
reset; during controller reset all namespaces are quiesed vie
nams_stop_ctrl(), and after reset all namespaces are unquiesced
again.
When namespace scanning was active by the time controller reset was
triggered the rescan code will call nvme_ns_remove(), which then will
cause a kernel crash in nvme_start_ctrl() as it'll trip over
uninitialized namespaces.

To fix this two patches are required; the first one will skip the call
to nvme_ns_remove() if the controller is not live, and the second one
will flush the rescan worker before resetting to avoid this situation
from occurring.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: Do not remove namespaces during reset
  nvme: flush scan_work when resetting controller

 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 drivers/nvme/host/fc.c   |  1 +
 drivers/nvme/host/rdma.c |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 4 files changed, 24 insertions(+)

-- 
2.16.4
