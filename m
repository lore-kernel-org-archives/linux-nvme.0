From: jalee@purestorage.com (Jaesoo Lee)
Date: Mon, 3 Jun 2019 16:42:28 -0700
Subject: [PATCH v2] nvme: Fix u32 overflow in the number of namespace list
 calculation
In-Reply-To: <1559604301-14042-1-git-send-email-jalee@purestorage.com>
References: <1559604301-14042-1-git-send-email-jalee@purestorage.com>
Message-ID: <CAJX3CtgdrbaPhFPnR13CT9mAQ8yVRyPFMjbFz01gcNz6G=2T_g@mail.gmail.com>

The Number of Namespaces (nn) field in the identify controller data structure is
defined as u32 and the maximum allowed value in NVMe specification is
0xFFFFFFFEUL. This change fixes the possible overflow of the DIV_ROUND_UP()
operation used in nvme_scan_ns_list() by casting the nn to u64.

Signed-off-by: Jaesoo Lee <jalee at purestorage.com>
---
Changes in v2:
  - use DIV_ROUND_UP_ULL for 32-bit system

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c43e12..4c4633b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3373,7 +3373,8 @@ static int nvme_scan_ns_list(struct nvme_ctrl
*ctrl, unsigned nn)
 {
        struct nvme_ns *ns;
        __le32 *ns_list;
-       unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
+       unsigned i, j, nsid, prev = 0;
+       unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
        int ret = 0;

        ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
--
2.7.4
