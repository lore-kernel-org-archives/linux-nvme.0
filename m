From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 8 Oct 2018 21:45:53 +0000
Subject: [PATCH 04/16] nvme-core: Complain if nvme_init_identify() fails
In-Reply-To: <20181008212854.68310-5-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>,
 <20181008212854.68310-5-bvanassche@acm.org>
Message-ID: <BYAPR04MB4502C2105E1B38F61562294386E60@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>






From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Monday, October 8, 2018 2:28 PM
To: Keith Busch
Cc: Bart Van Assche; Christoph Hellwig; linux-nvme at lists.infradead.org; Sagi Grimberg
Subject: [PATCH 04/16] nvme-core: Complain if nvme_init_identify() fails
? 
 
This patch avoids that Coverity complains that some but not all callers of
nvme_init_identify() check the return value of that function. See also
Coverity ID 1423964.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
?drivers/nvme/host/core.c | 2 +-
?1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3746fe49c382..2ce3e9d15618 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1213,7 +1213,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
???????? if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
???????????????? nvme_unfreeze(ctrl);
???????? if (effects & NVME_CMD_EFFECTS_CCC)
-?????????????? nvme_init_identify(ctrl);
+?????????????? WARN_ON_ONCE(nvme_init_identify(ctrl) < 0);
???????? if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
???????????????? nvme_queue_scan(ctrl);
?}
-- 
2.19.0.605.g01d371f741-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
