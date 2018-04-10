From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:04 +0300
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
Message-ID: <1523380689-17151-1-git-send-email-maxg@mellanox.com>

Hi all,
I've been debugging the KA mechanism lately and found a lack of
coordination between the target and host implementations.

Johannes,
Sorry for reverting your commit - I'll use nvme_start_keep_alive
for my fix.

I've noticed that there is no clear definition in the NVMe spec
regarding the keep-alive mechanism association. IMO, it should be
a property of the admin queue and should be triggered as soon as
the admin queue configured successfuly.

Idan/Christoph/Sagi,
Any thoughts on that proposal ?
Anyway we should make the spec clear about it, otherwise we'll have
interoperability issue running different implementations/versions.

This patchset was tested using RDMA transport only:
I've created 20 subsystems, 5 namespaces per subsystem and exposed
all through 8 portals (total 160 ctrl's created) on 1 target.
I used 1 initiator (host) and connected successfuly.
Later on I've destroyed the target and caused a reconnection flow
in the initiator side.
Ater ~30-50 seconds, I've configured the target again but the initiator
couldn't reconnect to it (after many retries).
The reason for this was that the keep-alive timer expired at the target
side, caused ctrl fatal error and the io-queue connect failed to find
the ctrl. This loop never converged.

With the patches below, the test passed successfully after 1/2
reconnection attempts.

I was able to test it only with RDMA fabric, so it will be great to have
Tested-by from FC guys as well (also need to test loop).


Max Gurtovoy (5):
  Revert "nvme: unexport nvme_start_keep_alive"
  nvme: remove association between ctrl and keep-alive
  nvme-rdma: add keep-alive mechanism as admin_q property
  nvme-fc: add keep-alive mechanism as admin_q property
  nvme-loop: add keep-alive mechanism as admin_q property

 drivers/nvme/host/core.c   | 7 ++-----
 drivers/nvme/host/fc.c     | 5 +++++
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/rdma.c   | 5 +++--
 drivers/nvme/target/loop.c | 3 +++
 5 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.8.3.1
