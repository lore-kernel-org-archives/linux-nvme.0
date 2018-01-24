From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 24 Jan 2018 18:57:43 +0200
Subject: [PATCH v1 0/4] Fix host side state machine
Message-ID: <1516813067-1717-1-git-send-email-maxg@mellanox.com>

Hi all,
this series is rebased above nvme-4.16 and Jianchao Wang's commit:
"nvme-pci: introduce RECONNECTING state to mark initializing procedure"
Actually there is a still missing part in this tree (but I tested it on
my own "stable" mixed kernel):
"nvme-rdma: fix concurrent reset and reconnect" from Sagi.

The first motivation for this series was fixing RDMA initiator that crushes in
case we fail during initial connect and start error recovery during initial
connection establishment.
This patchset also renames NVME_CTRL_RECONNECTING to NVME_CTRL_CONNECTING as
this state doesn't represent only a reconnection flow but also used for
initialization process.
I haven't dived into the FC code yet (I can do it myself, but I would like to
have some comments from FC guys as well), but I guess we need to change a thing
or two in fc-host too.

Max Gurtovoy (4):
  nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
  nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
  nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition
  nvme: delete NVME_CTRL_NEW --> NVME_CTRL_LIVE transition

 drivers/nvme/host/core.c    | 13 ++++++-------
 drivers/nvme/host/fabrics.h |  9 +++++----
 drivers/nvme/host/fc.c      | 14 +++++++-------
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  8 ++++----
 drivers/nvme/host/rdma.c    |  7 +++++--
 6 files changed, 28 insertions(+), 25 deletions(-)

-- 
1.8.3.1
