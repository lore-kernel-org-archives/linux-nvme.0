From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jan 2018 21:26:23 +0900
Subject: [PATCH] nvme-cli: make it have bpid in cdw10 for fw-commit
Message-ID: <1516796783-32125-1-git-send-email-minwoo.im.dev@gmail.com>

_bpid_ was added as a parameter in commit d52c9988 without any being used.
Make it have inside of cdw10 before submitting a command.

Fixes: d52c9988 ("nvme-cli: update Firmware Commit with boot partition
feature")
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 5c900b7..4486b2d 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -694,7 +694,7 @@ int nvme_fw_commit(int fd, __u8 slot, __u8 action, __u8 bpid)
 {
 	struct nvme_admin_cmd cmd = {
 		.opcode		= nvme_admin_activate_fw,
-		.cdw10		= (action << 3) | slot,
+		.cdw10		= (bpid << 31) | (action << 3) | slot,
 	};
 
 	return nvme_submit_admin_passthru(fd, &cmd);
-- 
2.7.4
