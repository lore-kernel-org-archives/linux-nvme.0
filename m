From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu,  1 Aug 2019 17:45:09 -0600
Subject: [PATCH v7 10/14] nvmet-tcp: don't check data_len in
 nvmet_tcp_map_data()
In-Reply-To: <20190801234514.7941-1-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
Message-ID: <20190801234514.7941-11-logang@deltatee.com>

With passthru, the data_len is no longer guaranteed to be set
for all requests. Therefore, we should not check for it to be
non-zero. Instead check if the SGL length is zero and map
when appropriate.

None of the other transports check data_len which is verified
in core code.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 69b83fa0c76c..db5bc5f444c4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -320,7 +320,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
 	u32 len = le32_to_cpu(sgl->length);
 
-	if (!cmd->req.data_len)
+	if (!len)
 		return 0;
 
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
-- 
2.20.1
