From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 11:02:08 -0700
Subject: [PATCH v2 0/3] Support discovery log change events
Message-ID: <20190712180211.26333-1-sagi@grimberg.me>

We want to be able to support discovery log change events automatically
without user intervention.

The definition of discovery log change events applies on "persistent" long
lived controllers, so first we need to have discovery controllers to stay
for a long time and accept kato value.

Then when we do happen to get a discovery log change event on the persistent
discovery controller, we simply fire a udev event to user-space to re-query
the discovery log page and connect to new subsystems in the fabric.

This works with James' latest nvme-cli patches.

Changes from v1:
- rebase to nvme-5.3
- pass none if trsvcid is uninitialized
- pass NVME_CTRL_NAME instead of NVME_CTRL_INSTANCE

Sagi Grimberg (3):
  nvme-fabrics: allow discovery subsystems accept a kato
  nvme: enable aen also for discovery controllers
  nvme: fire discovery log page change events to userspace

 drivers/nvme/host/core.c    | 39 ++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/fabrics.c | 12 ++----------
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.17.1
