From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 09 Jan 2019 21:00:57 +0530
Subject: [PATCH v2 0/4] Write-hint for FS journal
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
Message-ID: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>

Towards supporing write-hints/streams for filesystem journal.                   
                                                                                
Here is the v1 patch for background -                                           
https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2                        
                                                                                
Changes since v1:                                                               
- introduce four more hints for in-kernel use, as recommended by Dave chinner   
  & Jens axboe. This isolates kernel-mode hints from user-mode ones.            
- remove mount-option to specify write-hint, as recommended by Jan kara &       
  Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
  if device does not support stream.                                            
- Removed code-redundancy for write_dirty_buffer (Jan kara's review comment)


Kanchan Joshi (4):
  block: Increase count of supported write-hints
  fs: introduce four macros for in-kernel hints
  fs: introduce APIs to enable sending write-hint with buffer-head
  fs/ext4,jbd2: add support for passing write-hint with journal.

 fs/buffer.c                 | 18 ++++++++++++++++--
 fs/ext4/super.c             |  2 ++
 fs/jbd2/commit.c            | 11 +++++++----
 fs/jbd2/journal.c           |  3 ++-
 fs/jbd2/revoke.c            |  3 ++-
 include/linux/blkdev.h      |  5 ++++-
 include/linux/buffer_head.h |  3 +++
 include/linux/fs.h          |  5 +++++
 include/linux/jbd2.h        |  8 ++++++++
 9 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.7.4
