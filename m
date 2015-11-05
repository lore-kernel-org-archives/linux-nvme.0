From: sathya.m@samsung.com (Sathyavathi M)
Date: Thu, 05 Nov 2015 05:17:06 +0000 (GMT)
Subject: [PATCH] Increase the max transfer size when mdts is 0
Message-ID: <78772001.550341446700625899.JavaMail.weblogic@ep2mlwas07a>

Jens,

Can you please pull in the below patch.

Regards,
Sathya

------- Original Message -------
Sender : Sathyavathi M<sathya.m at samsung.com> Lead Engineer/SRI-Bangalore-SSD Solutions/Samsung Electronics
Date : Sep 10, 2015 20:29 (GMT+09:00)
Title : [PATCH] Increase the max transfer size when mdts is 0
On Thu, 10 Sep 2015, Sathyavathi M wrote:
> From: Sathyavathi M <sathya.m at samsung.com>
>
> This patch address the issue when IO with 128KB from FIO is splitted as two
> parts, 124KB and 4KB due to max transfer size(127KB).This degrades the device
> performance.
>
> Signed-off-by: Sathyavathi M <sathya.m at samsung.com>

Acked-by: Keith Busch <keith.busch at intel.com>

From: Sathyavathi M 

This patch address the issue when IO with 128KB from FIO is splitted as two
parts, 124KB and 4KB due to max transfer size(127KB).This degrades the device
performance.

Signed-off-by: Sathyavathi M 
---
drivers/block/nvme-core.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..9bf6ea5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2479,6 +2479,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
if (ctrl->mdts)
dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+ else
+ dev->max_hw_sectors = UINT_MAX;
if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
(pdev->device == 0x0953) && ctrl->vs[3]) {
unsigned int max_hw_sectors;
-- 
1.9.1



Regards,
Sathya
