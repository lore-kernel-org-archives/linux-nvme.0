From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:39 +0200
Subject: [PATCH 6/6] nvme-cli: kill nvme_passthru_admin()
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920090939.6348-7-hare@suse.de>

The seagate plugin is the only one using it, and it's identical
to nvme_get_log13(). So replace the invocation with nvme_get_log13()
and remove the function.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme-ioctl.c   | 12 ------------
 nvme-ioctl.h   |  8 --------
 seagate-nvme.c | 53 ++++++++++++++++++-----------------------------------
 3 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index dc9aad8..2a8012c 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -327,18 +327,6 @@ int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data)
 	return nvme_submit_io_passthru(fd, &cmd);
 }
 
-int nvme_passthru_admin(int fd, __u8 opcode, __u8 flags, __u16 rsvd,
-			__u32 nsid, __u32 cdw2, __u32 cdw3, __u32 cdw10,
-			__u32 cdw11, __u32 cdw12, __u32 cdw13, __u32 cdw14,
-			__u32 cdw15, __u32 data_len, void *data,
-			__u32 metadata_len, void *metadata, __u32 timeout_ms)
-{
-	return nvme_passthru(fd, NVME_IOCTL_ADMIN_CMD, opcode, flags, rsvd,
-			     nsid, cdw2, cdw3, cdw10, cdw11, cdw12, cdw13,
-			     cdw14, cdw15, data_len, data, metadata_len,
-			     metadata, timeout_ms, NULL);
-}
-
 int nvme_identify13(int fd, __u32 nsid, __u32 cdw10, __u32 cdw11, void *data)
 {
 	struct nvme_admin_cmd cmd = {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index b6abade..bb06f82 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -64,14 +64,6 @@ int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
 		      bool iekey, __u64 crkey);
 int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data);
 
-/* NVME_ADMIN_CMD */
-int nvme_passthru_admin(int fd, __u8 opcode, __u8 flags, __u16 rsvd,
-			__u32 nsid, __u32 cdw2, __u32 cdw3,
-			__u32 cdw10, __u32 cdw11, __u32 cdw12,
-			__u32 cdw13, __u32 cdw14, __u32 cdw15,
-			__u32 data_len, void *data, __u32 metadata_len,
-			void *metadata, __u32 timeout);
-
 int nvme_identify13(int fd, __u32 nsid, __u32 cdw10, __u32 cdw11, void *data);
 int nvme_identify(int fd, __u32 nsid, __u32 cdw10, void *data);
 int nvme_identify_ctrl(int fd, void *data);
diff --git a/seagate-nvme.c b/seagate-nvme.c
index 15a91ef..f8fc5c7 100755
--- a/seagate-nvme.c
+++ b/seagate-nvme.c
@@ -1060,34 +1060,6 @@ static int vs_clr_pcie_correctable_errs(int argc, char **argv, struct command *c
 
 }
 
-int nvme_get_log_with_offset(int fd, __u32 nsid, __u16 log_id, __u32 data_len, __u64 offset, void *data)
-{
-	struct nvme_admin_cmd cmd = {
-		.opcode		= nvme_admin_get_log_page,
-		.nsid		= nsid,
-		.addr		= (__u64)(uintptr_t) data,
-		.data_len	= data_len,
-	};
-	__u32 numd = (data_len >> 2) - 1;
-	__u16 numdu = numd >> 16, numdl = numd & 0xffff;
-
-	cmd.cdw10 = log_id | (numdl << 16);
-	cmd.cdw11 = numdu;
-	cmd.cdw12 = (__u32)(offset & 0xffffffff);
-	cmd.cdw13 = (__u32)((offset >> 32) & 0xffffffff);
-
-	/***************************************************************************
-    printf("nvme_get_log_with_offset Parameter Details - \n");
-    printf("data_len : %d cdw10 : %x cdw11 : %x cdw12 : %x cdw13 : %x\n", cmd.data_len, cmd.cdw10, cmd.cdw11, cmd.cdw12, cmd.cdw13);
-	***************************************************************************/
-	return nvme_passthru_admin(fd, cmd.opcode, 0, 0,
-				   cmd.nsid, 0, 0,
-				   cmd.cdw10, cmd.cdw11, cmd.cdw12,
-				   cmd.cdw13, 0, 0,
-				   cmd.data_len, data, 0,
-				   NULL, 100);
-}
-
 static int get_host_tele(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Capture the Telemetry Host-Initiated Data in either " \
@@ -1130,9 +1102,10 @@ static int get_host_tele(int argc, char **argv, struct command *cmd, struct plug
 
 	cfg.log_id = (cfg.log_id << 8) | 0x07;
 
-	err = nvme_get_log_with_offset(fd, cfg.namespace_id, cfg.log_id, sizeof(tele_log), offset, (void *)(&tele_log));
+	err = nvme_get_log13(fd, cfg.namespace_id, cfg.log_id,
+			     NVME_NO_LOG_LSP, offset, 0, false,
+			     sizeof(tele_log), (void *)(&tele_log));
 	if (!err) {
-
 		maxBlk = tele_log.tele_data_area3;
 		offset += 512;
 
@@ -1169,7 +1142,9 @@ static int get_host_tele(int argc, char **argv, struct command *cmd, struct plug
 
 		memset(log, 0, blksToGet * 512);
 
-		err = nvme_get_log_with_offset(fd, cfg.namespace_id, cfg.log_id, blksToGet * 512, offset, (void *)log);
+		err = nvme_get_log13(fd, cfg.namespace_id, cfg.log_id,
+				     NVME_NO_LOG_LSP, offset, 0, false,
+				     blksToGet * 512, (void *)log);
 		if (!err) {
 			offset += blksToGet * 512;
 
@@ -1229,7 +1204,9 @@ static int get_ctrl_tele(int argc, char **argv, struct command *cmd, struct plug
 	dump_fd = STDOUT_FILENO;
 
 	log_id = 0x08;
-	err = nvme_get_log_with_offset(fd, cfg.namespace_id, log_id, sizeof(tele_log), offset, (void *)(&tele_log));
+	err = nvme_get_log13(fd, cfg.namespace_id, log_id,
+			     NVME_NO_LOG_LSP, offset, 0, false,
+			     sizeof(tele_log), (void *)(&tele_log));
 	if (!err) {
 		maxBlk = tele_log.tele_data_area3;
 		offset += 512;
@@ -1266,7 +1243,9 @@ static int get_ctrl_tele(int argc, char **argv, struct command *cmd, struct plug
 
 		memset(log, 0, blksToGet * 512);
 
-		err = nvme_get_log_with_offset(fd, cfg.namespace_id, log_id, blksToGet * 512, offset, (void *)log);
+		err = nvme_get_log13(fd, cfg.namespace_id, log_id,
+				     NVME_NO_LOG_LSP, offset, 0, false,
+				     blksToGet * 512, (void *)log);
 		if (!err) {
 			offset += blksToGet * 512;
 
@@ -1351,7 +1330,9 @@ static int vs_internal_log(int argc, char **argv, struct command *cmd, struct pl
 	}
 
 	log_id = 0x08;
-	err = nvme_get_log_with_offset(fd, cfg.namespace_id, log_id, sizeof(tele_log), offset, (void *)(&tele_log));
+	err = nvme_get_log13(fd, cfg.namespace_id, log_id,
+			     NVME_NO_LOG_LSP, offset, 0, false,
+			     sizeof(tele_log), (void *)(&tele_log));
 	if (!err) {
 		maxBlk = tele_log.tele_data_area3;
 		offset += 512;
@@ -1386,7 +1367,9 @@ static int vs_internal_log(int argc, char **argv, struct command *cmd, struct pl
 
 		memset(log, 0, blksToGet * 512);
 
-		err = nvme_get_log_with_offset(fd, cfg.namespace_id, log_id, blksToGet * 512, offset, (void *)log);
+		err = nvme_get_log13(fd, cfg.namespace_id, log_id,
+				     NVME_NO_LOG_LSP, offset, 0, false,
+				     blksToGet * 512, (void *)log);
 		if (!err) {
 			offset += blksToGet * 512;
 
-- 
2.13.7
