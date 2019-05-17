From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 May 2019 08:42:51 +0200
Subject: [PATCHv2 0/3]  nvme-fc: track state change failures
Message-ID: <20190517064254.95561-1-hare@suse.de>

Hi all,

this patchset improves logging in the nvme-fc driver if expcected
state changes fail, and fixes up one case where a failed state change
might lead to a stuck controller.

Changes to v1:
- simplified accessor function as suggested by Minwoo Im
- Included suggestions from James Smart

Hannes Reinecke (3):
  nvme: separate out nvme_ctrl_state_name()
  nvme-fc: track state change failures during reconnect
  nvme-fc: fail reconnect if state change fails

 drivers/nvme/host/core.c | 37 ++++++++++++++++++++++---------------
 drivers/nvme/host/fc.c   | 24 ++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 3 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.16.4
