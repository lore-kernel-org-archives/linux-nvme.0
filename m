From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 11:20:49 +0300
Subject: [PATCH v2 0/3] Allow ib_clients to nullify .add but still get .remove
 events reliably
Message-ID: <1498983652-18250-1-git-send-email-sagi@grimberg.me>

Some ULPs are just interested in device removal notification with no specific
association because they work over RDMA_CM so no need for detecting appearance
of the devices. That wasn't the because the corresponding ib_client_data
was never added to the device clients list when the ib_client registers,
Patch 1 fixes it. Patches 2-3 just removes the empty .add callout nvme(t)-rdma set.

Changes from v1:
- reword patch 1 change log title
- collected review tags

Note that this will create a conflict with jens's for-4.13 which we added
ib_client registration to nvmet-rdma.

Sagi Grimberg (3):
  RDMA/core: make ib_device.add method optional
  nvme-rdma: remove redundant empty device add callout
  nvmet-rdma: remove redundant empty device add callout

 drivers/infiniband/core/device.c | 4 ++--
 drivers/nvme/host/rdma.c         | 5 -----
 drivers/nvme/target/rdma.c       | 5 -----
 3 files changed, 2 insertions(+), 12 deletions(-)

-- 
2.7.4
