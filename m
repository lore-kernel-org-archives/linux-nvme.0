From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 28 Jul 2017 09:58:34 +0200
Subject: [PATCH 1/2] nvme: Fix nvme reset command timeout handling
In-Reply-To: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170728075834.GC4043@linux-x5ow.site>

On Thu, Jul 27, 2017@12:58:40PM -0400, Keith Busch wrote:
>  static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> @@ -1856,17 +1857,25 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  
>  	kfree(id);
>  
> +	if (ret < 0)
> +		return ret;
> +

This is a bit confusing IMHO, how about this?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b77cfe5aa1e..71a97db3ce91 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1835,13 +1835,16 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * In fabrics we need to verify the cntlid matches the
 		 * admin connect
 		 */
-		if (ctrl->cntlid != le16_to_cpu(id->cntlid))
+		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
 			ret = -EINVAL;
+			goto free_id;
+		}
 
 		if (!ctrl->opts->discovery_nqn && !ctrl->kas) {
 			dev_err(ctrl->device,
 				"keep-alive support is mandatory for fabrics\n");
 			ret = -EINVAL;
+			goto free_id;
 		}
 	} else {
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
@@ -1862,6 +1865,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->identified = true;
 
 	return ret;
+
+free_id:
+	kfree(id);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);

Or ditch the goto and do a kfree(id); return ret; directly in the if blocks?

Byte,
	Johannes
 
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
