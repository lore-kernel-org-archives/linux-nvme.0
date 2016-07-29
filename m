From: james.smart@broadcom.com (James Smart)
Date: Thu, 28 Jul 2016 17:00:24 -0700
Subject: [PATCH 0/3] nvme-fabrics: Patch host code in prep for FC
 transport support
Message-ID: <579a9c98.RJW1MNpcEjiTks4j%james.smart@broadcom.com>


Patch nvme-fabrics host code in prep for FC transport support:
- Add the host_traddr field to allow specification of the host-port
  connection info for the transport. Will be used by FC transport.
- Revise nvmf_get_address() string to account for not all options being
  present.
- Revise some of the comments so not so ethernet-network centric

Patches are cut against the linux-nvme for-4.8/drivers branch

Note: This patch set was created, on recommendation from Johannes Thumshirn,
from a prior patch:
  http://lists.infradead.org/pipermail/linux-nvme/2016-July/005502.html


Signed-off-by: James Smart <james.smart at broadcom.com>

James Smart (3):
  nvme-fabrics: rework nvmf_get_address() for variable options
  nvme-fabrics: revise transport option descriptions
  nvme-fabrics: Add host_traddr options field to host infrastructure

 drivers/nvme/host/fabrics.c | 25 +++++++++++++++++++++++--
 drivers/nvme/host/fabrics.h | 11 ++++++++---
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.5.0
