From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 29 Jan 2019 00:29:21 +0000
Subject: [PATCHv2] nvme: Block NS list changes while handling command
 effects
In-Reply-To: <20190128164607.15370-1-keith.busch@intel.com>
References: <20190128164607.15370-1-keith.busch@intel.com>
Message-ID: <BYAPR04MB45026F4EA92EB71C4362384786970@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>



From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Keith Busch <keith.busch@intel.com>
Sent: Monday, January 28, 2019 8:46 AM
To: Christoph Hellwig; Sagi Grimberg; linux-nvme at lists.infradead.org
Cc: Keith Busch; Wen Xiong
Subject: [PATCHv2] nvme: Block NS list changes while handling command effects
? 
 
If a controller supports the NS Change Notification, the namespace
scan_work is automatically triggered after attaching a new namespace.

Occasionally the namespace scan_work may append the new namespace to the
list before the admin command effects handling is completed. The effects
handling unfreezes namespaces, but if it unfreezes the newly attached
namespace, its request_queue freeze depth will be off and we'll hit the
warning in blk_mq_unfreeze_queue().

On the next namespace add, we will fail to freeze that queue due to the
previous bad accounting and deadlock waiting for frozen.

Fix that by preventing scan work from altering the namespace list while
command effects handling needs to pair freeze with unfreeze.

Reported-by: Wen Xiong <wenxiong at us.ibm.com>
Tested-by: Wen Xiong <wenxiong at us.ibm.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

? Added received Tested-by.

? Changelog improvements.

?drivers/nvme/host/core.c | 8 +++++++-
?drivers/nvme/host/nvme.h | 1 +
?2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 150e49723c15..6a9dd68c0f4f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1253,6 +1253,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
????????? * effects say only one namespace is affected.
????????? */
???????? if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+?????????????? mutex_lock(&ctrl->scan_lock);
???????????????? nvme_start_freeze(ctrl);
???????????????? nvme_wait_freeze(ctrl);
???????? }
@@ -1281,8 +1282,10 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
????????? */
???????? if (effects & NVME_CMD_EFFECTS_LBCC)
???????????????? nvme_update_formats(ctrl);
-?????? if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
+?????? if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
???????????????? nvme_unfreeze(ctrl);
+?????????????? mutex_unlock(&ctrl->scan_lock);
+?????? }
???????? if (effects & NVME_CMD_EFFECTS_CCC)
???????????????? nvme_init_identify(ctrl);
???????? if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
@@ -3401,6 +3404,7 @@ static void nvme_scan_work(struct work_struct *work)
???????? if (nvme_identify_ctrl(ctrl, &id))
???????????????? return;
?
+?????? mutex_lock(&ctrl->scan_lock);
???????? nn = le32_to_cpu(id->nn);
???????? if (ctrl->vs >= NVME_VS(1, 1, 0) &&
???????????? !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
@@ -3409,6 +3413,7 @@ static void nvme_scan_work(struct work_struct *work)
???????? }
???????? nvme_scan_ns_sequential(ctrl, nn);
?out_free_id:
+?????? mutex_unlock(&ctrl->scan_lock);
???????? kfree(id);
???????? down_write(&ctrl->namespaces_rwsem);
???????? list_sort(NULL, &ctrl->namespaces, ns_cmp);
@@ -3652,6 +3657,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
?
???????? ctrl->state = NVME_CTRL_NEW;
???????? spin_lock_init(&ctrl->lock);
+?????? mutex_init(&ctrl->scan_lock);
???????? INIT_LIST_HEAD(&ctrl->namespaces);
???????? init_rwsem(&ctrl->namespaces_rwsem);
???????? ctrl->dev = dev;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab961bdeea89..c4a1bb41abf0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -154,6 +154,7 @@ struct nvme_ctrl {
???????? enum nvme_ctrl_state state;
???????? bool identified;
???????? spinlock_t lock;
+?????? struct mutex scan_lock;
???????? const struct nvme_ctrl_ops *ops;
???????? struct request_queue *admin_q;
???????? struct request_queue *connect_q;
-- 
2.14.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
