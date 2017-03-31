From: hch@lst.de (Christoph Hellwig)
Date: Fri, 31 Mar 2017 17:00:08 +0200
Subject: [PATCH 4/4] nvmet: fix byte swap in nvmet_parse_io_cmd
In-Reply-To: <20170331150008.16034-1-hch@lst.de>
References: <20170331150008.16034-1-hch@lst.de>
Message-ID: <20170331150008.16034-5-hch@lst.de>

We need to do arithmetics after byte swapping, not before.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/io-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index e37acd77b5fe..6b0baa9caab9 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -230,7 +230,7 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_execute_dsm;
-		req->data_len = le32_to_cpu(cmd->dsm.nr + 1) *
+		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
-- 
2.11.0
