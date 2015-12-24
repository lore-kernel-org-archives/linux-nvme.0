From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 24 Dec 2015 13:23:57 +0200
Subject: [PATCH RFC 0/4] Move active IO termination to the core
Message-ID: <1450956241-4626-1-git-send-email-sagig@mellanox.com>

This patchset adds helper to active IO termination to the nvme
core based on the pci nvme_clear_queues() functionality. This
is needed for live shutdowns and resets during live IO and it's
not pci specific and will be needed for other transports as well.

Sagi Grimberg (4):
  blk-mq: Export tagset iter function
  nvme: Add a controller reference to the admin tagset
  nvme: Move IO termination code to the core
  blk-mq: Make blk_mq_all_tag_busy_iter static

 block/blk-mq-tag.c         |   15 ++++++++++++---
 drivers/nvme/host/core.c   |   14 ++++++++++++++
 drivers/nvme/host/nvme.h   |    5 +++++
 drivers/nvme/host/pci.c    |   23 ++++++++---------------
 drivers/nvme/host/rdma.c   |    2 ++
 drivers/nvme/target/loop.c |    2 ++
 include/linux/blk-mq.h     |    4 ++--
 7 files changed, 45 insertions(+), 20 deletions(-)
