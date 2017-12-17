From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 17 Dec 2017 18:58:41 +0900
Subject: [PATCH V2 2/3] nvme-cli: update Firmware Commit with boot partition
 feature
Message-ID: <1513504721-30887-1-git-send-email-minwoo.im.dev@gmail.com>

NVMe 1.3 spec introduced boot partition feature to Firmware Commit
command.

Make it support boot partition feature in Firmware Commit command.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-ioctl.c |  2 +-
 nvme-ioctl.h |  2 +-
 nvme.c       | 33 ++++++++++++++++++++++++---------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index f735ecc..c0d7775 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -650,7 +650,7 @@ int nvme_fw_download(int fd, __u32 offset, __u32 data_len, void *data)
 	return nvme_submit_admin_passthru(fd, &cmd);
 }
 
-int nvme_fw_activate(int fd, __u8 slot, __u8 action)
+int nvme_fw_commit(int fd, __u8 slot, __u8 action, __u8 bpid)
 {
 	struct nvme_admin_cmd cmd = {
 		.opcode		= nvme_admin_activate_fw,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 7cc80c8..6a3b52b 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -106,7 +106,7 @@ int nvme_ns_attach_ctrls(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist);
 int nvme_ns_detach_ctrls(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist);
 
 int nvme_fw_download(int fd, __u32 offset, __u32 data_len, void *data);
-int nvme_fw_activate(int fd, __u8 slot, __u8 action);
+int nvme_fw_commit(int fd, __u8 slot, __u8 action, __u8 bpid);
 
 int nvme_sec_send(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 		  __u8 secp, __u32 tl, __u32 data_len, void *data, __u32 *result);
diff --git a/nvme.c b/nvme.c
index bb9feaa..d9cb5db 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1787,23 +1787,27 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 		"reset following firmware activation. A reset may be issued "\
 		"with an 'echo 1 > /sys/class/nvme/nvmeX/reset_controller'. "\
 		"Ensure nvmeX is the device you just activated before reset.";
-	const char *slot = "firmware slot to activate";
-	const char *action = "[0-2]: replacement action";
+	const char *slot = "[0-7]: firmware slot for commit action";
+	const char *action = "[0-7]: commit action";
+	const char *bpid = "[0,1]: boot partition identifier, if applicable (default: 0)";
 	int err, fd;
 
 	struct config {
 		__u8 slot;
 		__u8 action;
+		__u8 bpid;
 	};
 
 	struct config cfg = {
 		.slot   = 0,
 		.action = 0,
+		.bpid   = 0,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"slot",   's', "NUM", CFG_BYTE, &cfg.slot,   required_argument, slot},
 		{"action", 'a', "NUM", CFG_BYTE, &cfg.action, required_argument, action},
+		{"bpid",   'b', "NUM", CFG_BYTE, &cfg.bpid,   required_argument, bpid},
 		{NULL}
 	};
 
@@ -1815,30 +1819,41 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 		fprintf(stderr, "invalid slot:%d\n", cfg.slot);
 		return EINVAL;
 	}
-	if (cfg.action > 3) {
+	if (cfg.action > 7 || cfg.action == 4 || cfg.action == 5) {
 		fprintf(stderr, "invalid action:%d\n", cfg.action);
 		return EINVAL;
 	}
+	if (cfg.bpid > 1) {
+		fprintf(stderr, "invalid boot partition id:%d\n", cfg.bpid);
+		return EINVAL;
+	}
 
-	err = nvme_fw_activate(fd, cfg.slot, cfg.action);
+	err = nvme_fw_commit(fd, cfg.slot, cfg.action, cfg.bpid);
 	if (err < 0)
-		perror("fw-activate");
+		perror("fw-commit");
 	else if (err != 0)
 		switch (err & 0x3ff) {
 		case NVME_SC_FW_NEEDS_CONV_RESET:
 		case NVME_SC_FW_NEEDS_SUBSYS_RESET:
 		case NVME_SC_FW_NEEDS_RESET:
-			printf("Success activating firmware action:%d slot:%d, but firmware requires %s reset\n",
-			       cfg.action, cfg.slot, nvme_fw_status_reset_type(err));
+			printf("Success activating firmware action:%d slot:%d",
+			       cfg.action, cfg.slot);
+			if (cfg.action == 6 || cfg.action == 7)
+				printf(" bpid:%d", cfg.bpid);
+			printf(", but firmware requires %s reset\n", nvme_fw_status_reset_type(err));
 			break;
 		default:
 			fprintf(stderr, "NVME Admin command error:%s(%x)\n",
 						nvme_status_to_string(err), err);
 			break;
 		}
-	else
-		printf("Success activating firmware action:%d slot:%d\n",
+	else {
+		printf("Success committing firmware action:%d slot:%d",
 		       cfg.action, cfg.slot);
+		if (cfg.action == 6 || cfg.action == 7)
+			printf(" bpid:%d", cfg.bpid);
+		printf("\n");
+	}
 	return err;
 }
 
-- 
2.7.4
