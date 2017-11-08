From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Nov 2017 12:00:29 +0200
Subject: [PATCH 2/3] nvmet: remove redundant memset if failed to get_smart_log
 failed
In-Reply-To: <20171108100030.25745-1-sagi@grimberg.me>
References: <20171108100030.25745-1-sagi@grimberg.me>
Message-ID: <20171108100030.25745-3-sagi@grimberg.me>

We already allocated the buffer with kzalloc.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9b02a6bd58d6..871c2e5e17a0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -144,10 +144,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		}
 		smart_log = buf;
 		status = nvmet_get_smart_log(req, smart_log);
-		if (status) {
-			memset(buf, '\0', data_len);
+		if (status)
 			goto err;
-		}
 		break;
 	case NVME_LOG_FW_SLOT:
 		/*
-- 
2.14.1
