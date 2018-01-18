From: jeff.lien@wdc.com (Jeff Lien)
Date: Thu, 18 Jan 2018 13:21:38 -0600
Subject: [PATCH 1/2] NVMe-CLI WDC-Plugin Add drive-essentials command
Message-ID: <20180118192138.32745-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 Makefile    |   2 +-
 wdc-nvme.c  | 940 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 wdc-nvme.h  |   1 +
 wdc-utils.c | 165 +++++++++++
 wdc-utils.h |  81 ++++++
 5 files changed, 1183 insertions(+), 6 deletions(-)
 create mode 100644 wdc-utils.c
 create mode 100644 wdc-utils.h

diff --git a/Makefile b/Makefile
index cc74bdd..c06bec8 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ NVME_DPKG_VERSION=1~`lsb_release -sc`
 
 OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o \
 	nvme-lightnvm.o fabrics.o json.o plugin.o intel-nvme.o \
-	lnvm-nvme.o memblaze-nvme.o wdc-nvme.o nvme-models.o huawei-nvme.o
+	lnvm-nvme.o memblaze-nvme.o wdc-nvme.o wdc-utils.o nvme-models.o huawei-nvme.o
 
 nvme: nvme.c nvme.h $(OBJS) NVME-VERSION-FILE
 	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c -o $(NVME) $(OBJS) $(LDFLAGS)
diff --git a/wdc-nvme.c b/wdc-nvme.c
index 62cf59d..9affaf0 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015-2017 Western Digital Corporation or its affiliates.
+ * Copyright (c) 2015-2018 Western Digital Corporation or its affiliates.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -17,7 +17,8 @@
  * MA  02110-1301, USA.
  *
  *   Author: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>,
- *           Dong Ho <dong.ho at hgst.com>
+ *           Dong Ho <dong.ho at hgst.com>,
+ *           Jeff Lien <jeff.lien at wdc.com>
  */
 #include <stdio.h>
 #include <string.h>
@@ -41,6 +42,7 @@
 #include <sys/ioctl.h>
 #define CREATE_CMD
 #include "wdc-nvme.h"
+#include "wdc-utils.h"
 
 #define WRITE_SIZE	(sizeof(__u8) * 4096)
 
@@ -49,9 +51,11 @@
 #define WDC_NVME_LOG_SIZE_DATA_LEN			0x08
 
 /* Device Config */
-#define WDC_NVME_VID  			0x1c58
-#define WDC_NVME_SN100_CNTL_ID	0x0003
-#define WDC_NVME_SN200_CNTL_ID	0x0023
+#define WDC_NVME_VID  					0x1c58
+#define WDC_NVME_SN100_CNTL_ID			0x0003
+#define WDC_NVME_SN200_CNTL_ID			0x0023
+#define WDC_NVME_SNDK_VID		        0x15b7
+#define WDC_NVME_SXSLCL_CNTRL_ID		0x0000
 
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -117,6 +121,160 @@
 #define WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE			0xCA
 #define WDC_CA_LOG_BUF_LEN							0x80
 
+/* Drive Essentials */
+#define WDC_DE_DEFAULT_NUMBER_OF_ERROR_ENTRIES		64
+#define WDC_DE_GENERIC_BUFFER_SIZE					80
+#define WDC_DE_GLOBAL_NSID							0xFFFFFFFF
+#define WDC_DE_DEFAULT_NAMESPACE_ID					0x01
+#define WDC_DE_PATH_SEPARATOR						"/"
+#define WDC_DE_TAR_FILES							"*.bin"
+#define WDC_DE_TAR_FILE_EXTN						".tar.gz"
+#define WDC_DE_TAR_CMD								"tar -czf"
+
+/* VU Opcodes */
+#define WDC_DE_VU_READ_SIZE_OPCODE					0xC0
+#define WDC_DE_VU_READ_BUFFER_OPCODE				0xC2
+
+#define WDC_DE_FILE_HEADER_SIZE                     4
+#define WDC_DE_FILE_OFFSET_SIZE                     2
+#define WDC_DE_FILE_NAME_SIZE                       32
+#define WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET		0x8000
+#define WDC_DE_READ_MAX_TRANSFER_SIZE				0x8000
+
+#define WDC_DE_MANUFACTURING_INFO_PAGE_FILE_NAME	"manufacturing_info"  /* Unique log entry page name. */
+#define WDC_DE_CORE_DUMP_FILE_NAME					"core_dump"
+#define WDC_DE_EVENT_LOG_FILE_NAME					"event_log"
+#define WDC_DE_DESTN_SPI							1
+#define WDC_DE_DUMPTRACE_DESTINATION				6
+
+typedef enum _NVME_FEATURES_SELECT
+{
+    FS_CURRENT                      = 0,
+    FS_DEFAULT                      = 1,
+    FS_SAVED                        = 2,
+    FS_SUPPORTED_CAPBILITIES        = 3
+} NVME_FEATURES_SELECT;
+
+typedef enum _NVME_FEATURE_IDENTIFIERS
+{
+    FID_ARBITRATION                                 = 0x01,
+    FID_POWER_MANAGEMENT                            = 0x02,
+    FID_LBA_RANGE_TYPE                              = 0x03,
+    FID_TEMPERATURE_THRESHOLD                       = 0x04,
+    FID_ERROR_RECOVERY                              = 0x05,
+    FID_VOLATILE_WRITE_CACHE                        = 0x06,
+    FID_NUMBER_OF_QUEUES                            = 0x07,
+    FID_INTERRUPT_COALESCING                        = 0x08,
+    FID_INTERRUPT_VECTOR_CONFIGURATION              = 0x09,
+    FID_WRITE_ATOMICITY                             = 0x0A,
+    FID_ASYNCHRONOUS_EVENT_CONFIGURATION            = 0x0B,
+    FID_AUTONOMOUS_POWER_STATE_TRANSITION           = 0x0C,
+/*Below FID's are NVM Command Set Specific*/
+    FID_SOFTWARE_PROGRESS_MARKER                    = 0x80,
+    FID_HOST_IDENTIFIER                             = 0x81,
+    FID_RESERVATION_NOTIFICATION_MASK               = 0x82,
+    FID_RESERVATION_PERSISTENCE                     = 0x83
+} NVME_FEATURE_IDENTIFIERS;
+
+typedef enum
+{
+	WDC_DE_TYPE_IDENTIFY            = 0x1,
+	WDC_DE_TYPE_SMARTATTRIBUTEDUMP  = 0x2,
+	WDC_DE_TYPE_EVENTLOG            = 0x4,
+	WDC_DE_TYPE_DUMPTRACE           = 0x8,
+	WDC_DE_TYPE_DUMPSNAPSHOT        = 0x10,
+	WDC_DE_TYPE_ATA_LOGS            = 0x20,
+	WDC_DE_TYPE_SMART_LOGS          = 0x40,
+	WDC_DE_TYPE_SCSI_LOGS           = 0x80,
+	WDC_DE_TYPE_SCSI_MODE_PAGES     = 0x100,
+	WDC_DE_TYPE_NVMe_FEATURES       = 0x200,
+	WDC_DE_TYPE_DUMPSMARTERRORLOG3  = 0x400,
+	WDC_DE_TYPE_DUMPLOG3E           = 0x800,
+	WDC_DE_TYPE_DUMPSCRAM           = 0x1000,
+	WDC_DE_TYPE_PCU_LOG             = 0x2000,
+	WDC_DE_TYPE_DUMP_ERROR_LOGS     = 0x4000,
+	WDC_DE_TYPE_FW_SLOT_LOGS        = 0x8000,
+	WDC_DE_TYPE_MEDIA_SETTINGS      = 0x10000,
+	WDC_DE_TYPE_SMART_DATA          = 0x20000,
+	WDC_DE_TYPE_NVME_SETTINGS       = 0x40000,
+	WDC_DE_TYPE_NVME_ERROR_LOGS     = 0x80000,
+	WDC_DE_TYPE_NVME_LOGS           = 0x100000,
+	WDC_DE_TYPE_UART_LOGS           = 0x200000,
+	WDC_DE_TYPE_DLOGS_SPI           = 0x400000,
+	WDC_DE_TYPE_DLOGS_RAM           = 0x800000,
+	WDC_DE_TYPE_NVME_MANF_INFO      = 0x2000000,
+	WDC_DE_TYPE_NONE                = 0x1000000,
+	WDC_DE_TYPE_ALL                 = 0xFFFFFFF,
+} WDC_DRIVE_ESSENTIAL_TYPE;
+
+typedef struct __attribute__((__packed__)) _WDC_DE_VU_FILE_META_DATA
+{
+    __u8 fileName[WDC_DE_FILE_NAME_SIZE];
+    __u16 fileID;
+    __u64 fileSize;
+} WDC_DE_VU_FILE_META_DATA, *PWDC_DE_VU_FILE_META_DATA;
+
+typedef struct _WDC_DRIVE_ESSENTIALS
+{
+    WDC_DE_VU_FILE_META_DATA metaData;
+    WDC_DRIVE_ESSENTIAL_TYPE essentialType;
+} WDC_DRIVE_ESSENTIALS;
+
+typedef struct _WDC_DE_VU_LOG_DIRECTORY
+{
+    WDC_DRIVE_ESSENTIALS *logEntry;		/* Caller to allocate memory        */
+    __u32 maxNumLogEntries; 			/* Caller to input memory allocated */
+    __u32 numOfValidLogEntries;			/* API will output this value       */
+} WDC_DE_VU_LOG_DIRECTORY,*PWDC_DE_VU_LOG_DIRECTORY;
+
+typedef struct _WDC_DE_CSA_FEATURE_ID_LIST
+{
+    NVME_FEATURE_IDENTIFIERS featureId;
+    __u8 featureName[WDC_DE_GENERIC_BUFFER_SIZE];
+} WDC_DE_CSA_FEATURE_ID_LIST;
+
+WDC_DE_CSA_FEATURE_ID_LIST deFeatureIdList[] =
+{
+	{0x00                                   , "Dummy Placeholder"},
+	{FID_ARBITRATION                        , "Arbitration"},
+	{FID_POWER_MANAGEMENT                   , "PowerMgmnt"},
+	{FID_LBA_RANGE_TYPE                     , "LbaRangeType"},
+	{FID_TEMPERATURE_THRESHOLD              , "TempThreshold"},
+	{FID_ERROR_RECOVERY                     , "ErrorRecovery"},
+	{FID_VOLATILE_WRITE_CACHE               , "VolatileWriteCache"},
+	{FID_NUMBER_OF_QUEUES                   , "NumOfQueues"},
+	{FID_INTERRUPT_COALESCING               , "InterruptCoalesing"},
+	{FID_INTERRUPT_VECTOR_CONFIGURATION     , "InterruptVectorConfig"},
+	{FID_WRITE_ATOMICITY                    , "WriteAtomicity"},
+	{FID_ASYNCHRONOUS_EVENT_CONFIGURATION   , "AsynEventConfig"},
+	{FID_AUTONOMOUS_POWER_STATE_TRANSITION  , "AutonomousPowerState"},
+};
+
+typedef enum _NVME_VU_DE_LOGPAGE_NAMES
+{
+    NVME_DE_LOGPAGE_E3 = 0x01,
+    NVME_DE_LOGPAGE_C0 = 0x02
+} NVME_VU_DE_LOGPAGE_NAMES;
+typedef struct _NVME_VU_DE_LOGPAGE_LIST
+{
+    NVME_VU_DE_LOGPAGE_NAMES logPageName;
+    __u32 logPageId;
+    __u32 logPageLen;
+    char  logPageIdStr[4];
+} NVME_VU_DE_LOGPAGE_LIST, *PNVME_VU_DE_LOGPAGE_LIST;
+
+typedef struct _WDC_NVME_DE_VU_LOGPAGES
+{
+    NVME_VU_DE_LOGPAGE_NAMES vuLogPageReqd;
+    __u32 numOfVULogPages;
+} WDC_NVME_DE_VU_LOGPAGES, *PWDC_NVME_DE_VU_LOGPAGES;
+
+NVME_VU_DE_LOGPAGE_LIST deVULogPagesList[] =
+{
+    { NVME_DE_LOGPAGE_E3, 0xE3, 1072, "0xe3"},
+    { NVME_DE_LOGPAGE_C0, 0xC0, 512, "0xc0"}
+};
+
 static int wdc_get_serial_name(int fd, char *file, size_t len, char *suffix);
 static int wdc_create_log_file(char *file, __u8 *drive_log_data,
 		__u32 drive_log_length);
@@ -136,6 +294,9 @@ static int wdc_purge(int argc, char **argv,
 static int wdc_purge_monitor(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
 static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
+static int wdc_do_drive_essentials(int fd, char *dir, char *key);
+static int wdc_drive_essentials(int argc, char **argv, struct command *command,
+		struct plugin *plugin);
 
 /* Drive log data size */
 struct wdc_log_size {
@@ -258,12 +419,37 @@ static int wdc_check_device(int fd)
 		((le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN100_CNTL_ID) ||
 		(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN200_CNTL_ID)))
 		ret = 0;
+	else if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
+			(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SXSLCL_CNTRL_ID))
+		ret = 0;
 	else
 		fprintf(stderr, "WARNING : WDC : Device not supported\n");
 
 	return ret;
 }
 
+static int wdc_check_device_sxslcl(int fd)
+{
+	int ret;
+	struct nvme_id_ctrl ctrl;
+
+	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
+	ret = nvme_identify_ctrl(fd, &ctrl);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
+				"0x%x\n", ret);
+		return -1;
+	}
+	ret = -1;
+
+	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
+	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
+			(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SXSLCL_CNTRL_ID))
+		ret = 0;
+
+	return ret;
+}
+
 static bool wdc_check_device_sn100(int fd)
 {
 	bool ret;
@@ -1275,3 +1461,747 @@ static int wdc_smart_add_log(int argc, char **argv, struct command *command,
 
 	return 0;
 }
+
+static int wdc_get_serial_and_fw_rev(int fd, char *sn, char *fw_rev)
+{
+	int i;
+	int ret;
+	struct nvme_id_ctrl ctrl;
+
+	i = sizeof (ctrl.sn) - 1;
+	memset(sn, 0, WDC_SERIAL_NO_LEN);
+	memset(fw_rev, 0, WDC_NVME_FIRMWARE_REV_LEN);
+	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
+	ret = nvme_identify_ctrl(fd, &ctrl);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
+				"0x%x\n", ret);
+		return -1;
+	}
+	/* Remove trailing spaces from the name */
+	while (i && ctrl.sn[i] == ' ') {
+		ctrl.sn[i] = '\0';
+		i--;
+	}
+	snprintf(sn, WDC_SERIAL_NO_LEN, "%s", ctrl.sn);
+	snprintf(fw_rev, WDC_NVME_FIRMWARE_REV_LEN, "%s", ctrl.fr);
+
+	return 0;
+}
+
+static int wdc_get_max_transfer_len(int fd, __u32 *maxTransferLen)
+{
+	int ret = 0;
+	struct nvme_id_ctrl ctrl;
+
+	__u32 maxTransferLenDevice = 0;
+	/*__u32 maxTransferLenHost = 0;    * do we need to get the host max transfer length?? */
+
+	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
+	ret = nvme_identify_ctrl(fd, &ctrl);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed 0x%x\n", ret);
+		return -1;
+	}
+
+	maxTransferLenDevice = (1 << ctrl.mdts) * getpagesize();
+	*maxTransferLen = maxTransferLenDevice;
+
+	/*
+    if( maxTransferLenDevice < maxTransferLenHost)
+	    *maxTransferLen = maxTransferLenDevice;
+    else
+	    *maxTransferLen = maxTransferLenHost;
+	*/
+
+	return ret;
+}
+
+int wdc_de_VU_read_size(int fd, __u32 fileId, __u16 spiDestn, __u32* logSize)
+{
+	int ret = WDC_STATUS_FAILURE;
+	struct nvme_admin_cmd cmd;
+
+	if(!fd || !logSize )
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		goto end;
+	}
+
+	memset(&cmd,0,sizeof(struct nvme_admin_cmd));
+	cmd.opcode = WDC_DE_VU_READ_SIZE_OPCODE;
+	cmd.nsid = WDC_DE_DEFAULT_NAMESPACE_ID;
+	cmd.cdw13 = fileId<<16;
+	cmd.cdw14 = spiDestn;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+
+	if (!ret && logSize)
+		*logSize = cmd.result;
+	if( ret != WDC_STATUS_SUCCESS)
+		fprintf(stderr, "ERROR : WDC : VUReadSize() failed, status:%s(0x%x)\n", nvme_status_to_string(ret), ret);
+
+	end:
+	return ret;
+}
+
+int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDwords, __u8* dataBuffer, __u32* bufferSize)
+{
+	int ret = WDC_STATUS_FAILURE;
+	struct nvme_admin_cmd cmd;
+	__u32 noOfDwordExpected = 0;
+
+	if(!fd || !dataBuffer || !bufferSize)
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		goto end;
+	}
+
+	memset(&cmd,0,sizeof(struct nvme_admin_cmd));
+	noOfDwordExpected = *bufferSize/sizeof(__u32);
+	cmd.opcode = WDC_DE_VU_READ_BUFFER_OPCODE;
+	cmd.nsid = WDC_DE_DEFAULT_NAMESPACE_ID;
+	cmd.cdw10 = noOfDwordExpected;
+	cmd.cdw13 = fileId<<16;
+	cmd.cdw14 = spiDestn;
+	cmd.cdw15 = offsetInDwords;
+
+	cmd.addr = (__u64)(__u64)(uintptr_t)dataBuffer;
+	cmd.data_len = *bufferSize;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+
+	if( ret != WDC_STATUS_SUCCESS)
+		fprintf(stderr, "ERROR : WDC : VUReadBuffer() failed, status:%s(0x%x)\n", nvme_status_to_string(ret), ret);
+
+	end:
+	return ret;
+}
+
+int wdc_get_log_dir_max_entries(int fd, __u32* maxNumOfEntries)
+{
+    int     		ret = WDC_STATUS_FAILURE;
+    __u32           headerPayloadSize = 0;
+    __u8*           fileIdOffsetsBuffer = NULL;
+    __u32           fileIdOffsetsBufferSize = 0;
+    __u32           fileNum = 0;
+    __u16           fileOffset = 0;
+
+
+    if (!fd || !maxNumOfEntries)
+    {
+        ret = WDC_STATUS_INVALID_PARAMETER;
+        return ret;
+    }
+    /* 1.Get log directory first four bytes */
+    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, (__u32*)&headerPayloadSize)))
+    {
+		fprintf(stderr, "ERROR : WDC : %s: Failed to get headerPayloadSize from file directory 0x%x\n",
+				__func__, ret);
+        goto end;
+    }
+
+    fileIdOffsetsBufferSize = WDC_DE_FILE_HEADER_SIZE + (headerPayloadSize * WDC_DE_FILE_OFFSET_SIZE);
+    fileIdOffsetsBuffer = (__u8*)calloc(1, fileIdOffsetsBufferSize);
+
+    /* 2.Read to get file offsets */
+    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileIdOffsetsBuffer, &fileIdOffsetsBufferSize)))
+    {
+		fprintf(stderr, "ERROR : WDC : %s: Failed to get fileIdOffsets from file directory 0x%x\n",
+				__func__, ret);
+        goto end;
+    }
+    /* 3.Determine valid entries */
+    for (fileNum = 0; fileNum < (headerPayloadSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
+    {
+        fileOffset = (fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE)] << 8) +
+            fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE) + 1];
+        if (!fileOffset)
+            continue;
+        (*maxNumOfEntries)++;
+    }
+end:
+    if (!fileIdOffsetsBuffer)
+        free(fileIdOffsetsBuffer);
+    return ret;
+}
+
+WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
+{
+	WDC_DRIVE_ESSENTIAL_TYPE essentialType = WDC_DE_TYPE_NONE;
+
+	if (wdc_UtilsStrCompare((char*)fileName, WDC_DE_CORE_DUMP_FILE_NAME) == 0)
+	{
+		essentialType = WDC_DE_TYPE_DUMPSNAPSHOT;
+	}
+	else if (wdc_UtilsStrCompare((char*)fileName, WDC_DE_EVENT_LOG_FILE_NAME) == 0)
+	{
+		essentialType = WDC_DE_TYPE_EVENTLOG;
+	}
+	else if (wdc_UtilsStrCompare((char*)fileName, WDC_DE_MANUFACTURING_INFO_PAGE_FILE_NAME) == 0)
+	{
+		essentialType = WDC_DE_TYPE_NVME_MANF_INFO;
+	}
+
+	return essentialType;
+}
+
+int wdc_fetch_log_directory(int fd, PWDC_DE_VU_LOG_DIRECTORY directory)
+{
+    int             ret = WDC_STATUS_FAILURE;
+    __u8            *fileOffset = NULL;
+    __u8            *fileDirectory = NULL;
+    __u32           headerSize = 0;
+    __u32           fileNum = 0, startIdx = 0;
+    __u16           fileOffsetTemp = 0;
+    __u32           entryId = 0;
+    __u32           fileDirectorySize = 0;
+
+    if (!fd || !directory)
+    {
+        ret = WDC_STATUS_INVALID_PARAMETER;
+        goto end;
+    }
+
+    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, &fileDirectorySize)))
+    {
+		fprintf(stderr, "ERROR : WDC : %s: Failed to get filesystem directory size, ret = %d\n",
+				__func__, ret);
+        goto end;
+    }
+
+    fileDirectory = (__u8*)calloc(1, fileDirectorySize);
+    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileDirectory, &fileDirectorySize)))
+    {
+		fprintf(stderr, "ERROR : WDC : %s: Failed to get filesystem directory, ret = %d\n",
+				__func__, ret);
+        goto end;
+    }
+
+    /* First four bytes of header directory is headerSize */
+    memcpy(&headerSize, fileDirectory, WDC_DE_FILE_HEADER_SIZE);
+
+    if (directory->maxNumLogEntries == 0) //minimum buffer for 1 entry is required
+    {
+        ret = WDC_STATUS_INVALID_PARAMETER;
+        goto end;
+    }
+
+    for (fileNum = 0; fileNum < (headerSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
+    {
+        if (entryId >= directory->maxNumLogEntries)
+            break;
+        startIdx = WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE);
+        memcpy(&fileOffsetTemp, fileDirectory + startIdx, sizeof(fileOffsetTemp));
+        fileOffset = fileDirectory + fileOffsetTemp;
+
+        if (0 == fileOffsetTemp)
+        {
+            continue;
+        }
+
+        memset(&directory->logEntry[entryId], 0, sizeof(WDC_DRIVE_ESSENTIALS));
+        memcpy(&directory->logEntry[entryId].metaData, fileOffset, sizeof(WDC_DE_VU_FILE_META_DATA));
+        directory->logEntry[entryId].metaData.fileName[WDC_DE_FILE_NAME_SIZE - 1] = '\0';
+        wdc_UtilsDeleteCharFromString((char*)directory->logEntry[entryId].metaData.fileName, WDC_DE_FILE_NAME_SIZE, ' ');
+        if (0 == directory->logEntry[entryId].metaData.fileID)
+        {
+            continue;
+        }
+        directory->logEntry[entryId].essentialType = wdc_get_essential_type(directory->logEntry[entryId].metaData.fileName);
+        /*
+		fprintf(stderr, "WDC : %s: NVMe VU Log Entry %d, fileName = %s, fileSize = 0x%lx, fileId = 0x%x\n",
+				__func__, entryId, directory->logEntry[entryId].metaData.fileName,
+				(long unsigned int)directory->logEntry[entryId].metaData.fileSize, directory->logEntry[entryId].metaData.fileID);
+		*/
+        entryId++;
+    }
+    directory->numOfValidLogEntries = entryId;
+end:
+    if (fileDirectory != NULL)
+        free(fileDirectory);
+
+    return ret;
+}
+
+int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 fileSize, __u8* dataBuffer)
+{
+	int ret = WDC_STATUS_FAILURE;
+	__u32                     chunckSize = WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET;
+	__u32                     maximumTransferLength = 0;
+	__u32                     buffSize = 0;
+	__u64                     offsetIdx = 0;
+
+	if (!fd || !dataBuffer || !fileSize)
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		goto end;
+	}
+
+	wdc_get_max_transfer_len(fd, &maximumTransferLength);
+
+	/* Fetch Log File Data */
+	if ((fileSize >= maximumTransferLength) || (fileSize > 0xffffffff))
+	{
+		chunckSize = WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET;
+    	if (maximumTransferLength < WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET)
+			chunckSize = maximumTransferLength;
+
+		buffSize = chunckSize;
+		for (offsetIdx = 0; (offsetIdx * chunckSize) < fileSize; offsetIdx++)
+		{
+			if (((offsetIdx * chunckSize) + buffSize) > fileSize)
+				buffSize = (__u32)(fileSize - (offsetIdx * chunckSize));
+			/* Limitation in VU read buffer - offsetIdx and bufferSize are not greater than u32 */
+			ret = wdc_de_VU_read_buffer(fd, fileId, spiDestn,
+				(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer + (offsetIdx * chunckSize), &buffSize);
+			if (ret != WDC_STATUS_SUCCESS)
+			{
+				fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_buffer failed with ret = %d, fileId = 0x%x, fileSize = 0x%lx\n",
+						__func__, ret, fileId, (long unsigned int)fileSize);
+				break;
+			}
+		}
+	} else {
+		buffSize = (__u32)fileSize;
+		ret = wdc_de_VU_read_buffer(fd, fileId, spiDestn,
+			(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer, &buffSize);
+		if (ret != WDC_STATUS_SUCCESS)
+		{
+			fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_buffer failed with ret = %d, fileId = 0x%x, fileSize = 0x%lx\n",
+					__func__, ret, fileId, (long unsigned int)fileSize);
+		}
+	}
+
+end:
+	return ret;
+}
+
+int wdc_de_get_dump_trace(int fd, char * filePath, __u16 binFileNameLen, char *binFileName)
+{
+	int                     ret = WDC_STATUS_FAILURE;
+	__u8                    *readBuffer = NULL;
+	__u32                   readBufferLen = 0;
+	__u32                   lastPktReadBufferLen = 0;
+	__u32                   maxTransferLen = 0;
+	__u32                   dumptraceSize = 0;
+	__u32                   chunkSize = 0;
+	__u32                   chunks = 0;
+	__u32                   offset = 0;
+	__u8                    loop = 0;
+	__u16					i = 0;
+	__u32                   maximumTransferLength = 0;
+
+	if (!fd || !binFileName || !filePath)
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		return ret;
+	}
+
+	wdc_get_max_transfer_len(fd, &maximumTransferLength);
+
+	do
+	{
+		/* Get dumptrace size */
+		ret = wdc_de_VU_read_size(fd, 0, WDC_DE_DUMPTRACE_DESTINATION, &dumptraceSize);
+		if (ret != WDC_STATUS_SUCCESS)
+		{
+			fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_size failed with ret = %d\n",
+					__func__, ret);
+			break;
+		}
+
+		/* Make sure the size requested is greater than dword */
+		if (dumptraceSize < 4)
+		{
+			ret = WDC_STATUS_FAILURE;
+			fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_size failed, read size is less than 4 bytes, dumptraceSize = 0x%x\n",
+					__func__, dumptraceSize);
+			break;
+		}
+
+		/* Choose the least max transfer length */
+		maxTransferLen = maximumTransferLength < WDC_DE_READ_MAX_TRANSFER_SIZE ? maximumTransferLength : WDC_DE_READ_MAX_TRANSFER_SIZE;
+
+		/* Comment from  FW Team:
+		 * The max non - block transfer size is 0xFFFF (16 bits allowed as the block size).Use 0x8000
+		 * to keep it on a word - boundary.
+		 * max_xfer = int(pow(2, id_data['MDTS'])) * 4096 # 4k page size as reported in pcie capabiltiies
+		 */
+		chunkSize = dumptraceSize < maxTransferLen ? dumptraceSize : maxTransferLen;
+		chunks = (dumptraceSize / maxTransferLen) + ((dumptraceSize % maxTransferLen) ? 1 : 0);
+
+		readBuffer = (unsigned char *)calloc(dumptraceSize, sizeof(unsigned char));
+		readBufferLen = chunkSize;
+		lastPktReadBufferLen = (dumptraceSize % maxTransferLen) ? (dumptraceSize % maxTransferLen) : chunkSize;
+
+		if (readBuffer == NULL)
+		{
+			fprintf(stderr, "ERROR : WDC : %s: readBuffer calloc failed\n", __func__);
+			ret = WDC_STATUS_INSUFFICIENT_MEMORY;
+			break;
+		}
+
+		for (i = 0; i < chunks; i++)
+		{
+			offset = ((i*chunkSize) / 4);
+
+			/* Last loop call, Assign readBufferLen to read only left over bytes */
+			if (i == (chunks - 1))
+			{
+				readBufferLen = lastPktReadBufferLen;
+			}
+
+			ret = wdc_de_VU_read_buffer(fd, 0, WDC_DE_DUMPTRACE_DESTINATION, 0, readBuffer + offset, &readBufferLen);
+			if (ret != WDC_STATUS_SUCCESS)
+			{
+				fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_buffer failed, ret = %d on offset 0x%x\n",
+						__func__, ret, offset);
+				break;
+			}
+		}
+	} while (loop);
+
+	if (ret == WDC_STATUS_SUCCESS)
+	{
+		ret = wdc_WriteToFile(binFileName, (char*)readBuffer, dumptraceSize);
+		if (ret != WDC_STATUS_SUCCESS)
+			fprintf(stderr, "ERROR : WDC : %s: wdc_WriteToFile failed, ret = %d\n", __func__, ret);
+	} else {
+		fprintf(stderr, "ERROR : WDC : %s: Read Buffer Loop failed, ret = %d\n", __func__, ret);
+	}
+
+	if (readBuffer)
+	{
+		free(readBuffer);
+	}
+
+	return ret;
+}
+
+static int wdc_do_drive_essentials(int fd, char *dir, char *key)
+{
+	int ret = 0;
+    void *retPtr;
+	char                      fileName[MAX_PATH_LEN];
+	__s8                      bufferFolderPath[MAX_PATH_LEN];
+	char                      bufferFolderName[MAX_PATH_LEN];
+	char                      tarFileName[MAX_PATH_LEN];
+	char                      tarFiles[MAX_PATH_LEN];
+	char                      tarCmd[MAX_PATH_LEN+MAX_PATH_LEN];
+	UtilsTimeInfo             timeInfo;
+	__u8                      timeString[MAX_PATH_LEN];
+	__u8                      serialNo[WDC_SERIAL_NO_LEN];
+	__u8                      firmwareRevision[WDC_NVME_FIRMWARE_REV_LEN];
+	__u8                      idSerialNo[WDC_SERIAL_NO_LEN];
+	__u8                      idFwRev[WDC_NVME_FIRMWARE_REV_LEN];
+	__u8                      featureIdBuff[4];
+	char                      currDir[MAX_PATH_LEN];
+	char                      *dataBuffer     = NULL;
+	__u32 					  elogNumEntries, elogBufferSize;
+	__u32 					  dataBufferSize;
+	__u32                     listIdx = 0;
+	__u32                     vuLogIdx = 0;
+	__u32 					  result;
+	__u32                     maxNumOfVUFiles = 0;
+	struct nvme_id_ctrl ctrl;
+	struct nvme_id_ns ns;
+	struct nvme_error_log_page *elogBuffer;
+	struct nvme_smart_log smart_log;
+	struct nvme_firmware_log_page fw_log;
+	PWDC_NVME_DE_VU_LOGPAGES vuLogInput = NULL;
+	WDC_DE_VU_LOG_DIRECTORY deEssentialsList;
+
+	memset(bufferFolderPath,0,sizeof(bufferFolderPath));
+	memset(bufferFolderName,0,sizeof(bufferFolderName));
+	memset(tarFileName,0,sizeof(tarFileName));
+	memset(tarFiles,0,sizeof(tarFiles));
+	memset(tarCmd,0,sizeof(tarCmd));
+	memset(&timeInfo,0,sizeof(timeInfo));
+	memset(&vuLogInput, 0, sizeof(vuLogInput));
+
+	if (wdc_get_serial_and_fw_rev(fd, (char *)idSerialNo, (char *)idFwRev))
+	{
+		fprintf(stderr, "ERROR : WDC : get serial # and fw revision failed\n");
+		return -1;
+	} else {
+		fprintf(stderr, "Get Drive Essentials Data for device serial #: %s and fw revision: %s\n",
+				idSerialNo, idFwRev);
+	}
+
+	/* Create Drive Essentials directory  */
+	wdc_UtilsGetTime(&timeInfo);
+	memset(timeString, 0, sizeof(timeString));
+	wdc_UtilsSnprintf((char*)timeString, MAX_PATH_LEN, "%02u%02u%02u_%02u%02u%02u",
+			timeInfo.year, timeInfo.month, timeInfo.dayOfMonth,
+			timeInfo.hour, timeInfo.minute, timeInfo.second);
+
+	wdc_UtilsSnprintf((char*)serialNo,WDC_SERIAL_NO_LEN,(char*)idSerialNo);
+	/* Remove any space form serialNo */
+	wdc_UtilsDeleteCharFromString((char*)serialNo, WDC_SERIAL_NO_LEN, ' ');
+
+	memset(firmwareRevision, 0, sizeof(firmwareRevision));
+	wdc_UtilsSnprintf((char*)firmwareRevision, WDC_NVME_FIRMWARE_REV_LEN, (char*)idFwRev);
+	/* Remove any space form FirmwareRevision */
+	wdc_UtilsDeleteCharFromString((char*)firmwareRevision, WDC_NVME_FIRMWARE_REV_LEN, ' ');
+
+	wdc_UtilsSnprintf((char*)bufferFolderName, MAX_PATH_LEN, "%s_%s_%s_%s",
+			"DRIVE_ESSENTIALS", (char*)serialNo, (char*)firmwareRevision, (char*)timeString);
+
+	if (dir != NULL) {
+		wdc_UtilsSnprintf((char*)bufferFolderPath, MAX_PATH_LEN, "%s%s%s",
+				(char *)dir, WDC_DE_PATH_SEPARATOR, (char *)bufferFolderName);
+	} else {
+		retPtr = getcwd((char*)currDir, MAX_PATH_LEN);
+		if (retPtr != NULL)
+			wdc_UtilsSnprintf((char*)bufferFolderPath, MAX_PATH_LEN, "%s%s%s",
+				(char *)currDir, WDC_DE_PATH_SEPARATOR, (char *)bufferFolderName);
+		else {
+			fprintf(stderr, "ERROR : WDC : get current working directory failed\n");
+			return -1;
+		}
+	}
+
+	ret = wdc_UtilsCreateDir((char*)bufferFolderPath);
+	if (ret != 0)
+	{
+		fprintf(stderr, "ERROR : WDC : create directory failed, ret = %d, dir = %s\n", ret, bufferFolderPath);
+		return -1;
+	} else {
+		fprintf(stderr, "Store Drive Essentials bin files in directory: %s\n", bufferFolderPath);
+	}
+
+	/* Get Identify Controller Data */
+	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
+	ret = nvme_identify_ctrl(fd, &ctrl);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed, ret = %d\n", ret);
+		return -1;
+	} else {
+		wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+				"IdentifyController", (char*)serialNo, (char*)timeString);
+		wdc_WriteToFile(fileName, (char*)&ctrl, sizeof (struct nvme_id_ctrl));
+	}
+
+	memset(&ns, 0, sizeof (struct nvme_id_ns));
+	ret = nvme_identify_ns(fd, 1, 0, &ns);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_identify_ns() failed, ret = %d\n", ret);
+	} else {
+		wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+				"IdentifyNamespace", (char*)serialNo, (char*)timeString);
+		wdc_WriteToFile(fileName, (char*)&ns, sizeof (struct nvme_id_ns));
+	}
+
+	/* Get Log Pages (0x01, 0x02, 0x03, 0xC0 and 0xE3) */
+	elogNumEntries = WDC_DE_DEFAULT_NUMBER_OF_ERROR_ENTRIES;
+	elogBufferSize = elogNumEntries*sizeof(struct nvme_error_log_page);
+	dataBuffer = calloc(1, elogBufferSize);
+	elogBuffer = (struct nvme_error_log_page *)dataBuffer;
+
+	ret = nvme_error_log(fd, 0, elogNumEntries, elogBuffer);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_error_log() failed, ret = %d\n", ret);
+	} else {
+		wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+				"ErrorLog", (char*)serialNo, (char*)timeString);
+		wdc_WriteToFile(fileName, (char*)elogBuffer, elogBufferSize);
+	}
+
+	free(dataBuffer);
+	dataBuffer = NULL;
+
+	/* Get Smart log page  */
+	memset(&smart_log, 0, sizeof (struct nvme_smart_log));
+	ret = nvme_smart_log(fd, 0xffffffff, &smart_log);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_smart_log() failed, ret = %d\n", ret);
+	} else {
+		wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+				"SmartLog", (char*)serialNo, (char*)timeString);
+		wdc_WriteToFile(fileName, (char*)&smart_log, sizeof(struct nvme_smart_log));
+	}
+
+	/* Get FW Slot log page  */
+	memset(&fw_log, 0, sizeof (struct nvme_firmware_log_page));
+	ret = nvme_fw_log(fd, &fw_log);
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : nvme_fw_log() failed, ret = %d\n", ret);
+	} else {
+		wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+				"FwSLotLog", (char*)serialNo, (char*)timeString);
+		wdc_WriteToFile(fileName, (char*)&fw_log, sizeof(struct nvme_firmware_log_page));
+	}
+
+	/* Get VU log pages  */
+	/* define inputs for vendor unique log pages */
+	vuLogInput = (PWDC_NVME_DE_VU_LOGPAGES)calloc(1, sizeof(WDC_NVME_DE_VU_LOGPAGES));
+	vuLogInput->numOfVULogPages = sizeof(deVULogPagesList) / sizeof(deVULogPagesList[0]);
+
+	for (vuLogIdx = 0; vuLogIdx < vuLogInput->numOfVULogPages; vuLogIdx++)
+	{
+		dataBufferSize = deVULogPagesList[vuLogIdx].logPageLen;
+		dataBuffer = calloc(1, dataBufferSize);
+		memset(dataBuffer, 0, dataBufferSize);
+
+		ret = nvme_get_log(fd, WDC_DE_GLOBAL_NSID, deVULogPagesList[vuLogIdx].logPageId, dataBufferSize, dataBuffer);
+		if (ret) {
+			fprintf(stderr, "ERROR : WDC : nvme_get_log() for log page 0x%x failed, ret = %d\n",
+					deVULogPagesList[vuLogIdx].logPageId, ret);
+		} else {
+			wdc_UtilsDeleteCharFromString((char*)deVULogPagesList[vuLogIdx].logPageIdStr, 4, ' ');
+			wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+					"LogPage", (char*)&deVULogPagesList[vuLogIdx].logPageIdStr, (char*)serialNo, (char*)timeString);
+			wdc_WriteToFile(fileName, (char*)dataBuffer, dataBufferSize);
+		}
+
+		free(dataBuffer);
+		dataBuffer = NULL;
+	}
+
+	free(vuLogInput);
+
+	/* Get NVMe Features (0x01, 0x02, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C) */
+	for (listIdx = 1; listIdx < (sizeof(deFeatureIdList) / sizeof(deFeatureIdList[0])); listIdx++)
+	{
+		memset(featureIdBuff, 0, sizeof(featureIdBuff));
+		/* skipping  LbaRangeType as it is an optional nvme command and not supported */
+		if (deFeatureIdList[listIdx].featureId == FID_LBA_RANGE_TYPE)
+			continue;
+		ret = nvme_get_feature(fd, WDC_DE_GLOBAL_NSID, deFeatureIdList[listIdx].featureId, FS_CURRENT, 0,
+				sizeof(featureIdBuff), &featureIdBuff, &result);
+
+		if (ret) {
+			fprintf(stderr, "ERROR : WDC : nvme_get_feature id 0x%x failed, ret = %d\n",
+					deFeatureIdList[listIdx].featureId, ret);
+		} else {
+			wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s0x%x_%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+					"FEATURE_ID_", deFeatureIdList[listIdx].featureId,
+					deFeatureIdList[listIdx].featureName, serialNo, timeString);
+			wdc_WriteToFile(fileName, (char*)featureIdBuff, sizeof(featureIdBuff));
+		}
+	}
+
+	/* Read Debug Directory */
+	ret = wdc_get_log_dir_max_entries(fd, &maxNumOfVUFiles);
+	if (ret == WDC_STATUS_SUCCESS)
+	{
+		memset(&deEssentialsList, 0, sizeof(deEssentialsList));
+		deEssentialsList.logEntry = (WDC_DRIVE_ESSENTIALS*)calloc(1, sizeof(WDC_DRIVE_ESSENTIALS)*maxNumOfVUFiles);
+		deEssentialsList.maxNumLogEntries = maxNumOfVUFiles;
+
+		/* Fetch VU File Directory */
+		ret = wdc_fetch_log_directory(fd, &deEssentialsList);
+		if (ret == WDC_STATUS_SUCCESS)
+		{
+			/* Get Debug Data Files */
+			for (listIdx = 0; listIdx < deEssentialsList.numOfValidLogEntries; listIdx++)
+			{
+				if (0 == deEssentialsList.logEntry[listIdx].metaData.fileSize)
+				{
+					fprintf(stderr, "ERROR : WDC : File Size for %s is 0\n",
+							deEssentialsList.logEntry[listIdx].metaData.fileName);
+					ret = WDC_STATUS_FILE_SIZE_ZERO;
+				} else {
+					/* Fetch Log File Data */
+					dataBuffer = (char *)calloc(1, (size_t)deEssentialsList.logEntry[listIdx].metaData.fileSize);
+					ret = wdc_fetch_log_file_from_device(fd, deEssentialsList.logEntry[listIdx].metaData.fileID, WDC_DE_DESTN_SPI, deEssentialsList.logEntry[listIdx].metaData.fileSize,
+							(__u8 *)dataBuffer);
+
+					/* Write databuffer to file */
+					if (ret == WDC_STATUS_SUCCESS)
+					{
+						memset(fileName, 0, sizeof(fileName));
+						wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", bufferFolderPath, WDC_DE_PATH_SEPARATOR,
+								deEssentialsList.logEntry[listIdx].metaData.fileName, serialNo, timeString);
+						if (deEssentialsList.logEntry[listIdx].metaData.fileSize > 0xffffffff)
+						{
+							wdc_WriteToFile(fileName, dataBuffer, 0xffffffff);
+							wdc_WriteToFile(fileName, dataBuffer + 0xffffffff, (__u32)(deEssentialsList.logEntry[listIdx].metaData.fileSize - 0xffffffff));
+						} else {
+							wdc_WriteToFile(fileName, dataBuffer, (__u32)deEssentialsList.logEntry[listIdx].metaData.fileSize);
+						}
+					} else {
+						fprintf(stderr, "ERROR : WDC : wdc_fetch_log_file_from_device: %s failed, ret = %d\n",
+								deEssentialsList.logEntry[listIdx].metaData.fileName, ret);
+					}
+					free(dataBuffer);
+					dataBuffer = NULL;
+				}
+			}
+		} else {
+			fprintf(stderr, "WDC : wdc_fetch_log_directory failed, ret = %d\n", ret);
+		}
+	} else {
+		fprintf(stderr, "WDC : wdc_get_log_dir_max_entries failed, ret = %d\n", ret);
+	}
+
+	/* Get Dump Trace Data */
+	wdc_UtilsSnprintf(fileName, MAX_PATH_LEN, "%s%s%s_%s_%s.bin", (char*)bufferFolderPath, WDC_DE_PATH_SEPARATOR, "dumptrace", serialNo, timeString);
+	if (WDC_STATUS_SUCCESS != (ret = wdc_de_get_dump_trace(fd, (char*)bufferFolderPath, 0, fileName)))
+	{
+		fprintf(stderr, "ERROR : WDC : wdc_de_get_dump_trace failed, ret = %d\n", ret);
+	}
+
+	/* Tar the Drive Essentials directory */
+	wdc_UtilsSnprintf(tarFileName, sizeof(tarFileName), "%s%s", (char*)bufferFolderPath, WDC_DE_TAR_FILE_EXTN);
+	if (dir != NULL) {
+		wdc_UtilsSnprintf(tarFiles, sizeof(tarFiles), "%s%s%s%s%s",
+				(char*)dir, WDC_DE_PATH_SEPARATOR, (char*)bufferFolderName, WDC_DE_PATH_SEPARATOR, WDC_DE_TAR_FILES);
+	} else {
+		wdc_UtilsSnprintf(tarFiles, sizeof(tarFiles), "%s%s%s", (char*)bufferFolderName, WDC_DE_PATH_SEPARATOR, WDC_DE_TAR_FILES);
+	}
+	wdc_UtilsSnprintf(tarCmd, sizeof(tarCmd), "%s %s %s", WDC_DE_TAR_CMD, (char*)tarFileName, (char*)tarFiles);
+
+	ret = system(tarCmd);
+
+	if (ret) {
+		fprintf(stderr, "ERROR : WDC : Tar of Drive Essentials data failed, ret = %d\n", ret);
+	}
+
+	fprintf(stderr, "Get of Drive Essentials data successful\n");
+	return 0;
+}
+
+static int wdc_drive_essentials(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char *desc = "Capture Drive Essentials.";
+	char *dirName = "Output directory pathname.";
+
+	char d[PATH_MAX] = {0};
+	char k[PATH_MAX] = {0};
+	char *d_ptr;
+	int fd;
+	struct config {
+		char *dirName;
+	};
+
+	struct config cfg = {
+		.dirName = NULL,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"dir-name", 'd', "DIRECTORY", CFG_STRING, &cfg.dirName, required_argument, dirName},
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	if ( wdc_check_device_sxslcl(fd) < 0) {
+		fprintf(stderr, "WARNING : WDC : Device not supported\n");
+		return -1;
+	}
+
+	if (cfg.dirName != NULL) {
+		strncpy(d, cfg.dirName, PATH_MAX);
+		d_ptr = d;
+	} else {
+		d_ptr = NULL;
+	}
+
+	return wdc_do_drive_essentials(fd, d_ptr, k);
+}
diff --git a/wdc-nvme.h b/wdc-nvme.h
index 9f6b726..2e28ee9 100644
--- a/wdc-nvme.h
+++ b/wdc-nvme.h
@@ -15,6 +15,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
 		ENTRY("smart-add-log", "WDC Additional Smart Log", wdc_smart_add_log)
+		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
 	)
 );
 
diff --git a/wdc-utils.c b/wdc-utils.c
new file mode 100644
index 0000000..351023a
--- /dev/null
+++ b/wdc-utils.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ *
+ *   Author: Jeff Lien <jeff.lien at wdc.com>,
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+#include "wdc-utils.h"
+
+int wdc_UtilsSnprintf(char *buffer, unsigned int sizeOfBuffer, const char *format, ...)
+{
+    int res = 0;
+
+    va_list vArgs;
+    va_start(vArgs, format);
+    res = vsnprintf(buffer, sizeOfBuffer, format, vArgs);
+    va_end(vArgs);
+
+    return res;
+}
+
+void wdc_UtilsDeleteCharFromString(char* buffer, int buffSize, char charToRemove)
+{
+    int i = 0;
+    int count = 0;
+    if (!buffer || !buffSize)
+    {
+        return;
+    }
+
+    // Traverse the given string. If current character is not charToRemove, then place it at index count++
+    for (i = 0; ((i < buffSize) && (buffer[i] != '\0')); i++)
+    {
+        if (buffer[i] != charToRemove)
+        {
+            buffer[count++] = buffer[i];
+        }
+    }
+    buffer[count] = '\0';
+}
+
+int wdc_UtilsGetTime(PUtilsTimeInfo timeInfo)
+{
+	if(!timeInfo)
+		return WDC_STATUS_INVALID_PARAMETER;
+
+	time_t currTime;
+	struct tm currTimeInfo;
+
+	time(&currTime);
+	localtime_r(&currTime, &currTimeInfo);
+
+	timeInfo->year			=  currTimeInfo.tm_year + 1900;
+	timeInfo->month			=  currTimeInfo.tm_mon + 1;
+	timeInfo->dayOfWeek		=  currTimeInfo.tm_wday;
+	timeInfo->dayOfMonth	=  currTimeInfo.tm_mday;
+	timeInfo->hour			=  currTimeInfo.tm_hour;
+	timeInfo->minute		=  currTimeInfo.tm_min;
+	timeInfo->second		=  currTimeInfo.tm_sec;
+	timeInfo->msecs			=  0;
+	timeInfo->isDST			=  currTimeInfo.tm_isdst;
+
+	tzset();
+
+	timeInfo->zone = -1 *  (timezone / SECONDS_IN_MIN);
+
+	return WDC_STATUS_SUCCESS;
+}
+
+int wdc_UtilsCreateDir(char *path)
+{
+    int retStatus;
+    int status = WDC_STATUS_SUCCESS;
+
+    if  (!path )
+    {
+        return WDC_STATUS_INVALID_PARAMETER;
+    }
+
+    retStatus = mkdir(path, 0x999);
+
+    if (retStatus < 0)
+    {
+        if (errno == EEXIST)
+        {
+            status = WDC_STATUS_DIR_ALREADY_EXISTS;
+        }
+        else if (errno == ENOENT)
+        {
+            status = WDC_STATUS_PATH_NOT_FOUND;
+        }
+        else
+        {
+            status = WDC_STATUS_CREATE_DIRECTORY_FAILED;
+        }
+    }
+
+    return status;
+}
+
+int wdc_WriteToFile(char *fileName, char *buffer, unsigned int bufferLen)
+{
+    int          status = WDC_STATUS_SUCCESS;
+    FILE         *file;
+    size_t       bytesWritten = 0;
+    file = fopen(fileName, "ab+");
+
+    if(!file)
+    {
+        status = WDC_STATUS_UNABLE_TO_OPEN_FILE;
+        goto end;
+    }
+
+    bytesWritten = fwrite(buffer, 1, bufferLen, file);
+    if (bytesWritten != bufferLen)
+    {
+        status = WDC_STATUS_UNABLE_TO_WRITE_ALL_DATA;
+    }
+
+end:
+    if(file)
+        fclose(file);
+
+    return status;
+}
+
+/**
+ * Compares the strings ignoring their cases.
+ *
+ * @param pcSrc Points to a null terminated string for comapring.
+ * @param pcDst Points to a null terminated string for comapring.
+ *
+ * @returns zero if the string matches or
+ *          1 if the pcSrc string is lexically higher than pcDst or
+ *         -1 if the pcSrc string is lexically lower than pcDst.
+ */
+int wdc_UtilsStrCompare(char *pcSrc, char *pcDst)
+{
+    while((toupper(*pcSrc) == toupper(*pcDst)) && (*pcSrc != '\0'))
+    {
+        pcSrc++;
+        pcDst++;
+    }
+
+    return *pcSrc - *pcDst;
+}
+
diff --git a/wdc-utils.h b/wdc-utils.h
new file mode 100644
index 0000000..8d875e2
--- /dev/null
+++ b/wdc-utils.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ *
+ *   Author: Jeff Lien <jeff.lien at wdc.com>,
+ */
+
+#include <stdio.h>
+#include <ctype.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <assert.h>
+#include <time.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+
+#include <string.h>
+#include <unistd.h>
+
+/* Create Dir Command Status */
+#define WDC_STATUS_SUCCESS                		  			0
+#define WDC_STATUS_FAILURE   					 			-1
+#define WDC_STATUS_INSUFFICIENT_MEMORY           			-2
+#define WDC_STATUS_INVALID_PARAMETER       		 			-3
+#define WDC_STATUS_FILE_SIZE_ZERO               			-27
+#define WDC_STATUS_UNABLE_TO_WRITE_ALL_DATA 				-34
+#define WDC_STATUS_DIR_ALREADY_EXISTS      					-36
+#define WDC_STATUS_PATH_NOT_FOUND          					-37
+#define WDC_STATUS_CREATE_DIRECTORY_FAILED 					-38
+#define WDC_STATUS_DELETE_DIRECTORY_FAILED 					-39
+#define WDC_STATUS_UNABLE_TO_OPEN_FILE 						-40
+#define WDC_STATUS_UNABLE_TO_OPEN_ZIP_FILE             		-41
+#define WDC_STATUS_UNABLE_TO_ARCHIVE_EXCEEDED_FILES_LIMIT  	-256
+#define WDC_STATUS_NO_DATA_FILE_AVAILABLE_TO_ARCHIVE  		-271
+
+#define WDC_NVME_FIRMWARE_REV_LEN           9        /* added 1 for end delimiter */
+#define WDC_SERIAL_NO_LEN                   20
+#define SECONDS_IN_MIN   					60
+#define MAX_PATH_LEN       					256
+
+typedef struct _UtilsTimeInfo
+{
+	unsigned int year;
+	unsigned int month;
+	unsigned int dayOfWeek;
+	unsigned int dayOfMonth;
+	unsigned int hour;
+	unsigned int minute;
+	unsigned int second;
+	unsigned int msecs;
+	unsigned char isDST; //0 or 1
+    int      zone; // Zone value like +530 or -300
+} UtilsTimeInfo, *PUtilsTimeInfo;
+
+int wdc_UtilsSnprintf(char *buffer, unsigned int sizeOfBuffer, const char *format, ...);
+void wdc_UtilsDeleteCharFromString(char* buffer, int buffSize, char charToRemove);
+int wdc_UtilsGetTime(PUtilsTimeInfo timeInfo);
+int wdc_UtilsStrCompare(char *pcSrc, char *pcDst);
+int wdc_UtilsCreateDir(char *path);
+int wdc_WriteToFile(char *fileName, char *buffer, unsigned int bufferLen);
+
+extern char *tzname[2];
+extern long timezone;
+extern int daylight;
+
-- 
2.14.2.746.g8fb8a94
