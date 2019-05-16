From: hare@suse.de (Hannes Reinecke)
Date: Thu, 16 May 2019 10:37:37 +0200
Subject: [PATCH 0/3] nvme-fc: track state change failures
Message-ID: <20190516083740.95894-1-hare@suse.de>

Hi all,

this patchset improves logging in the nvme-fc driver if expcected
state changes fail, and fixes up one case where a failed state change
might lead to a stuck controller.

Hannes Reinecke (3):
  nvme: separate out nvme_ctrl_state_name()
  nvme-fc: track state change failures during reconnect
  nvme-fc: fail reconnect if state change fails

 drivers/nvme/host/core.c | 36 +++++++++++++++++++++++-------------
 drivers/nvme/host/fc.c   | 23 +++++++++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 3 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.16.4
