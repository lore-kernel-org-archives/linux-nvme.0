From: sagig@mellanox.com (Sagi Grimberg)
Date: Wed, 15 Jul 2015 16:19:13 +0300
Subject: [PATCH 0/3] Fixes for gapped scatters
Message-ID: <1436966356-8979-1-git-send-email-sagig@mellanox.com>

This small set addresses some issues with gapped scattered IOs. The
motivation of this is to have the iser driver take advantage of it too.

Patch 1 prevent gapped SG_IO if the driver can't handle gaps.
Patches 2,3 prevent gapped integrity payloads (for drivers that
support data integrity).

Review is welcome.

Christoph Hellwig (1):
  block: copy multi iovec user mappings if QUEUE_FLAG_SG_GAPS is set

Sagi Grimberg (2):
  block: Refuse request/bio merges with gaps in the integrity payload
  block: Refuse adding appending a gapped integrity page to a bio

 block/bio-integrity.c |  9 +++++++++
 block/blk-integrity.c | 32 +++++++++++++++++++++++++++-----
 block/blk-map.c       |  4 +++-
 3 files changed, 39 insertions(+), 6 deletions(-)

-- 
1.8.4.3
