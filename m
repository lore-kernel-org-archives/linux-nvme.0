From: Dong.Ho@wdc.com (Dong Ho)
Date: Fri, 11 Jan 2019 00:37:09 +0000
Subject: [PATCH 2/2] wdc: Add additional device for vs-internal-log
In-Reply-To: <1547167007-2374-1-git-send-email-dong.ho@wdc.com>
References: <1547167007-2374-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1547167007-2374-2-git-send-email-dong.ho@wdc.com>

Add support for SN730 device to vs-internal-log.

Reviewed-by Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index d198571..88c5c76 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -69,6 +69,8 @@
 #define WDC_NVME_SN520_DEV_ID_1				0x5004
 #define WDC_NVME_SN520_DEV_ID_2				0x5005
 #define WDC_NVME_SN720_DEV_ID				0x5002
+#define WDC_NVME_SN730_DEV_ID				0x3714
+#define WDC_NVME_SN730_DEV_ID_1				0x3734
 
 #define WDC_DRIVE_CAP_CAP_DIAG				0x0000000000000001
 #define WDC_DRIVE_CAP_INTERNAL_LOG			0x0000000000000002
@@ -80,6 +82,21 @@
 #define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
 
+#define WDC_SN730_CAP_VUC_LOG				0x0000000400000000
+
+/* SN730 Get Log Capabilities */
+#define SN730_NVME_GET_LOG_OPCODE			0xc2
+#define SN730_GET_FULL_LOG_LENGTH			0x00080009
+#define SN730_GET_KEY_LOG_LENGTH			0x00090009
+#define SN730_GET_COREDUMP_LOG_LENGTH			0x00120009
+#define SN730_GET_EXTENDED_LOG_LENGTH			0x00420009
+
+#define SN730_GET_FULL_LOG_SUBOPCODE			0x00010009
+#define SN730_GET_KEY_LOG_SUBOPCODE			0x00020009
+#define SN730_GET_CORE_LOG_SUBOPCODE			0x00030009
+#define SN730_GET_EXTEND_LOG_SUBOPCODE			0x00040009
+#define SN730_LOG_CHUNK_SIZE				0x1000
+
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
 #define WDC_NVME_CAP_DIAG_OPCODE			0xE6
@@ -277,6 +294,18 @@ typedef struct _WDC_DE_CSA_FEATURE_ID_LIST
     __u8 featureName[WDC_DE_GENERIC_BUFFER_SIZE];
 } WDC_DE_CSA_FEATURE_ID_LIST;
 
+typedef struct tarfile_metadata {
+	char fileName[MAX_PATH_LEN];
+	int8_t bufferFolderPath[MAX_PATH_LEN];
+	char bufferFolderName[MAX_PATH_LEN];
+	char tarFileName[MAX_PATH_LEN];
+	char tarFiles[MAX_PATH_LEN];
+	char tarCmd[MAX_PATH_LEN+MAX_PATH_LEN];
+	char currDir[MAX_PATH_LEN];
+	UtilsTimeInfo timeInfo;
+	uint8_t* timeString[MAX_PATH_LEN];
+} tarfile_metadata;
+
 static WDC_DE_CSA_FEATURE_ID_LIST deFeatureIdList[] =
 {
 	{0x00                                   , "Dummy Placeholder"},
@@ -580,6 +609,11 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 					WDC_DRIVE_CAP_CA_LOG_PAGE | WDC_DRIVE_CAP_DRIVE_STATUS |
 					WDC_DRIVE_CAP_CLEAR_ASSERT);
 			break;
+		case WDC_NVME_SN730_DEV_ID:
+		/* FALLTHRU */
+		case WDC_NVME_SN730_DEV_ID_1:
+			capabilities = WDC_SN730_CAP_VUC_LOG;
+			break;
 		default:
 			capabilities = 0;
 		}
@@ -1049,6 +1083,236 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	return 0;
 }
 
+static int wdc_do_get_sn730_log_len(int fd, uint32_t *len_buf, uint32_t subopcode)
+{
+	int ret;
+	uint32_t *output = NULL;
+	struct nvme_admin_cmd admin_cmd;
+
+	if ((output = (uint32_t*)malloc(sizeof(uint32_t))) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		return -1;
+	}
+	memset(output, 0, sizeof (uint32_t));
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+
+	admin_cmd.data_len = 8;
+	admin_cmd.opcode = SN730_NVME_GET_LOG_OPCODE;
+	admin_cmd.addr = (uintptr_t)output;
+	admin_cmd.cdw12 = subopcode;
+	admin_cmd.cdw10 = SN730_LOG_CHUNK_SIZE / 4;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	if (ret == 0)
+		*len_buf = *output;
+	free(output);
+	return ret;
+}
+
+static int wdc_do_get_sn730_log(int fd, void * log_buf, uint32_t offset, uint32_t subopcode)
+{
+	int ret;
+	uint8_t *output = NULL;
+	struct nvme_admin_cmd admin_cmd;
+
+	if ((output = (uint8_t*)calloc(SN730_LOG_CHUNK_SIZE, sizeof(uint8_t))) == NULL) {
+		fprintf(stderr, "ERROR : WDC : calloc : %s\n", strerror(errno));
+		return -1;
+	}
+	memset(&admin_cmd, 0, sizeof (struct nvme_admin_cmd));
+	admin_cmd.data_len = SN730_LOG_CHUNK_SIZE;
+	admin_cmd.opcode = SN730_NVME_GET_LOG_OPCODE;
+	admin_cmd.addr = (uintptr_t)output;
+	admin_cmd.cdw12 = subopcode;
+	admin_cmd.cdw13 = offset;
+	admin_cmd.cdw10 = SN730_LOG_CHUNK_SIZE / 4;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	if (!ret)
+		memcpy(log_buf, output, SN730_LOG_CHUNK_SIZE);
+	return ret;
+}
+
+static int get_sn730_log_chunks(int fd, uint8_t* log_buf, uint32_t log_len, uint32_t subopcode)
+{
+	int ret = 0;
+	uint8_t* chunk_buf = NULL;
+	int remaining = log_len;
+	int curr_offset = 0;
+
+	if ((chunk_buf = (uint8_t*) malloc(sizeof (uint8_t) * SN730_LOG_CHUNK_SIZE)) == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		ret = -1;
+		goto out;
+	}
+
+	while (remaining > 0) {
+		memset(chunk_buf, 0, SN730_LOG_CHUNK_SIZE);
+		ret = wdc_do_get_sn730_log(fd, chunk_buf, curr_offset, subopcode);
+		if (!ret) {
+			if (remaining >= SN730_LOG_CHUNK_SIZE) {
+				memcpy(log_buf + (curr_offset * SN730_LOG_CHUNK_SIZE),
+						chunk_buf, SN730_LOG_CHUNK_SIZE);
+			} else {
+				memcpy(log_buf + (curr_offset * SN730_LOG_CHUNK_SIZE),
+						chunk_buf, remaining);
+			}
+			remaining -= SN730_LOG_CHUNK_SIZE;
+			curr_offset += 1;
+		} else
+			goto out;
+	}
+out:
+	free(chunk_buf);
+	return ret;
+}
+
+static int wdc_do_sn730_get_and_tar(int fd, char * outputName)
+{
+	int ret = 0;
+	void *retPtr;
+	uint8_t* full_log_buf = NULL;
+	uint8_t* key_log_buf = NULL;
+	uint8_t* core_dump_log_buf = NULL;
+	uint8_t* extended_log_buf = NULL;
+	uint32_t full_log_len = 0;
+	uint32_t key_log_len = 0;
+	uint32_t core_dump_log_len = 0;
+	uint32_t extended_log_len = 0;
+	tarfile_metadata* tarInfo = NULL;
+
+	tarInfo = (struct tarfile_metadata*) malloc(sizeof(tarfile_metadata));
+	if (tarInfo == NULL) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		ret = -1;
+		goto free_buf;
+	}
+	memset(tarInfo, 0, sizeof(tarfile_metadata));
+
+	/* Create Logs directory  */
+	wdc_UtilsGetTime(&tarInfo->timeInfo);
+	memset(tarInfo->timeString, 0, sizeof(tarInfo->timeString));
+	wdc_UtilsSnprintf((char*)tarInfo->timeString, MAX_PATH_LEN, "%02u%02u%02u_%02u%02u%02u",
+			tarInfo->timeInfo.year, tarInfo->timeInfo.month, tarInfo->timeInfo.dayOfMonth,
+			tarInfo->timeInfo.hour, tarInfo->timeInfo.minute, tarInfo->timeInfo.second);
+
+	wdc_UtilsSnprintf((char*)tarInfo->bufferFolderName, MAX_PATH_LEN, "%s",
+			(char*)outputName);
+
+	retPtr = getcwd((char*)tarInfo->currDir, MAX_PATH_LEN);
+	if (retPtr != NULL)
+		wdc_UtilsSnprintf((char*)tarInfo->bufferFolderPath, MAX_PATH_LEN, "%s%s%s",
+				(char *)tarInfo->currDir, WDC_DE_PATH_SEPARATOR, (char *)tarInfo->bufferFolderName);
+	else {
+		fprintf(stderr, "ERROR : WDC : get current working directory failed\n");
+		goto free_buf;
+	}
+
+	ret = wdc_UtilsCreateDir((char*)tarInfo->bufferFolderPath);
+	if (ret)
+	{
+		fprintf(stderr, "ERROR : WDC : create directory failed, ret = %d, dir = %s\n", ret, tarInfo->bufferFolderPath);
+		goto free_buf;
+	} else {
+		fprintf(stderr, "Stored log files in directory: %s\n", tarInfo->bufferFolderPath);
+	}
+
+	ret = wdc_do_get_sn730_log_len(fd, &full_log_len, SN730_GET_FULL_LOG_LENGTH);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+	ret = wdc_do_get_sn730_log_len(fd, &key_log_len, SN730_GET_KEY_LOG_LENGTH);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+	ret = wdc_do_get_sn730_log_len(fd, &core_dump_log_len, SN730_GET_COREDUMP_LOG_LENGTH);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+	ret = wdc_do_get_sn730_log_len(fd, &extended_log_len, SN730_GET_EXTENDED_LOG_LENGTH);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+
+	full_log_buf = (uint8_t*) calloc(full_log_len, sizeof (uint8_t));
+	key_log_buf = (uint8_t*) calloc(key_log_len, sizeof (uint8_t));
+	core_dump_log_buf = (uint8_t*) calloc(core_dump_log_len, sizeof (uint8_t));
+	extended_log_buf = (uint8_t*) calloc(extended_log_len, sizeof (uint8_t));
+
+	if (!full_log_buf || !key_log_buf || !core_dump_log_buf || !extended_log_buf) {
+		fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
+		ret = -1;
+		goto free_buf;
+	}
+
+	/* Get the full log */
+	ret = get_sn730_log_chunks(fd, full_log_buf, full_log_len, SN730_GET_FULL_LOG_SUBOPCODE);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+
+	/* Get the key log */
+	ret = get_sn730_log_chunks(fd, key_log_buf, key_log_len, SN730_GET_KEY_LOG_SUBOPCODE);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+
+	/* Get the core dump log */
+	ret = get_sn730_log_chunks(fd, core_dump_log_buf, core_dump_log_len, SN730_GET_CORE_LOG_SUBOPCODE);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+
+	/* Get the extended log */
+	ret = get_sn730_log_chunks(fd, extended_log_buf, extended_log_len, SN730_GET_EXTEND_LOG_SUBOPCODE);
+	if (ret) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+		goto free_buf;
+	}
+
+	/* Write log files */
+	wdc_UtilsSnprintf(tarInfo->fileName, MAX_PATH_LEN, "%s%s%s_%s.bin", (char*)tarInfo->bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+			"full_log", (char*)tarInfo->timeString);
+	wdc_WriteToFile(tarInfo->fileName, (char*)full_log_buf, full_log_len);
+
+	wdc_UtilsSnprintf(tarInfo->fileName, MAX_PATH_LEN, "%s%s%s_%s.bin", (char*)tarInfo->bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+			"key_log", (char*)tarInfo->timeString);
+	wdc_WriteToFile(tarInfo->fileName, (char*)key_log_buf, key_log_len);
+
+	wdc_UtilsSnprintf(tarInfo->fileName, MAX_PATH_LEN, "%s%s%s_%s.bin", (char*)tarInfo->bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+			"core_dump_log", (char*)tarInfo->timeString);
+	wdc_WriteToFile(tarInfo->fileName, (char*)core_dump_log_buf, core_dump_log_len);
+
+	wdc_UtilsSnprintf(tarInfo->fileName, MAX_PATH_LEN, "%s%s%s_%s.bin", (char*)tarInfo->bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+			"extended_log", (char*)tarInfo->timeString);
+	wdc_WriteToFile(tarInfo->fileName, (char*)extended_log_buf, extended_log_len);
+
+	/* Tar the log directory */
+	wdc_UtilsSnprintf(tarInfo->tarFileName, sizeof(tarInfo->tarFileName), "%s%s", (char*)tarInfo->bufferFolderPath, WDC_DE_TAR_FILE_EXTN);
+	wdc_UtilsSnprintf(tarInfo->tarFiles, sizeof(tarInfo->tarFiles), "%s%s%s", (char*)tarInfo->bufferFolderName, WDC_DE_PATH_SEPARATOR, WDC_DE_TAR_FILES);
+	wdc_UtilsSnprintf(tarInfo->tarCmd, sizeof(tarInfo->tarCmd), "%s %s %s", WDC_DE_TAR_CMD, (char*)tarInfo->tarFileName, (char*)tarInfo->tarFiles);
+
+	ret = system(tarInfo->tarCmd);
+
+	if (ret)
+		fprintf(stderr, "ERROR : WDC : Tar of log data failed, ret = %d\n", ret);
+
+free_buf:
+	free(tarInfo);
+	free(full_log_buf);
+	free(core_dump_log_buf);
+	free(key_log_buf);
+	free(extended_log_buf);
+	return ret;
+}
+
 static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command,
                struct plugin *plugin)
 {
@@ -1111,6 +1375,8 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 	if ((capabilities & WDC_DRIVE_CAP_INTERNAL_LOG) == WDC_DRIVE_CAP_INTERNAL_LOG) {
 		snprintf(f + strlen(f), PATH_MAX, "%s", ".bin");
 		return wdc_do_cap_diag(fd, f, xfer_size);
+	} else if ((capabilities & WDC_SN730_CAP_VUC_LOG) == WDC_SN730_CAP_VUC_LOG) {
+		return wdc_do_sn730_get_and_tar(fd, f);
 	} else {
 		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
 		return -1;
-- 
2.7.4
