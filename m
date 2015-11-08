From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 8 Nov 2015 15:22:11 +0200
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <563F29D4.5030801@dev.mellanox.co.il>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
 <563F29D4.5030801@dev.mellanox.co.il>
Message-ID: <563F4C83.5030709@dev.mellanox.co.il>



On 08/11/2015 12:54, Sagi Grimberg wrote:
>
>> +static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
>> +{
>> +    struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
>> +
>> +    list_del(&ctrl->list);
>
> This should be list_del_init so that cleanup_module
> list_empty() check will be correct. unloading nvme-loop
> with active controllers is getting a list corruption.

Actually this is wrong. Whats wrong here is that ctrl->list
is being removed twice (once in nvme_loop_cleanup_module and
then here).

The following worked for me:
--
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a0eac07..cf0f745 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -869,18 +869,11 @@ out:

  static void __exit nvme_loop_cleanup_module(void)
  {
-       struct nvme_loop_ctrl *ctrl;
+       struct nvme_loop_ctrl *ctrl, *tmp;

         mutex_lock(&nvme_loop_ctrl_mutex);
-       while (!list_empty(&nvme_loop_ctrl_list)) {
-               ctrl = list_entry(nvme_loop_ctrl_list.next,
-                               struct nvme_loop_ctrl, list);
-
-               if (!list_empty(&ctrl->list))
-                       list_del(&ctrl->list);
-
+       list_for_each_entry_safe(ctrl, tmp, &nvme_loop_ctrl_list, list)
                 __nvme_loop_remove_ctrl(ctrl);
-       }
         mutex_unlock(&nvme_loop_ctrl_mutex);

         device_destroy(nvme_loop_class, MKDEV(0, 0));
--
