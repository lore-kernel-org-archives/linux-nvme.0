From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:31:12 -0800
Subject: [PATCH 0/3 rfc] Support discovery log change events
Message-ID: <20190223023117.20517-1-sagi@grimberg.me>

We want to be able to support discovery log change events automatically
without user intervention.

The definition of discovery log change events applies on "persistent" long
lived controllers, so first we need to have discovery controllers to stay
for a long time and accept kato value.

Then when we do happen to get a discovery log change event on the persistent
discovery controller, we simply fire a udev event to user-space to re-query
the discovery log page and connect to new subsystems in the fabric.

Review and feedback is welcome.

Sagi Grimberg (3):
  nvme-fabrics: allow discovery subsystems accept a kato
  nvme: enable aen also for discovery controllers
  nvme: fire discovery log page change events to userspace

 drivers/nvme/host/core.c    | 37 ++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/fabrics.c | 12 ++----------
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.17.1
