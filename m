From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jul 2019 23:29:04 +0200
Subject: [PATCH v2] nvme: fix multipath crash when ANA desactivated
In-Reply-To: <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu>
 <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
Message-ID: <20190709212904.GB9636@lst.de>

On Sat, Jul 06, 2019@01:06:44PM +0300, Max Gurtovoy wrote:
>> +	/* check if multipath is enabled and we have the capability */
>> +	if (!multipath)
>> +		return 0;
>> +	if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) != 0))
>
> shouldn't it be:
>
> if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) == 0))
>
> or
>
> if (!ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>
>
> Otherwise, you don't really do any initialization and return 0 in case you have the capability, right ?

Yes.  FYI, my idea how to fix this would be something like:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..cdb3e5baa329 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -12,11 +12,6 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
-inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
-}
-
 /*
  * If multipathing is enabled we need to always use the subsystem instance
  * number for numbering our devices to avoid conflicts between subsystems that
@@ -622,7 +617,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
 
-	if (!nvme_ctrl_use_ana(ctrl))
+	if (!multipath || !ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
 		return 0;
 
 	ctrl->anacap = id->anacap;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..14eca76bec5c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,7 +485,10 @@ extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
-bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
+static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
+{
+	return ctrl->ana_log_buf != NULL;
+}
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
