From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 17 May 2019 02:23:49 +0900
Subject: [PATCH 1/2] nvme-cli: don't try to disconnect for ctrl with pcie
 transport
In-Reply-To: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
References: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
Message-ID: <20190516172350.11864-2-minwoo.im.dev@gmail.com>

If a host system has both pcie and fabrics controllers, the following
nvme-cli disconnect-all command will might not be working because
contrlller with pcie transport does not have delete_controller in sysfs.

root at target:~# nvme list
Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     foo                  QEMU NVMe Ctrl                           1         536.87  MB / 536.87  MB    512   B +  0 B   1.0
/dev/nvme1n1     b92326b9b2323bf0     Linux                                    1         134.22  MB / 134.22  MB    512   B +  0 B   5.1.0-rc
/dev/nvme2n1     65fa04eddd9bbac0     Linux                                    1         134.22  MB / 134.22  MB    512   B +  0 B   5.1.0-rc

root at target:~/nvme-cli.git# nvme disconnect-all
Failed to open /sys/class/nvme/nvme0/delete_controller: No such file or directory

This patch checks the transport type of the controller in iteration.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 511de06..733a24b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1196,6 +1196,8 @@ int disconnect_all(const char *desc, int argc, char **argv)
 
 		for (j = 0; j < subsys->nctrls; j++) {
 			struct ctrl_list_item *ctrl = &subsys->ctrls[j];
+			if (!strcmp(ctrl->transport, "pcie"))
+				continue;
 
 			ret = disconnect_by_device(ctrl->name);
 			if (ret)
-- 
2.21.0
