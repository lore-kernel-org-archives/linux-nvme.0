From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:45 -0800
Subject: [PATCH V2 09/12] nvmet: add error log support for rdma backend
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-10-chaitanya.kulkarni@wdc.com>

This patch adds the support to maintain the error log page for rdma
transport, we mainly focus here on the NVME_INVALID_FIELD errors.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 932242e27b03..b15c6915fb40 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -629,8 +629,11 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	u64 off = le64_to_cpu(sgl->addr);
 	u32 len = le32_to_cpu(sgl->length);
 
-	if (!nvme_is_write(rsp->req.cmd))
+	if (!nvme_is_write(rsp->req.cmd)) {
+		rsp->req.error_loc =
+			offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
 
 	if (off + len > rsp->queue->dev->inline_data_size) {
 		pr_err("invalid inline data offset!\n");
@@ -695,6 +698,8 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			return nvmet_rdma_map_sgl_inline(rsp);
 		default:
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
+			rsp->req.error_loc =
+				offsetof(struct nvme_common_command, dptr);
 			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		}
 	case NVME_KEY_SGL_FMT_DATA_DESC:
@@ -705,10 +710,13 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			return nvmet_rdma_map_sgl_keyed(rsp, sgl, false);
 		default:
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
+			rsp->req.error_loc =
+				offsetof(struct nvme_common_command, dptr);
 			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		}
 	default:
 		pr_err("invalid SGL type: %#x\n", sgl->type);
+		rsp->req.error_loc = offsetof(struct nvme_common_command, dptr);
 		return NVME_SC_SGL_INVALID_TYPE | NVME_SC_DNR;
 	}
 }
-- 
2.17.0
