From: hare@suse.de (Hannes Reinecke)
Date: Mon, 20 May 2019 08:36:20 +0200
Subject: [PATCH 0/4v3] nvme-fc: track state change failures
Message-ID: <20190520063624.50338-1-hare@suse.de>

Hi all,

this patchset improves logging in the nvme-fc driver if expcected
state changes fail, and fixes up one case where a failed state change
might lead to a stuck controller.

Changes to v2:
- Tear down association on failure as suggested by James Smart
- Align nvme_fc_delete_association() with the exit path
Changes to v1:
- simplified accessor function as suggested by Minwoo Im
- Included suggestions from James Smart

Hannes Reinecke (4):
  nvme: separate out nvme_ctrl_state_name()
  nvme-fc: track state change failures during reconnect
  nvme-fc: fail reconnect if state change fails
  nvme-fc: align nvme_fc_delete_association() with exit path

 drivers/nvme/host/core.c | 37 ++++++++++++++++++++++---------------
 drivers/nvme/host/fc.c   | 38 +++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |  1 +
 3 files changed, 54 insertions(+), 22 deletions(-)

-- 
2.16.4
