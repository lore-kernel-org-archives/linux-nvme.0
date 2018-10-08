From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 8 Oct 2018 22:06:27 +0000
Subject: [PATCH 13/16] nvmet: Use strlcpy() instead of strcpy()
In-Reply-To: <20181008212854.68310-14-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>,
 <20181008212854.68310-14-bvanassche@acm.org>
Message-ID: <BYAPR04MB4502DD8E0CA03A2D04F74C6586E60@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>



From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Monday, October 8, 2018 2:28 PM
To: Keith Busch
Cc: Bart Van Assche; Christoph Hellwig; linux-nvme at lists.infradead.org; Sagi Grimberg
Subject: [PATCH 13/16] nvmet: Use strlcpy() instead of strcpy()
? 
 
Although the code modified by this patch looks fine to me, this patch avoids
that Coverity reports the following complaint (ID 1364971 and ID 1364973):
"You might overrun the 256-character fixed-size string id->subnqn".

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
?drivers/nvme/target/admin-cmd.c | 2 +-
?drivers/nvme/target/discovery.c | 2 +-
?2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7a45f4477679..1179f6314323 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -353,7 +353,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
???????? if (req->port->inline_data_size)
???????????????? id->sgls |= cpu_to_le32(1 << 20);
?
-?????? strcpy(id->subnqn, ctrl->subsys->subsysnqn);
+?????? strlcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
?
???????? /* Max command capsule size is sqe + single page of in-capsule data */
???????? id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 08e7e284655c..ff52ab84d0e3 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -174,7 +174,7 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
???????? if (req->port->inline_data_size)
???????????????? id->sgls |= cpu_to_le32(1 << 20);
?
-?????? strcpy(id->subnqn, ctrl->subsys->subsysnqn);
+?????? strlcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
?
???????? status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
?
-- 
2.19.0.605.g01d371f741-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
