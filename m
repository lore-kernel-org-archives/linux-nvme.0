From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:31:28 -0700
Subject: [PATCH 3/4] nvme-cli: make wdc plug-in functions static
In-Reply-To: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
References: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180827223129.2741-4-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 wdc-nvme.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 4e691e7..5dd1d9d 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -274,7 +274,7 @@ typedef struct _WDC_NVME_DE_VU_LOGPAGES
     __u32 numOfVULogPages;
 } WDC_NVME_DE_VU_LOGPAGES, *PWDC_NVME_DE_VU_LOGPAGES;
 
-NVME_VU_DE_LOGPAGE_LIST deVULogPagesList[] =
+static NVME_VU_DE_LOGPAGE_LIST deVULogPagesList[] =
 {
     { NVME_DE_LOGPAGE_E3, 0xE3, 1072, "0xe3"},
     { NVME_DE_LOGPAGE_C0, 0xC0, 512, "0xc0"}
@@ -1580,7 +1580,7 @@ static int wdc_get_max_transfer_len(int fd, __u32 *maxTransferLen)
 	return ret;
 }
 
-int wdc_de_VU_read_size(int fd, __u32 fileId, __u16 spiDestn, __u32* logSize)
+static int wdc_de_VU_read_size(int fd, __u32 fileId, __u16 spiDestn, __u32* logSize)
 {
 	int ret = WDC_STATUS_FAILURE;
 	struct nvme_admin_cmd cmd;
@@ -1608,7 +1608,7 @@ int wdc_de_VU_read_size(int fd, __u32 fileId, __u16 spiDestn, __u32* logSize)
 	return ret;
 }
 
-int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDwords, __u8* dataBuffer, __u32* bufferSize)
+static int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDwords, __u8* dataBuffer, __u32* bufferSize)
 {
 	int ret = WDC_STATUS_FAILURE;
 	struct nvme_admin_cmd cmd;
@@ -1641,7 +1641,7 @@ int wdc_de_VU_read_buffer(int fd, __u32 fileId, __u16 spiDestn, __u32 offsetInDw
 	return ret;
 }
 
-int wdc_get_log_dir_max_entries(int fd, __u32* maxNumOfEntries)
+static int wdc_get_log_dir_max_entries(int fd, __u32* maxNumOfEntries)
 {
 	int     		ret = WDC_STATUS_FAILURE;
 	__u32           headerPayloadSize = 0;
@@ -1689,7 +1689,7 @@ int wdc_get_log_dir_max_entries(int fd, __u32* maxNumOfEntries)
 	return ret;
 }
 
-WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
+static WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
 {
 	WDC_DRIVE_ESSENTIAL_TYPE essentialType = WDC_DE_TYPE_NONE;
 
@@ -1709,7 +1709,7 @@ WDC_DRIVE_ESSENTIAL_TYPE wdc_get_essential_type(__u8 fileName[])
 	return essentialType;
 }
 
-int wdc_fetch_log_directory(int fd, PWDC_DE_VU_LOG_DIRECTORY directory)
+static int wdc_fetch_log_directory(int fd, PWDC_DE_VU_LOG_DIRECTORY directory)
 {
 	int             ret = WDC_STATUS_FAILURE;
 	__u8            *fileOffset = NULL;
@@ -1786,7 +1786,7 @@ int wdc_fetch_log_directory(int fd, PWDC_DE_VU_LOG_DIRECTORY directory)
 	return ret;
 }
 
-int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 fileSize, __u8* dataBuffer)
+static int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 fileSize, __u8* dataBuffer)
 {
 	int ret = WDC_STATUS_FAILURE;
 	__u32                     chunckSize = WDC_DE_VU_READ_BUFFER_STANDARD_OFFSET;
@@ -1839,7 +1839,7 @@ int wdc_fetch_log_file_from_device(int fd, __u32 fileId, __u16 spiDestn, __u64 f
 	return ret;
 }
 
-int wdc_de_get_dump_trace(int fd, char * filePath, __u16 binFileNameLen, char *binFileName)
+static int wdc_de_get_dump_trace(int fd, char * filePath, __u16 binFileNameLen, char *binFileName)
 {
 	int                     ret = WDC_STATUS_FAILURE;
 	__u8                    *readBuffer = NULL;
-- 
2.17.0
