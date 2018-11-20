From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 19:00:11 -0800
Subject: [PATCH v2 09/14] nvmet: allow configfs tcp trtype configuration
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Message-ID: <20181120030019.31738-11-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 drivers/nvme/target/configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index db2cb64be7ba..618bbd006544 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -34,6 +34,7 @@ static const struct nvmet_transport_name {
 } nvmet_transport_names[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
+	{ NVMF_TRTYPE_TCP,	"tcp" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
 
-- 
2.17.1
