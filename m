From: sagig@mellanox.com (Sagi Grimberg)
Date: Sun, 10 Jan 2016 10:59:46 +0200
Subject: [PATCH v1 0/3] Move active IO termination to the core
Message-ID: <1452416389-19664-1-git-send-email-sagig@mellanox.com>

This patchset adds helper to active IO termination to the nvme
core based on the pci nvme_clear_queues() functionality. This
is needed for live shutdowns and resets during live IO and it's
not pci specific and will be needed for other transports as well.

This patchset applies on top of Keith's "NVMe fixes and updates for 4.5"
patchset.

Changes from v0:
- Removed the nvme core helpers for IO termination and have pci
  use blk-mq helper directly
- Rebased on top of Keith and Christoph's patches

Sagi Grimberg (3):
  blk-mq: Export tagset iter function
  nvme: Use blk-mq helper for IO termination
  blk-mq: Make blk_mq_all_tag_busy_iter static

 block/blk-mq-tag.c      | 15 ++++++++++++---
 drivers/nvme/host/pci.c | 19 +++++--------------
 include/linux/blk-mq.h  |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

-- 
1.8.4.3
