From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 7 Aug 2018 22:49:47 +0000
Subject: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
In-Reply-To: <20180807204239.24907-1-tal.shorer@gmail.com>
References: <20180807204239.24907-1-tal.shorer@gmail.com>
Message-ID: <BYAPR04MB4502CA560886C1025B15A62B86270@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good to me.

Just 's/supplics/supplies/'.

Without looking into the entire code, If we can change the type of max_reconnect and nr_reconnects to unsigned int then we can just get away with the one comparison (ctrl->nr_reconnects < ctrl->opts->max_reconnects).

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Tal Shorer <tal.shorer@gmail.com>
Sent: Tuesday, August 7, 2018 1:42 PM
To: keith.busch at intel.com; axboe at fb.com; hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-kernel at vger.kernel.org
Cc: Tal Shorer
Subject: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
? 
 
When the user supplics ctrl_loss_tmo < 0, we warn them that this will
cause the fabrics layer to attempt reconnection forever.
However, in reality the fabrics layer never attempts to reconnect
because the condition to test whether we should reconnect is backwards
in this case.

Signed-off-by: Tal Shorer <tal.shorer at gmail.com>
---
?drivers/nvme/host/fabrics.c | 2 +-
?1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f7efe5a58cc7..206d63cb1afc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
?
?bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
?{
-?????? if (ctrl->opts->max_reconnects != -1 &&
+?????? if (ctrl->opts->max_reconnects == -1 ||
???????????? ctrl->nr_reconnects < ctrl->opts->max_reconnects)
???????????????? return true;
?
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
