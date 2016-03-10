From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 10 Mar 2016 13:58:45 +0200
Subject: [PATCH v3 for-4.6 0/4] Provide better active I/O termination handlers
Message-ID: <1457611129-8036-1-git-send-email-sagig@mellanox.com>

This patchset adds helper to active IO termination to block layer
based on the pci nvme_clear_queues() functionality. This is needed
for live shutdowns and resets during live IO and it's not nvme/pci
specific and will be needed for other transports as well.

This patchset applies on top of "for-4.6-drivers" patchset.

Changes from v2:
- Added mtip32xxx conversion from Keith

Changes from v1:
- rebase on top of for-4.6-drivers (small fuzz)
- incorporate a fix from hch to carefully check for valid tagsets

Changes from v0:
- Removed the nvme core helpers for IO termination and have pci
  use blk-mq helper directly
- Rebased on top of Keith and Christoph's patches

Keith Busch (1):
  mtip32xx: Convert to use blk_mq_tagset_busy_iter

Sagi Grimberg (3):
  blk-mq: Export tagset iter function
  nvme: Use blk-mq helper for IO termination
  blk-mq: Make blk_mq_all_tag_busy_iter static

 block/blk-mq-tag.c                | 17 ++++++++++++++---
 drivers/block/mtip32xx/mtip32xx.c |  6 +++---
 drivers/nvme/host/pci.c           | 19 +++++--------------
 include/linux/blk-mq.h            |  4 ++--
 4 files changed, 24 insertions(+), 22 deletions(-)

-- 
1.8.4.3
