From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:39 +0300
Subject: [PATCH 0/5] Small rework of nvme_init/uninit_ctrl
Message-ID: <1508324864-23087-1-git-send-email-sagi@grimberg.me>

The fact that nvme_free_ctrl cleans up after nvme_init_ctrl istead
of nvme_uninit_ctrl is causing us to rely on non-trivial ctrl
refcounting inside the fabrics ->create_ctrl handlers.

Instead, have nvme_uninit_ctrl cleanup nvme_init_ctrl and fixup
rdma and loop ->create_ctrl error sequence to be sane.

This will also help when we will consolidate more code to our
common nvme-core.

nvme-pci does not seem to rely on the former behavior and thus does
not need to be fixed afaict. It seems that nvme-fc always prefers to
use the ctrl refcount scheme to cleanup the controller (also from
->create_ctrl) but it always calls nvme_uninit_ctrl before the
final put so looks like it should work as well.

Tested rdma, loop and pci but didn't test fc.

Roy Shterman (5):
  nvme-core: Make nvme_init/uninit_ctrl setup/teardown symmetric
  nvme-rdma: rework create_ctrl error flow
  nvme-rdma: remove redundant check if the ctrl is in the ctrl when
    freeing it
  nvme-loop: rework create_ctrl error flow
  nvme-loop: remove redundant check if the ctrl is in the ctrl when
    freeing it

 drivers/nvme/host/core.c   | 11 +++++------
 drivers/nvme/host/rdma.c   | 28 +++++++++++-----------------
 drivers/nvme/target/loop.c | 30 ++++++++++++------------------
 3 files changed, 28 insertions(+), 41 deletions(-)

-- 
2.7.4
