From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 29 Mar 2019 13:23:50 +0530
Subject: [PATCH v3 5/7] fs: introduce APIs to enable sending write-hint with
 buffer-head
In-Reply-To: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075755epcas2p2d2670db217ae3519d2c4b93d5e3749d1@epcas2p2.samsung.com>
Message-ID: <1553846032-4451-6-git-send-email-joshi.k@samsung.com>

submit_bh and write_dirty_buffer do not take write-hint as parameter.
This introduces variants which do, and pass write-hint down.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 fs/buffer.c                 | 18 ++++++++++++++++--
 include/linux/buffer_head.h |  3 +++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 52d024b..19cf910 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3094,6 +3094,13 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
+int submit_bh_write_hint(int op, int op_flags, struct buffer_head *bh,
+			 enum rw_hint hint)
+{
+	return submit_bh_wbc(op, op_flags, bh, hint, NULL);
+}
+EXPORT_SYMBOL(submit_bh_write_hint);
+
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
@@ -3151,6 +3158,13 @@ EXPORT_SYMBOL(ll_rw_block);
 
 void write_dirty_buffer(struct buffer_head *bh, int op_flags)
 {
+	write_dirty_buffer_with_hint(bh, op_flags, 0);
+}
+EXPORT_SYMBOL(write_dirty_buffer);
+
+void write_dirty_buffer_with_hint(struct buffer_head *bh, int op_flags,
+				   enum rw_hint hint)
+{
 	lock_buffer(bh);
 	if (!test_clear_buffer_dirty(bh)) {
 		unlock_buffer(bh);
@@ -3158,9 +3172,9 @@ void write_dirty_buffer(struct buffer_head *bh, int op_flags)
 	}
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
-	submit_bh(REQ_OP_WRITE, op_flags, bh);
+	submit_bh_wbc(REQ_OP_WRITE, op_flags, bh, hint, NULL);
 }
-EXPORT_SYMBOL(write_dirty_buffer);
+EXPORT_SYMBOL(write_dirty_buffer_with_hint);
 
 /*
  * For a data-integrity writeout, we need to wait upon any in-progress I/O
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7b73ef7..3d682ac 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -200,7 +200,10 @@ void ll_rw_block(int, int, int, struct buffer_head * bh[]);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
 void write_dirty_buffer(struct buffer_head *bh, int op_flags);
+void write_dirty_buffer_with_hint(struct buffer_head *bh, int op_flags,
+				   enum rw_hint hint);
 int submit_bh(int, int, struct buffer_head *);
+int submit_bh_write_hint(int, int, struct buffer_head *, enum rw_hint hint);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
2.7.4
