From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 17 Oct 2017 13:01:34 +0300
Subject: v4.14-rc5 NVMeOF regression?
In-Reply-To: <1508192588.2493.60.camel@wdc.com>
References: <1508192588.2493.60.camel@wdc.com>
Message-ID: <82de6177-27f5-463e-3446-0305fd9f6790@grimberg.me>


> Hello,

Hi Bart, thanks for reporting

> It has been a while since I ran any NVMeOF tests. But when I tried to test
> the v4.14-rc5 NVMeOF drivers the output shown below appeared. Is this a
> known issue? The following test triggered these call stacks:

Yea, we probably need to silence those with:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff5fb4d..d7504f180d93 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1988,7 +1988,7 @@ static void nvme_rdma_remove_one(struct ib_device 
*ib_device, void *client_data)
         struct nvme_rdma_ctrl *ctrl;

         /* Delete all controllers using this device */
-       mutex_lock(&nvme_rdma_ctrl_mutex);
+       mutex_lock_nested(&nvme_rdma_ctrl_mutex, SINGLE_DEPTH_NESTING);
         list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
                 if (ctrl->device->dev != ib_device)
                         continue;
--

I'll compile with CONFIG_DEBUG_LOCK_ALLOC and check this, but if you
happen to beat me to it, I can use your Tested-by tag.
