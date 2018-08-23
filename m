From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 22 Aug 2018 19:58:45 -0700
Subject: [PATCH] nvmet: remove unreachable code
Message-ID: <20180823025845.13150-1-chaitanya.kulkarni@wdc.com>

Get rid of the unreachable code in the nvmet_parse_discovery_cmd().
Keep the error message identical to the admin-cmd.c and io-cmd*.c

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/discovery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eae29f493a07..d1954f4ca28d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -219,12 +219,10 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	default:
-		pr_err("unsupported cmd %d\n", cmd->common.opcode);
+		pr_err("unhandled cmd %d\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-	pr_err("unhandled cmd %d\n", cmd->common.opcode);
-	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
 
 int __init nvmet_init_discovery(void)
-- 
2.17.0
