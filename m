From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 29 Mar 2019 13:23:45 +0530
Subject: [PATCH v3 0/7] Extend write-hint for in-kernel use
References: <CGME20190329075737epcas1p4f32cad26279c1146982a6c91b3378eab@epcas1p4.samsung.com>
Message-ID: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>

Towards extending write-hints/streams infrastucture so that file-systems
and other kernel-mode components can use exclusive hints. This patchset also
modifies Ext4/JBD2 to use new in-kernel, write-hint with journal. 

Here is the history and changelog -

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

V2 patch:
https://patchwork.kernel.org/cover/10754405/
V1 patch:
https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2  

Note: I am sorry about the fact this patchset is against 5.0.0-rc4, rather than 
against linux-next.

Kanchan Joshi (7):
  block: extend stream count for in-kernel use
  block: introduce API to register stream information with block layer
  block: add write-hint to stream-id conversion
  nvme: register stream info with block layer
  fs: introduce APIs to enable sending write-hint with buffer-head
  fs: introduce write-hint start point for in-kernel hints
  fs/ext4,jbd2: add support for passing write-hint with journal

 block/blk-core.c            | 20 ++++++++++++++++++++
 block/blk-settings.c        | 12 ++++++++++++
 drivers/nvme/host/core.c    | 19 ++++++-------------
 fs/buffer.c                 | 18 ++++++++++++++++--
 fs/ext4/ext4_jbd2.h         |  1 +
 fs/ext4/super.c             |  2 ++
 fs/jbd2/commit.c            | 11 +++++++----
 fs/jbd2/journal.c           |  3 ++-
 fs/jbd2/revoke.c            |  3 ++-
 include/linux/blkdev.h      |  9 +++++++--
 include/linux/buffer_head.h |  3 +++
 include/linux/fs.h          |  2 ++
 include/linux/jbd2.h        |  8 ++++++++
 13 files changed, 88 insertions(+), 23 deletions(-)

-- 
2.7.4
