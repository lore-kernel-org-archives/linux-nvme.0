From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 May 2019 20:21:09 -0700
Subject: [RFC PATCH 4/4] nvmet: set iopriority for each kiocb for file
In-Reply-To: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190516032109.13048-6-chaitanya.kulkarni@wdc.com>

This patch sets up the iopriority value before we call the respective
iter function.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..e05fdc9ae025 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -110,6 +110,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
+	iocb->ki_ioprio = req->port->ioprio;
 
 	return call_iter(iocb, &iter);
 }
-- 
2.17.0
