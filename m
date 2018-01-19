From: jeff.lien@wdc.com (Jeff Lien)
Date: Fri, 19 Jan 2018 12:00:53 -0600
Subject: [PATCH] NVMe-CLI WDC-Plugin Update drive essentials code with review
 comments.
Message-ID: <20180119180053.20278-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 wdc-nvme.c | 261 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 125 insertions(+), 136 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 3628b1d..9590a9c 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -590,8 +590,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 
 	/* get the log page length */
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   WDC_C2_LOG_BUF_LEN, data);
+			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_C2_LOG_BUF_LEN, data);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to get C2 Log Page length, ret = %d\n", ret);
 		goto out;
@@ -605,8 +604,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 	}
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   hdr_ptr->length, data);
+			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, hdr_ptr->length, data);
 	/* parse the data until the List of log page ID's is found */
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
@@ -1341,8 +1339,7 @@ static int wdc_get_ca_log_page(int fd, char *format)
 	memset(data, 0, sizeof (__u8) * WDC_CA_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   WDC_CA_LOG_BUF_LEN, data);
+			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_CA_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 
@@ -1391,8 +1388,7 @@ static int wdc_get_c1_log_page(int fd, char *format, uint8_t interval)
 	memset(data, 0, sizeof (__u8) * WDC_ADD_LOG_BUF_LEN);
 
 	ret = nvme_get_log(fd, 0x01, WDC_NVME_ADD_LOG_OPCODE,
-			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			   WDC_ADD_LOG_BUF_LEN, data);
+			   NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, WDC_ADD_LOG_BUF_LEN, data);
 	if (strcmp(format, "json"))
 		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
 	if (ret == 0) {
@@ -1538,7 +1534,6 @@ static int wdc_get_max_transfer_len(int fd, __u32 *maxTransferLen)
 	struct nvme_id_ctrl ctrl;
 
 	__u32 maxTransferLenDevice = 0;
-	/*__u32 maxTransferLenHost = 0;    * do we need to get the host max transfer length?? */
 
 	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
 	ret = nvme_identify_ctrl(fd, &ctrl);
@@ -1550,13 +1545,6 @@ static int wdc_get_max_transfer_len(int fd, __u32 *maxTransferLen)
 	maxTransferLenDevice = (1 << ctrl.mdts) * getpagesize();
 	*maxTransferLen = maxTransferLenDevice;
 
-	/*
-    if( maxTransferLenDevice < maxTransferLenHost)
-	    *maxTransferLen = maxTransferLenDevice;
-    else
-	    *maxTransferLen = maxTransferLenHost;
-	*/
-
 	return ret;
 }
 
@@ -1623,50 +1611,50 @@ int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDw
 
 int wdc_get_log_dir_max_entries(int fd, __u32* maxNumOfEntries)
 {
-    int     		ret = WDC_STATUS_FAILURE;
-    __u32           headerPayloadSize = 0;
-    __u8*           fileIdOffsetsBuffer = NULL;
-    __u32           fileIdOffsetsBufferSize = 0;
-    __u32           fileNum = 0;
-    __u16           fileOffset = 0;
-
-
-    if (!fd || !maxNumOfEntries)
-    {
-        ret = WDC_STATUS_INVALID_PARAMETER;
-        return ret;
-    }
-    /* 1.Get log directory first four bytes */
-    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, (__u32*)&headerPayloadSize)))
-    {
+	int     		ret = WDC_STATUS_FAILURE;
+	__u32           headerPayloadSize = 0;
+	__u8*           fileIdOffsetsBuffer = NULL;
+	__u32           fileIdOffsetsBufferSize = 0;
+	__u32           fileNum = 0;
+	__u16           fileOffset = 0;
+
+
+	if (!fd || !maxNumOfEntries)
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		return ret;
+	}
+	/* 1.Get log directory first four bytes */
+	if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, (__u32*)&headerPayloadSize)))
+	{
 		fprintf(stderr, "ERROR : WDC : %s: Failed to get headerPayloadSize from file directory 0x%x\n",
 				__func__, ret);
-        goto end;
-    }
+		goto end;
+	}
 
-    fileIdOffsetsBufferSize = WDC_DE_FILE_HEADER_SIZE + (headerPayloadSize * WDC_DE_FILE_OFFSET_SIZE);
-    fileIdOffsetsBuffer = (__u8*)calloc(1, fileIdOffsetsBufferSize);
+	fileIdOffsetsBufferSize = WDC_DE_FILE_HEADER_SIZE + (headerPayloadSize * WDC_DE_FILE_OFFSET_SIZE);
+	fileIdOffsetsBuffer = (__u8*)calloc(1, fileIdOffsetsBufferSize);
 
-    /* 2.Read to get file offsets */
-    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileIdOffsetsBuffer, &fileIdOffsetsBufferSize)))
-    {
+	/* 2.Read to get file offsets */
+	if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileIdOffsetsBuffer, &fileIdOffsetsBufferSize)))
+	{
 		fprintf(stderr, "ERROR : WDC : %s: Failed to get fileIdOffsets from file directory 0x%x\n",
 				__func__, ret);
-        goto end;
-    }
-    /* 3.Determine valid entries */
-    for (fileNum = 0; fileNum < (headerPayloadSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
-    {
-        fileOffset = (fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE)] << 8) +
-            fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE) + 1];
-        if (!fileOffset)
-            continue;
-        (*maxNumOfEntries)++;
-    }
-end:
-    if (!fileIdOffsetsBuffer)
-        free(fileIdOffsetsBuffer);
-    return ret;
+		goto end;
+	}
+	/* 3.Determine valid entries */
+	for (fileNum = 0; fileNum < (headerPayloadSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
+	{
+		fileOffset = (fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE)] << 8) +
+				fileIdOffsetsBuffer[WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE) + 1];
+		if (!fileOffset)
+			continue;
+		(*maxNumOfEntries)++;
+	}
+	end:
+	if (!fileIdOffsetsBuffer)
+		free(fileIdOffsetsBuffer);
+	return ret;
 }
 
 WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
@@ -1691,80 +1679,79 @@ WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
 
 int wdc_fetch_log_directory(int fd, PWDC_DE_VU_LOG_DIRECTORY directory)
 {
-    int             ret = WDC_STATUS_FAILURE;
-    __u8            *fileOffset = NULL;
-    __u8            *fileDirectory = NULL;
-    __u32           headerSize = 0;
-    __u32           fileNum = 0, startIdx = 0;
-    __u16           fileOffsetTemp = 0;
-    __u32           entryId = 0;
-    __u32           fileDirectorySize = 0;
-
-    if (!fd || !directory)
-    {
-        ret = WDC_STATUS_INVALID_PARAMETER;
-        goto end;
-    }
-
-    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, &fileDirectorySize)))
-    {
+	int             ret = WDC_STATUS_FAILURE;
+	__u8            *fileOffset = NULL;
+	__u8            *fileDirectory = NULL;
+	__u32           headerSize = 0;
+	__u32           fileNum = 0, startIdx = 0;
+	__u16           fileOffsetTemp = 0;
+	__u32           entryId = 0;
+	__u32           fileDirectorySize = 0;
+
+	if (!fd || !directory)
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		goto end;
+	}
+
+	if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_size(fd, 0, 5, &fileDirectorySize)))
+	{
 		fprintf(stderr, "ERROR : WDC : %s: Failed to get filesystem directory size, ret = %d\n",
 				__func__, ret);
-        goto end;
-    }
+		goto end;
+	}
 
-    fileDirectory = (__u8*)calloc(1, fileDirectorySize);
-    if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileDirectory, &fileDirectorySize)))
-    {
+	fileDirectory = (__u8*)calloc(1, fileDirectorySize);
+	if (WDC_STATUS_SUCCESS != (ret = wdc_de_VU_read_buffer(fd, 0, 5, 0, fileDirectory, &fileDirectorySize)))
+	{
 		fprintf(stderr, "ERROR : WDC : %s: Failed to get filesystem directory, ret = %d\n",
 				__func__, ret);
-        goto end;
-    }
-
-    /* First four bytes of header directory is headerSize */
-    memcpy(&headerSize, fileDirectory, WDC_DE_FILE_HEADER_SIZE);
-
-    if (directory->maxNumLogEntries == 0) //minimum buffer for 1 entry is required
-    {
-        ret = WDC_STATUS_INVALID_PARAMETER;
-        goto end;
-    }
-
-    for (fileNum = 0; fileNum < (headerSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
-    {
-        if (entryId >= directory->maxNumLogEntries)
-            break;
-        startIdx = WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE);
-        memcpy(&fileOffsetTemp, fileDirectory + startIdx, sizeof(fileOffsetTemp));
-        fileOffset = fileDirectory + fileOffsetTemp;
-
-        if (0 == fileOffsetTemp)
-        {
-            continue;
-        }
-
-        memset(&directory->logEntry[entryId], 0, sizeof(WDC_DRIVE_ESSENTIALS));
-        memcpy(&directory->logEntry[entryId].metaData, fileOffset, sizeof(WDC_DE_VU_FILE_META_DATA));
-        directory->logEntry[entryId].metaData.fileName[WDC_DE_FILE_NAME_SIZE - 1] = '\0';
-        wdc_UtilsDeleteCharFromString((char*)directory->logEntry[entryId].metaData.fileName, WDC_DE_FILE_NAME_SIZE, ' ');
-        if (0 == directory->logEntry[entryId].metaData.fileID)
-        {
-            continue;
-        }
-        directory->logEntry[entryId].essentialType = wdc_get_essential_type(directory->logEntry[entryId].metaData.fileName);
-        /*
-		fprintf(stderr, "WDC : %s: NVMe VU Log Entry %d, fileName = %s, fileSize = 0x%lx, fileId = 0x%x\n",
-				__func__, entryId, directory->logEntry[entryId].metaData.fileName,
-				(long unsigned int)directory->logEntry[entryId].metaData.fileSize, directory->logEntry[entryId].metaData.fileID);
-		*/
-        entryId++;
-    }
-    directory->numOfValidLogEntries = entryId;
-end:
-    if (fileDirectory != NULL)
-        free(fileDirectory);
-
-    return ret;
+		goto end;
+	}
+
+	/* First four bytes of header directory is headerSize */
+	memcpy(&headerSize, fileDirectory, WDC_DE_FILE_HEADER_SIZE);
+
+	if (directory->maxNumLogEntries == 0) //minimum buffer for 1 entry is required
+	{
+		ret = WDC_STATUS_INVALID_PARAMETER;
+		goto end;
+	}
+
+	for (fileNum = 0; fileNum < (headerSize - WDC_DE_FILE_HEADER_SIZE) / WDC_DE_FILE_OFFSET_SIZE; fileNum++)
+	{
+		if (entryId >= directory->maxNumLogEntries)
+			break;
+		startIdx = WDC_DE_FILE_HEADER_SIZE + (fileNum * WDC_DE_FILE_OFFSET_SIZE);
+		memcpy(&fileOffsetTemp, fileDirectory + startIdx, sizeof(fileOffsetTemp));
+		fileOffset = fileDirectory + fileOffsetTemp;
+
+		if (0 == fileOffsetTemp)
+		{
+			continue;
+		}
+
+		memset(&directory->logEntry[entryId], 0, sizeof(WDC_DRIVE_ESSENTIALS));
+		memcpy(&directory->logEntry[entryId].metaData, fileOffset, sizeof(WDC_DE_VU_FILE_META_DATA));
+		directory->logEntry[entryId].metaData.fileName[WDC_DE_FILE_NAME_SIZE - 1] = '\0';
+		wdc_UtilsDeleteCharFromString((char*)directory->logEntry[entryId].metaData.fileName, WDC_DE_FILE_NAME_SIZE, ' ');
+		if (0 == directory->logEntry[entryId].metaData.fileID)
+		{
+			continue;
+		}
+		directory->logEntry[entryId].essentialType = wdc_get_essential_type(directory->logEntry[entryId].metaData.fileName);
+		/*fprintf(stderr, "WDC : %s: NVMe VU Log Entry %d, fileName = %s, fileSize = 0x%lx, fileId = 0x%x\n",
+			__func__, entryId, directory->logEntry[entryId].metaData.fileName,
+			(long unsigned int)directory->logEntry[entryId].metaData.fileSize, directory->logEntry[entryId].metaData.fileID);
+		 */
+		entryId++;
+	}
+	directory->numOfValidLogEntries = entryId;
+	end:
+	if (fileDirectory != NULL)
+		free(fileDirectory);
+
+	return ret;
 }
 
 int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 fileSize, __u8* dataBuffer)
@@ -1787,7 +1774,7 @@ int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 f
 	if ((fileSize >= maximumTransferLength) || (fileSize > 0xffffffff))
 	{
 		chunckSize = WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET;
-    	if (maximumTransferLength < WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET)
+		if (maximumTransferLength < WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET)
 			chunckSize = maximumTransferLength;
 
 		buffSize = chunckSize;
@@ -1797,7 +1784,7 @@ int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 f
 				buffSize = (__u32)(fileSize - (offsetIdx * chunckSize));
 			/* Limitation in VU read buffer - offsetIdx and bufferSize are not greater than u32 */
 			ret = wdc_de_VU_read_buffer(fd, fileId, spiDestn,
-				(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer + (offsetIdx * chunckSize), &buffSize);
+					(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer + (offsetIdx * chunckSize), &buffSize);
 			if (ret != WDC_STATUS_SUCCESS)
 			{
 				fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_buffer failed with ret = %d, fileId = 0x%x, fileSize = 0x%lx\n",
@@ -1808,7 +1795,7 @@ int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 f
 	} else {
 		buffSize = (__u32)fileSize;
 		ret = wdc_de_VU_read_buffer(fd, fileId, spiDestn,
-			(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer, &buffSize);
+				(__u32)((offsetIdx * chunckSize) / sizeof(__u32)), dataBuffer, &buffSize);
 		if (ret != WDC_STATUS_SUCCESS)
 		{
 			fprintf(stderr, "ERROR : WDC : %s: wdc_de_VU_read_buffer failed with ret = %d, fileId = 0x%x, fileSize = 0x%lx\n",
@@ -1816,7 +1803,7 @@ int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 f
 		}
 	}
 
-end:
+	end:
 	return ret;
 }
 
@@ -1925,7 +1912,7 @@ int wdc_de_get_dump_trace(int fd, char * filePath, __u16 binFileNameLen, char *b
 static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 {
 	int ret = 0;
-    void *retPtr;
+	void *retPtr;
 	char                      fileName[MAX_PATH_LEN];
 	__s8                      bufferFolderPath[MAX_PATH_LEN];
 	char                      bufferFolderName[MAX_PATH_LEN];
@@ -1998,7 +1985,7 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 		retPtr = getcwd((char*)currDir, MAX_PATH_LEN);
 		if (retPtr != NULL)
 			wdc_UtilsSnprintf((char*)bufferFolderPath, MAX_PATH_LEN, "%s%s%s",
-				(char *)currDir, WDC_DE_PATH_SEPARATOR, (char *)bufferFolderName);
+					(char *)currDir, WDC_DE_PATH_SEPARATOR, (char *)bufferFolderName);
 		else {
 			fprintf(stderr, "ERROR : WDC : get current working directory failed\n");
 			return -1;
@@ -2056,7 +2043,7 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 
 	/* Get Smart log page  */
 	memset(&smart_log, 0, sizeof (struct nvme_smart_log));
-	ret = nvme_smart_log(fd, 0xffffffff, &smart_log);
+	ret = nvme_smart_log(fd, NVME_NSID_ALL, &smart_log);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : nvme_smart_log() failed, ret = %d\n", ret);
 	} else {
@@ -2088,8 +2075,7 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 		memset(dataBuffer, 0, dataBufferSize);
 
 		ret = nvme_get_log(fd, WDC_DE_GLOBAL_NSID, deVULogPagesList[vuLogIdx].logPageId,
-			   	NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-				dataBufferSize, dataBuffer);
+				NVME_NO_LOG_LSP, NVME_NO_LOG_LPO, dataBufferSize, dataBuffer);
 		if (ret) {
 			fprintf(stderr, "ERROR : WDC : nvme_get_log() for log page 0x%x failed, ret = %d\n",
 					deVULogPagesList[vuLogIdx].logPageId, ret);
@@ -2177,6 +2163,9 @@ static int wdc_do_drive_essentials(int fd, char *dir, char *key)
 		} else {
 			fprintf(stderr, "WDC : wdc_fetch_log_directory failed, ret = %d\n", ret);
 		}
+
+		free(deEssentialsList.logEntry);
+		deEssentialsList.logEntry = NULL;
 	} else {
 		fprintf(stderr, "WDC : wdc_get_log_dir_max_entries failed, ret = %d\n", ret);
 	}
@@ -2223,13 +2212,13 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 	};
 
 	struct config cfg = {
-		.dirName = NULL,
+			.dirName = NULL,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
-		{"dir-name", 'd', "DIRECTORY", CFG_STRING, &cfg.dirName, required_argument, dirName},
-		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
-		{NULL}
+			{"dir-name", 'd', "DIRECTORY", CFG_STRING, &cfg.dirName, required_argument, dirName},
+			{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+			{NULL}
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-- 
2.14.2.746.g8fb8a94
