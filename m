From: anupshendkar@gmail.com (anup shendkar)
Date: Tue, 27 Aug 2013 15:50:34 +0530
Subject: NVME identify command data structure length
Message-ID: <CAB2zxrSPfCf4QVm=J__PX00ZFNU5XGehFKk4FNApMqbPS59BGA@mail.gmail.com>

Hi All,

While experimenting with NVME admin command IDENTIFY, I encountered
following behavior :

1. If program don't set data_len field in struct nvme_admin_cmd and
call ioctl for IDENTIFY command, ioctl call gets successful but return
buffer doesn't contain valid data.

2. After inspecting driver code I found that in function
nvme_user_admin_cmd(), nvme_submit_sync_cmd() function gets directly
called without mapping user pages.

3. As nvme specification for IDENTIFY command says that 4096 is the
output buffer length, we can add following code as a potential fix.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..b1c5e72 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1416,6 +1416,11 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
        c.common.cdw10[4] = cpu_to_le32(cmd.cdw14);
        c.common.cdw10[5] = cpu_to_le32(cmd.cdw15);

+       if (cmd.opcode == nvme_admin_identify) {
+               /* NVME Identiy command always uses 4096 data buffer */
+               cmd.data_len = 4096;
+       }
+
        length = cmd.data_len;
        if (cmd.data_len) {
                iod = nvme_map_user_pages(dev, cmd.opcode & 1, cmd.addr,


4. Above code is based on Kernel bersion = 3.11.0.rc1. I added this
change as nvme specification doesn't talk about setting output data
structure length.

Please advise/comment.

Regards,
-- 
anup shendkar
