From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 11:19:26 +0800
Subject: [PATCH 2/4] nvmet: fix computation of io vector number
In-Reply-To: <20190326031928.9499-1-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
Message-ID: <20190326031928.9499-3-ming.lei@redhat.com>

Current file backed ns code uses request data length to compute
number of io vector.

This way is actually wrong, the warning in nvmet_file_execute_io()
may be triggered because the sg->offset isn't considered.

Given the sg list is only single-page for nvme target, simply use
the req->sg_cnt as number of io vector.

Reported-by: Yi Zhang <yi.zhang at redhat.com>
Fixes: d5eff33ee6f8("nvmet: add simple file backed ns support")
Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 3e43212d3c1c..d67a43832cb1 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -128,7 +128,7 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
-	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	ssize_t nr_bvec = req->sg_cnt;
 	struct sg_page_iter sg_pg_iter;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
@@ -225,7 +225,7 @@ static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
 
 static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
-	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	ssize_t nr_bvec = req->sg_cnt;
 
 	if (!req->sg_cnt || !nr_bvec) {
 		nvmet_req_complete(req, 0);
-- 
2.9.5
