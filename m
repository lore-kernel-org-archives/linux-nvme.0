From: jsmart2021@gmail.com (James Smart)
Date: Fri, 27 Apr 2018 10:29:01 -0700
Subject: [PATCH] nvme-cli: Add ioctl retry support for connect-all
Message-ID: <20180427172901.3479-1-jsmart2021@gmail.com>

Currently, if an ioctl command to a controller fails, the routines
within nvme-cli don't do retries and just fail.  In the case of
operations such as "connect-all" which depend on the ioctl to read
the discovery log to give it the list of controller to then "connect"
to, this failure can be catastrophic as there's no guarantee that the
event/admin action that performed the connect-all will be re-triggered,
resulting in a loss of connectivity to storage subsystems.

As to why the ioctl may have failed in the first place: if the
controller is in the middle of a reset or reconnect due to
an error or temporary loss of connectivity (which can happen even
on a discovery controller), ioctl commands will fail rather than
suspend for the full duration of the controller state change
(say to live or delete), which could be a minute or more.

This patch makes the following changes:
1) As it's expected other cases will run into the need to do retries,
   Implement wrappers for the ioctl routine. The wrappers have a
   retry loop.  The ioctl will only retry if the failure status
   was EAGAIN.

2) Modify the ioctl callees to use the wrappers and specify a retry
   count parameter.

3) Leave all ioctl requests for no retries except the command that
   obtains log pages. The command that obtains log pages qualifies the
   log page being queried: if reading the discovery log, then it
   requests retries for up to 60s (default controller loss tmo); if
   not the discovery log page, then no retries.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 intel-nvme.c    |   3 +-
 nvme-ioctl.c    | 103 ++++++++++++++++++++++++++++++++++++--------------------
 nvme-ioctl.h    |  11 +++++-
 nvme-lightnvm.c |   8 +++--
 wdc-nvme.c      |  26 +++++++++-----
 5 files changed, 101 insertions(+), 50 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 5e407df..474bdc1 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -544,7 +544,8 @@ static int read_entire_cmd(struct nvme_passthru_cmd *cmd, int total_size,
 
 	dword_tfer = min(max_tfer, total_size);
 	while (total_size > 0) {
-		err = nvme_submit_passthru(ioctl_fd, NVME_IOCTL_ADMIN_CMD, cmd);
+		err = nvme_submit_passthru(ioctl_fd, NVME_IOCTL_ADMIN_CMD, cmd,
+				NO_RETRIES);
 		if (err) {
 			fprintf(stderr, "failed on cmd.data_len %u cmd.cdw13 %u cmd.cdw12 %x cmd.cdw10 %u err %x remaining size %d\n", cmd->data_len, cmd->cdw13, cmd->cdw12, cmd->cdw10, err, total_size);
 			goto out;
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index e8ba935..cb7673f 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -21,6 +21,34 @@
 
 #include "nvme-ioctl.h"
 
+
+static int nvme_do_ioctl_noarg(int fd, int rqst, int maxretry)
+{
+	int ret = 0, retry;
+
+	for (retry = 0 ; retry <= maxretry; retry++) {
+		ret = ioctl(fd, rqst);
+		if (ret != -1 || errno != EAGAIN)
+			break;
+		usleep(IOCTL_DELAY);
+	}
+	return ret;
+}
+
+static int nvme_do_ioctl(int fd, int rqst, void *cmd, int maxretry)
+{
+	int ret = 0, retry;
+
+	for (retry = 0 ; retry <= maxretry; retry++) {
+		ret = ioctl(fd, rqst, cmd);
+		if (ret != -1 || errno != EAGAIN)
+			break;
+
+		usleep(IOCTL_DELAY);
+	}
+	return ret;
+}
+
 static int nvme_verify_chr(int fd)
 {
 	static struct stat nvme_stat;
@@ -45,7 +73,7 @@ int nvme_subsystem_reset(int fd)
 	ret = nvme_verify_chr(fd);
 	if (ret)
 		return ret;
-	return ioctl(fd, NVME_IOCTL_SUBSYS_RESET);
+	return nvme_do_ioctl_noarg(fd, NVME_IOCTL_SUBSYS_RESET, NO_RETRIES);
 }
 
 int nvme_reset_controller(int fd)
@@ -55,7 +83,7 @@ int nvme_reset_controller(int fd)
 	ret = nvme_verify_chr(fd);
 	if (ret)
 		return ret;
-	return ioctl(fd, NVME_IOCTL_RESET);
+	return nvme_do_ioctl_noarg(fd, NVME_IOCTL_RESET, NO_RETRIES);
 }
 
 int nvme_ns_rescan(int fd)
@@ -65,7 +93,7 @@ int nvme_ns_rescan(int fd)
 	ret = nvme_verify_chr(fd);
 	if (ret)
 		return ret;
-	return ioctl(fd, NVME_IOCTL_RESCAN);
+	return nvme_do_ioctl_noarg(fd, NVME_IOCTL_RESCAN, NO_RETRIES);
 }
 
 int nvme_get_nsid(int fd)
@@ -81,22 +109,25 @@ int nvme_get_nsid(int fd)
 			"Error: requesting namespace-id from non-block device\n");
 		return -ENOTBLK;
 	}
-	return ioctl(fd, NVME_IOCTL_ID);
+	return nvme_do_ioctl_noarg(fd, NVME_IOCTL_ID, NO_RETRIES);
 }
 
-int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd)
+int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd,
+		int maxretry)
 {
-	return ioctl(fd, ioctl_cmd, cmd);
+	return nvme_do_ioctl(fd, ioctl_cmd, cmd, maxretry);
 }
 
-static int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd)
+static int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd,
+		int maxretry)
 {
-	return ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd);
+	return nvme_do_ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd, maxretry);
 }
 
-static int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
+static int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd,
+		int maxretry)
 {
-	return ioctl(fd, NVME_IOCTL_IO_CMD, cmd);
+	return nvme_do_ioctl(fd, NVME_IOCTL_IO_CMD, cmd, maxretry);
 }
 
 int nvme_passthru(int fd, int ioctl_cmd, __u8 opcode, __u8 flags, __u16 rsvd,
@@ -127,7 +158,7 @@ int nvme_passthru(int fd, int ioctl_cmd, __u8 opcode, __u8 flags, __u16 rsvd,
 	};
 	int err;
 
-	err = nvme_submit_passthru(fd, ioctl_cmd, &cmd);
+	err = nvme_submit_passthru(fd, ioctl_cmd, &cmd, NO_RETRIES);
 	if (!err && result)
 		*result = cmd.result;
 	return err;
@@ -151,7 +182,7 @@ int nvme_io(int fd, __u8 opcode, __u64 slba, __u16 nblocks, __u16 control,
 		.appmask	= appmask,
 		.apptag		= apptag,
 	};
-	return ioctl(fd, NVME_IOCTL_SUBMIT_IO, &io);
+	return nvme_do_ioctl(fd, NVME_IOCTL_SUBMIT_IO, &io, NO_RETRIES);
 }
 
 int nvme_read(int fd, __u64 slba, __u16 nblocks, __u16 control, __u32 dsmgmt,
@@ -203,7 +234,7 @@ int nvme_write_zeros(int fd, __u32 nsid, __u64 slba, __u16 nlb,
 		.cdw15		= apptag | (appmask << 16),
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_write_uncorrectable(int fd, __u32 nsid, __u64 slba, __u16 nlb)
@@ -216,7 +247,7 @@ int nvme_write_uncorrectable(int fd, __u32 nsid, __u64 slba, __u16 nlb)
 		.cdw12		= nlb,
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_flush(int fd, __u32 nsid)
@@ -226,7 +257,7 @@ int nvme_flush(int fd, __u32 nsid)
 		.nsid		= nsid,
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_dsm(int fd, __u32 nsid, __u32 cdw11, struct nvme_dsm_range *dsm,
@@ -241,7 +272,7 @@ int nvme_dsm(int fd, __u32 nsid, __u32 cdw11, struct nvme_dsm_range *dsm,
 		.cdw11		= cdw11,
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 struct nvme_dsm_range *nvme_setup_dsm_range(__u32 *ctx_attrs, __u32 *llbas,
@@ -273,7 +304,7 @@ int nvme_resv_acquire(int fd, __u32 nsid, __u8 rtype, __u8 racqa,
 		.data_len	= sizeof(payload),
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_resv_register(int fd, __u32 nsid, __u8 rrega, __u8 cptpl,
@@ -290,7 +321,7 @@ int nvme_resv_register(int fd, __u32 nsid, __u8 rrega, __u8 cptpl,
 		.data_len	= sizeof(payload),
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
@@ -307,7 +338,7 @@ int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
 		.data_len	= sizeof(payload),
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data)
@@ -321,7 +352,7 @@ int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data)
 		.data_len	= numd << 2,
 	};
 
-	return nvme_submit_io_passthru(fd, &cmd);
+	return nvme_submit_io_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_passthru_admin(int fd, __u8 opcode, __u8 flags, __u16 rsvd,
@@ -346,7 +377,7 @@ int nvme_identify(int fd, __u32 nsid, __u32 cdw10, void *data)
 		.cdw10		= cdw10,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_identify_ctrl(int fd, void *data)
@@ -401,8 +432,8 @@ int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 	cmd.cdw12 = lpo;
 	cmd.cdw13 = (lpo >> 32);
 
-	return nvme_submit_admin_passthru(fd, &cmd);
-
+	return nvme_submit_admin_passthru(fd, &cmd,
+		(log_id == NVME_LOG_DISC) ?  DISCOVERY_RETRIES : NO_RETRIES);
 }
 
 int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
@@ -478,7 +509,7 @@ int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10, __u32 cdw11,
 	};
 	int err;
 
-	err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 	if (!err && result)
 		*result = cmd.result;
 	return err;
@@ -517,7 +548,7 @@ int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
 		return -errno;
 	}
 
-	err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 	if (!err && fctype == nvme_fabrics_type_property_get)
 		*value = cpu_to_le64(cmd.result);
 	return err;
@@ -603,7 +634,7 @@ int nvme_format(int fd, __u32 nsid, __u8 lbaf, __u8 ses, __u8 pi,
 		.timeout_ms	= timeout,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_ns_create(int fd, __u64 nsze, __u64 ncap, __u8 flbas,
@@ -624,7 +655,7 @@ int nvme_ns_create(int fd, __u64 nsze, __u64 ncap, __u8 flbas,
 	};
 	int err;
 
-	err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 	if (!err && result)
 		*result = cmd.result;
 	return err;
@@ -638,7 +669,7 @@ int nvme_ns_delete(int fd, __u32 nsid)
 		.cdw10		= 1,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_ns_attachment(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist,
@@ -661,7 +692,7 @@ int nvme_ns_attachment(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist,
 	for (i = 0; i < num_ctrls; i++)
 		cntlist->identifier[i] = cpu_to_le16(ctrlist[i]);
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_ns_attach_ctrls(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist)
@@ -684,7 +715,7 @@ int nvme_fw_download(int fd, __u32 offset, __u32 data_len, void *data)
 		.cdw11		= offset >> 2,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_fw_commit(int fd, __u8 slot, __u8 action, __u8 bpid)
@@ -694,7 +725,7 @@ int nvme_fw_commit(int fd, __u8 slot, __u8 action, __u8 bpid)
 		.cdw10		= (bpid << 31) | (action << 3) | slot,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
 
 int nvme_sec_send(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
@@ -710,7 +741,7 @@ int nvme_sec_send(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 	};
 	int err;
 
-	err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 	if (!err && result)
 		*result = cmd.result;
 	return err;
@@ -729,7 +760,7 @@ int nvme_sec_recv(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 	};
 	int err;
 
-	err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 	if (!err && result)
 		*result = cmd.result;
 	return err;
@@ -749,7 +780,7 @@ int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
         };
         int err;
 
-        err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
         if (!err && result)
                 *result = cmd.result;
         return err;
@@ -769,7 +800,7 @@ int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
         };
         int err;
 
-        err = nvme_submit_admin_passthru(fd, &cmd);
+	err = nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
         if (!err && result)
                 *result = cmd.result;
         return err;
@@ -786,5 +817,5 @@ int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
 		.cdw11		= ovrpat,
 	};
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	return nvme_submit_admin_passthru(fd, &cmd, NO_RETRIES);
 }
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 9bf5459..2997bd7 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -6,10 +6,19 @@
 #include "linux/nvme_ioctl.h"
 #include "nvme.h"
 
+/* rate of ioctl retries */
+#define IOCTL_TIMESPERSEC	4
+/* delay between retries. Units in us */
+#define IOCTL_DELAY		(1000000 / IOCTL_TIMESPERSEC)	/* 250ms */
+
+#define NO_RETRIES		0
+#define DISCOVERY_RETRIES	(IOCTL_TIMESPERSEC * 60)	/* 60s */
+
 int nvme_get_nsid(int fd);
 
 /* Generic passthrough */
-int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd);
+int nvme_submit_passthru(int fd, int ioctl_cmd, struct nvme_passthru_cmd *cmd,
+		int maxretry);
 
 int nvme_passthru(int fd, int ioctl_cmd, __u8 opcode, __u8 flags,
 		  __u16 rsvd, __u32 nsid, __u32 cdw2, __u32 cdw3,
diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 0fdc74d..52456a0 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -383,7 +383,7 @@ static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
 		.data_len	= 0x1000,
 	};
 
-	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd, NO_RETRIES);
 }
 
 int lnvm_do_id_ns(int fd, int nsid, unsigned int flags)
@@ -440,7 +440,8 @@ static int __lnvm_do_get_bbtbl(int fd, struct nvme_nvm_id *id,
 	};
 
 	err = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD,
-					(struct nvme_passthru_cmd *)&cmd);
+					(struct nvme_passthru_cmd *)&cmd,
+					NO_RETRIES);
 	if (err > 0) {
 		fprintf(stderr, "NVMe Status:%s(%x)\n",
 			nvme_status_to_string(err), err);
@@ -500,7 +501,8 @@ static int __lnvm_do_set_bbtbl(int fd, struct ppa_addr ppa, __u8 value)
 	};
 
 	err = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD,
-					(struct nvme_passthru_cmd *)&cmd);
+					(struct nvme_passthru_cmd *)&cmd,
+					NO_RETRIES);
 	if (err > 0) {
 		fprintf(stderr, "NVMe Status:%s(%x)\n",
 			nvme_status_to_string(err), err);
diff --git a/wdc-nvme.c b/wdc-nvme.c
index 0f4375c..7c769d1 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -650,7 +650,8 @@ static int wdc_do_clear_dump(int fd, __u8 opcode, __u32 cdw12)
 	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
 	admin_cmd.opcode = opcode;
 	admin_cmd.cdw12 = cdw12;
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+				NO_RETRIES);
 	if (ret != 0) {
 		fprintf(stdout, "ERROR : WDC : Crash dump erase failed\n");
 	}
@@ -673,7 +674,8 @@ static __u32 wdc_dump_length(int fd, __u32 opcode, __u32 cdw10, __u32 cdw12, __u
 	admin_cmd.cdw10 = cdw10;
 	admin_cmd.cdw12 = cdw12;
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+				NO_RETRIES);
 	if (ret != 0) {
 		l->log_size = 0;
 		ret = -1;
@@ -709,7 +711,8 @@ static int wdc_do_dump(int fd, __u32 opcode,__u32 data_len, __u32 cdw10,
 	admin_cmd.cdw10 = cdw10;
 	admin_cmd.cdw12 = cdw12;
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+			NO_RETRIES);
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
 		ret = wdc_create_log_file(file, dump_data, dump_length);
@@ -853,7 +856,8 @@ static int wdc_do_drive_log(int fd, char *file)
 	admin_cmd.cdw12 = ((WDC_NVME_DRIVE_LOG_SUBCMD <<
 				WDC_NVME_SUBCMD_SHIFT) | WDC_NVME_DRIVE_LOG_SIZE_CMD);
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+			NO_RETRIES);
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret),
 			ret);
 	if (ret == 0) {
@@ -1002,7 +1006,8 @@ static int wdc_purge(int argc, char **argv,
 		return fd;
 
 	wdc_check_device(fd);
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+			NO_RETRIES);
 	if (ret > 0) {
 		switch (ret) {
 		case WDC_NVME_PURGE_CMD_SEQ_ERR:
@@ -1049,7 +1054,8 @@ static int wdc_purge_monitor(int argc, char **argv,
 		return fd;
 
 	wdc_check_device(fd);
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+			NO_RETRIES);
 	if (ret == 0) {
 		mon = (struct wdc_nvme_purge_monitor_data *) output;
 		printf("Purge state = 0x%0x\n", admin_cmd.result);
@@ -1515,7 +1521,8 @@ static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
 	admin_cmd.cdw12 = ((WDC_NVME_CLEAR_PCIE_CORR_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
 			WDC_NVME_CLEAR_PCIE_CORR_CMD);
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd,
+			NO_RETRIES);
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	return ret;
 }
@@ -1584,7 +1591,7 @@ int wdc_de_VU_read_size(int fd, __u32 fileId, __u16 spiDestn, __u32* logSize)
 	cmd.cdw13 = fileId<<16;
 	cmd.cdw14 = spiDestn;
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd, NO_RETRIES);
 
 	if (!ret && logSize)
 		*logSize = cmd.result;
@@ -1619,7 +1626,8 @@ int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDw
 	cmd.addr = (__u64)(__u64)(uintptr_t)dataBuffer;
 	cmd.data_len = *bufferSize;
 
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd,
+			NO_RETRIES);
 
 	if( ret != WDC_STATUS_SUCCESS)
 		fprintf(stderr, "ERROR : WDC : VUReadBuffer() failed, status:%s(0x%x)\n", nvme_status_to_string(ret), ret);
-- 
2.13.1
