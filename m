From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue,  9 Jan 2018 10:03:11 +0800
Subject: [PATCH V2 0/2] nvme-pci: fix the timeout case when reset is ongoing
Message-ID: <1515463393-3004-1-git-send-email-jianchao.w.wang@oracle.com>

Hello

NVME_CTRL_RESETTING used to indicate the range of nvme initializing
strictly in fd634f41(nvme: merge probe_work and reset_work), but it
is not now. The NVME_CTRL_RESETTING is set before queue the
reset_work, there could be a big gap before the reset work handles
the outstanding requests. So when the NVME_CTRL_RESETTING is set,
nvme_timeout will not only meet the admin requests from the
initializing procedure, but also the IO and admin requests from
previous work before nvme_dev_disable is invoked.

To fix this, based on Christoph's suggestion, splits the
NVME_CTRL_RESETTING into NVME_CTRL_RESET_PREPARE
and NVME_CTRL_RESETTING. Before queue the reset work, changes state
to NVME_CTRL_RESET_PREPARE, after disable work completes, changes
state to NVME_CTRL_RESETTING. Then we could distinguish the different
requests and handle them separately. More details, please refer to
the comment of the 2nd patch.


V2:
 - split NVME_CTRL_RESETTING into NVME_CTRL_RESET_PREPARE and
   NVME_CTRL_RESETTING. Introduce new patch based on this.
 - distinguish the requests based on the new state in nvme_timeout
 - change comments of patch

Jianchao Wang(2)
0001-nvme-split-resetting-state-into-reset_prepate-and-re.patch
0002-nvme-pci-fix-the-timeout-case-when-reset-is-ongoing.patch

drivers/nvme/host/core.c   | 17 ++--------------
drivers/nvme/host/fc.c     |  2 --
drivers/nvme/host/nvme.h   |  1 -
drivers/nvme/host/pci.c    | 51 +++++++++++++---------------------------------
drivers/nvme/host/rdma.c   |  8 --------
drivers/nvme/target/loop.c |  5 -----
6 files changed, 16 insertions(+), 68 deletions(-)

Thanks
Jianchao
