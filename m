From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 19 Jun 2017 11:05:01 -0600
Subject: [PATCH 8/9] btrfs: add support for passing in write hints for
 buffered writes
In-Reply-To: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
Message-ID: <1497891902-25737-9-git-send-email-axboe@kernel.dk>

Reviewed-by: Andreas Dilger <adilger at dilger.ca>
Signed-off-by: Chris Mason <clm at fb.com>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19eedf2e630b..3e57cfaa6dd6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2830,6 +2830,7 @@ static int submit_extent_page(int op, int op_flags, struct extent_io_tree *tree,
 	bio_add_page(bio, page, page_size, offset);
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = tree;
+	op_flags |= write_hint_to_opf(inode_write_hint(page->mapping->host));
 	bio_set_op_attrs(bio, op, op_flags);
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
-- 
2.7.4
