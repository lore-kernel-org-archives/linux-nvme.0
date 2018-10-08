From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 8 Oct 2018 21:57:42 +0000
Subject: [PATCH 14/16] nvmet: Avoid integer overflow in the discard code
In-Reply-To: <20181008212854.68310-15-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>,
 <20181008212854.68310-15-bvanassche@acm.org>
Message-ID: <BYAPR04MB45026880A2FA5A2BFC77955C86E60@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

From: Bart Van Assche <bvanassche@acm.org>
Sent: Monday, October 8, 2018 2:28 PM
To: Keith Busch
Cc: Christoph Hellwig; Sagi Grimberg; linux-nvme at lists.infradead.org; Bart Van Assche; Chaitanya Kulkarni
Subject: [PATCH 14/16] nvmet: Avoid integer overflow in the discard code
? 
 
Although I'm not sure whether it is a good idea to support large discard
commands, I think integer overflow for discard ranges larger than 4 GB
should be avoided. This patch avoids that smatch reports the following:

drivers/nvme/target/io-cmd-file.c:249:1 nvmet_file_execute_discard() warn: should '((range.nlb)) << req->ns->blksize_shift' be a 64 bit type?

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
?drivers/nvme/target/io-cmd-file.c | 3 ++-
?1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 81a9dc5290a8..39d972e2595f 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -246,7 +246,8 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
???????????????????????? break;
?
???????????????? offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-?????????????? len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
+?????????????? len = le32_to_cpu(range.nlb);
+?????????????? len <<= req->ns->blksize_shift;
???????????????? if (offset + len > req->ns->size) {
???????????????????????? ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
???????????????????????? break;
-- 
2.19.0.605.g01d371f741-goog

    
