From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jan 2018 21:25:36 +0900
Subject: [PATCH 1/2] nvme-cli: add support for an abort command
Message-ID: <1516796736-31889-1-git-send-email-minwoo.im.dev@gmail.com>

Add support for an abort command.

sqid and cid are enough to be __u16, but declared in __u32 to check
being without either or both parameters.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-builtin.h |  1 +
 nvme-ioctl.c   | 13 +++++++++++++
 nvme-ioctl.h   |  1 +
 nvme.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/nvme-builtin.h b/nvme-builtin.h
index 4adfa78..c5d14ec 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -59,6 +59,7 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
+	ENTRY("abort", "Submit an Abort, return results", abort_cmd)
 );
 
 #endif
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 5c900b7..e0ed8d8 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -778,3 +778,16 @@ int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
         return err;
 }
 
+int nvme_abort(int fd, __u16 sqid, __u16 cid, __u32 *result)
+{
+	struct nvme_admin_cmd cmd = {
+		.opcode		= nvme_admin_abort_cmd,
+		.cdw10		= cid << 16 | sqid,
+	};
+	int err;
+
+	err = nvme_submit_admin_passthru(fd, &cmd);
+	if (!err && result)
+		*result = cmd.result;
+	return err;
+}
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 4031c70..295a187 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -127,5 +127,6 @@ int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
 int nvme_get_properties(int fd, void **pbar);
 int nvme_set_property(int fd, int offset, int value);
+int nvme_abort(int fd, __u16 sqid, __u16 cid, __u32 *result);
 
 #endif				/* _NVME_LIB_H */
diff --git a/nvme.c b/nvme.c
index 2723cb6..bc45b9b 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3678,6 +3678,56 @@ free:
         return err;
 }
 
+static int abort_cmd(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "It's used to abort a specific command previously "\
+			   "submitted to the Admin Submission Queue or an "\
+			   "I/O Submission Queue.";
+	const char *sqid = "Submission Queue Identifier";
+	const char *cid  = "Command Identifier";
+	__u32 result;
+	int fd;
+	int err;
+
+	struct config {
+		__u32 sqid;
+		__u32 cid;
+	};
+
+	struct config cfg = {
+		.sqid = 0xFFFFFFFF,
+		.cid  = 0xFFFFFFFF,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"sqid", 's', "NUM", CFG_POSITIVE, &cfg.sqid, required_argument, sqid},
+		{"cid",  'c', "NUM", CFG_POSITIVE, &cfg.cid,  required_argument, cid},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+	if (cfg.sqid >= (1 << 16) || cfg.cid >= (1 << 16)) {
+		fprintf(stderr, "sqid or cid not valid\n");
+		return EINVAL;
+	}
+
+	err = nvme_abort(fd, cfg.sqid, cfg.cid, &result);
+	if (err)
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	else {
+		if (result & 0x1)
+			printf("CMD(%04x) in SQ(%04X) not aborted.\n", cfg.cid, cfg.sqid);
+		else
+			printf("CMD(%04x) in SQ(%04X) successfully aborted.\n", cfg.cid, cfg.sqid);
+	}
+
+	return err;
+}
+
 static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, struct command *cmd)
 {
 	void *data = NULL, *metadata = NULL;
-- 
2.7.4
