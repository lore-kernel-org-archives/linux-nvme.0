From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 31 Jan 2018 18:31:23 +0200
Subject: [PATCH v3 0/3] Fix host side state machine
Message-ID: <1517416286-31109-1-git-send-email-maxg@mellanox.com>

Hi all,
this series is rebased above nvme-4.16.
Actually there is a still missing part in this tree (but I tested it on
my own "stable" mixed kernel with this patch):
"nvme-rdma: fix concurrent reset and reconnect" from Sagi.

The first motivation for this series was fixing RDMA initiator that crushes in
case we fail during initial connect and start error recovery during initial
connection establishment.
This patchset also renames NVME_CTRL_RECONNECTING to NVME_CTRL_CONNECTING as
this state doesn't represent only a reconnection flow but also used for
initialization process.

The tested transport for these patches was RDMA.
It will be appriciated if someone can run this series with real FC HW (to test
patch #3).

changes from V2 (James will implement the support for FC and resubmit the deleted patch):
 - removed FC support
 - removed the "nvme: delete NVME_CTRL_NEW --> NVME_CTRL_LIVE transition"

changes from V1:
 - Added FC support

Max Gurtovoy (3):
  nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
  nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
  nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition

 drivers/nvme/host/core.c    | 12 ++++++------
 drivers/nvme/host/fabrics.h |  9 +++++----
 drivers/nvme/host/fc.c      | 14 +++++++-------
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  8 ++++----
 drivers/nvme/host/rdma.c    |  7 +++++--
 6 files changed, 28 insertions(+), 24 deletions(-)

-- 
1.8.3.1
