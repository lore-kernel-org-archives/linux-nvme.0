From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 11:19:27 +0800
Subject: [PATCH 3/4] nvmet: fix computation of bvec->bv_len
In-Reply-To: <20190326031928.9499-1-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
Message-ID: <20190326031928.9499-4-ming.lei@redhat.com>

PAGE_SIZE - sg->offset may be bigger than sg->length, so we have
to cap it.

Reported-by: Yi Zhang <yi.zhang at redhat.com>
Fixes: d5eff33ee6f8("nvmet: add simple file backed ns support")
Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index d67a43832cb1..149e17e699e5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -79,7 +79,8 @@ static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
 {
 	bv->bv_page = sg_page_iter_page(iter);
 	bv->bv_offset = iter->sg->offset;
-	bv->bv_len = PAGE_SIZE - iter->sg->offset;
+	bv->bv_len = min_t(unsigned, PAGE_SIZE - iter->sg->offset,
+			   iter->sg->length);
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
-- 
2.9.5
