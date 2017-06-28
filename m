From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 13:05:35 +0300
Subject: [PATCH 0/3] Allow ib_clients to nullify .add but still get .remove
 events reliably
Message-ID: <1498644338-19719-1-git-send-email-sagi@grimberg.me>

Some ULPs are just interested in device removal notification with no specific
association because they work over RDMA_CM so no need for detecting appearance
of the devices. That wasn't the because the corresponding ib_client_data
was never added to the device clients list when the ib_client registers,
Patch 1 fixes it. Patches 2-3 just removes the empty .add callout nvme(t)-rdma set.

Sagi Grimberg (3):
  RDMA/device: Fix device removal notification when ib_clients set .add
    callout to NULL
  nvme-rdma: remove redundant empty device add callout
  nvmet-rdma: remove redundant empty device add callout

 drivers/infiniband/core/device.c | 4 ++--
 drivers/nvme/host/rdma.c         | 5 -----
 drivers/nvme/target/rdma.c       | 5 -----
 3 files changed, 2 insertions(+), 12 deletions(-)

-- 
2.7.4
