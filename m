From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 17 Apr 2019 23:19:59 +0530
Subject: [PATCH v4 0/7] Extend write-hint/stream infrastructure
References: <CGME20190417175347epcas2p41e4240ab83b46c9f07d237fc9494903a@epcas2p4.samsung.com>
Message-ID: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>

V4 series, towards extending write-hint/streams infrastucture so that file-systems
and other kernel-mode components can use write-hints which are separate from 
user-space ones. Also this introduces support for sending write-hint with 
Ext4/JBD2 journal.

Here is the changelog/history -

Changes since v3:                                                               
- Correction in grouping related changes into patches
- Rectification in commit text at places

Changes since v2:                                                               
- Introduce API in block layer so that drivers can register stream info. Added 
new limit in request queue for this purpose.
- Block layer does the conversion from write-hint to stream-id. 
- Any write-hint beyond registered limit turn to 0.
- New macro "WRITE_LIFE_KERN_MIN" can be used as base by kernel mode components.

Changes since v1:                                                               
- introduce four more hints for in-kernel use, as recommended by Dave chinner   
  & Jens axboe. This isolates kernel-mode hints from user-mode ones.            
- remove mount-option to specify write-hint, as recommended by Jan kara &       
  Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
  if device does not support stream.                                            
- Removed code-redundancy for write_dirty_buffer (Jan kara's review comment) 

V3 patch:
https://marc.info/?l=linux-block&m=155384631909082&w=2

V2 patch:
https://patchwork.kernel.org/cover/10754405/

V1 patch:
https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2  

Kanchan Joshi (7):
  fs: introduce write-hint start point for in-kernel hints
  block: increase stream count for in-kernel use
  block: introduce API to register stream information with block-layer
  block: introduce write-hint to stream-id conversion
  nvme: register stream info with block layer
  fs: introduce APIs to enable passing write-hint with buffer-head
  fs/ext4,jbd2: add support for sending write-hint with journal

 block/blk-core.c            | 20 ++++++++++++++++++++
 block/blk-settings.c        | 12 ++++++++++++
 drivers/nvme/host/core.c    | 23 ++++++-----------------
 fs/buffer.c                 | 18 ++++++++++++++++--
 fs/ext4/ext4_jbd2.h         |  1 +
 fs/ext4/super.c             |  2 ++
 fs/jbd2/commit.c            | 11 +++++++----
 fs/jbd2/journal.c           |  3 ++-
 fs/jbd2/revoke.c            |  3 ++-
 include/linux/blkdev.h      |  7 ++++++-
 include/linux/buffer_head.h |  3 +++
 include/linux/fs.h          |  2 ++
 include/linux/jbd2.h        |  8 ++++++++
 13 files changed, 87 insertions(+), 26 deletions(-)

-- 
2.7.4
