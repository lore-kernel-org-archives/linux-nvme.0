From: joshi.k@samsung.com (kanchan)
Date: Fri, 10 May 2019 11:01:47 +0530
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
Message-ID: <031601d506f1$b2956d80$17c04880$@samsung.com>

Hi Jens & other maintainers,

If this patch-set is in fine shape now, can it please be considered for merge in near future?

Thanks,

-----Original Message-----
From: Kanchan Joshi [mailto:joshi.k@samsung.com] 
Sent: Thursday, April 25, 2019 4:50 PM
To: linux-kernel at vger.kernel.org; linux-block at vger.kernel.org; linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org; linux-ext4 at vger.kernel.org
Cc: prakash.v at samsung.com; anshul at samsung.com; Kanchan Joshi <joshi.k at samsung.com>
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint for Ext4 journal

V5 series, towards extending write-hint/streams infrastructure for kernel-components, and adding support for sending write-hint with Ext4/JBD2 journal.

Here is the history/changelog -

Changes since v4:
- Removed write-hint field from request. bi_write_hint in bio is used for
  merging checks now.
- Modified write-hint-to-stream conversion logic. Now, kernel hints are mapped
  to upper range of stream-ids, while user-hints continue to remain mapped to
  lower range of stream-ids.

Changes since v3:
- Correction in grouping related changes into patches
- Rectification in commit text at places

Changes since v2:
- Introduce API in block layer so that drivers can register stream info. Added
  new limit in request queue for this purpose.
- Block layer does the conversion from write-hint to stream-id.
- Stream feature is not disabled anymore if device reports less streams than
  a particular number (which was set as 4 earlier).
- Any write-hint beyond reported stream-count turn to 0.
- New macro "WRITE_LIFE_KERN_MIN" can be used as base by kernel mode components.

Changes since v1:
- introduce four more hints for in-kernel use, as recommended by Dave chinner
  & Jens axboe. This isolates kernel-mode hints from user-mode ones.
- remove mount-option to specify write-hint, as recommended by Jan kara &
  Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
  if device does not support stream.
- Removed code-redundancy for write_dirty_buffer (Jan kara's review comment)

V4 patch:
https://lkml.org/lkml/2019/4/17/870

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

 block/blk-core.c            | 29 ++++++++++++++++++++++++++++-
 block/blk-merge.c           |  4 ++--
 block/blk-settings.c        | 12 ++++++++++++
 drivers/nvme/host/core.c    | 23 ++++++-----------------
 fs/buffer.c                 | 18 ++++++++++++++++--
 fs/ext4/ext4_jbd2.h         |  1 +
 fs/ext4/super.c             |  2 ++
 fs/jbd2/commit.c            | 11 +++++++----
 fs/jbd2/journal.c           |  3 ++-
 fs/jbd2/revoke.c            |  3 ++-
 include/linux/blkdev.h      |  8 ++++++--
 include/linux/buffer_head.h |  3 +++
 include/linux/fs.h          |  2 ++
 include/linux/jbd2.h        |  8 ++++++++
 14 files changed, 97 insertions(+), 30 deletions(-)

--
2.7.4
