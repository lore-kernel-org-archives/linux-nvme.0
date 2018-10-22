From: lijie34@huawei.com (lijie)
Date: Mon, 22 Oct 2018 17:48:33 +0800
Subject: [PATCH] nvmet: adjust the serial number format function
Message-ID: <1540201713-14848-1-git-send-email-lijie34@huawei.com>

The serial number displayed on the host side using the nvme list command
is different from the attr_serial at the target side, because the
nvmet_execute_identify_ctrl function and the
nvmet_subsys_attr_serial_store function use different types of formatting
functions.

For example:
[root at localhost ~]# nvme list
Node             SN                   Model
Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     88f6a93ee8543dc6     Linux
1          42.95  GB /  42.95  GB    512   B +  0 B   4.19.0-r

linux-toyz:~ # cat /sys/kernel/config/nvmet/subsystems/fctest1/attr_serial
c63d54e83ea9f688
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 1179f63..498ce25 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -269,6 +269,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
 	const char model[] = "Linux";
+	char sn[21];
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -280,9 +281,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	bin2hex(id->sn, &ctrl->subsys->serial,
-		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
+	snprintf(sn, min(sizeof(sn), 2 * sizeof(ctrl->subsys->serial) + 1), "%llx", ctrl->subsys->serial);
+	memcpy_and_pad(id->sn, sizeof(id->sn), sn, strlen(sn), ' ');
 	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
-- 
2.6.4.windows.1
