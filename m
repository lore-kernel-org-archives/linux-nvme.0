From: sagig@mellanox.com (Sagi Grimberg)
Date: Wed,  9 Mar 2016 19:23:01 +0200
Subject: [PATCH v2 for-4.6 0/3] Provide better active I/O termination handlers
Message-ID: <1457544184-2838-1-git-send-email-sagig@mellanox.com>

This patchset adds helper to active IO termination to block layer
based on the pci nvme_clear_queues() functionality. This is needed
for live shutdowns and resets during live IO and it's not nvme/pci
specific and will be needed for other transports as well.

This patchset applies on top of "for-4.6-drivers" patchset.

Changes from v1:
- rebase on top of for-4.6-drivers (small fuzz)
- incorporate a fix from hch to carefully check for valid tagsets

Changes from v0:
- Removed the nvme core helpers for IO termination and have pci
  use blk-mq helper directly
- Rebased on top of Keith and Christoph's patches

Sagi Grimberg (3):
  blk-mq: Export tagset iter function
  nvme: Use blk-mq helper for IO termination
  blk-mq: Make blk_mq_all_tag_busy_iter static

 block/blk-mq-tag.c      | 17 ++++++++++++++---
 drivers/nvme/host/pci.c | 19 +++++--------------
 include/linux/blk-mq.h  |  4 ++--
 3 files changed, 21 insertions(+), 19 deletions(-)

-- 
1.8.4.3
