From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 26 Oct 2018 10:08:33 -0700
Subject: [PATCH 2/3] nvme-cli: fix endianness for the structure field
In-Reply-To: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181026170834.23457-2-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 604a8a9..5ef965d 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -668,13 +668,14 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 
 	hdr_ptr = (struct wdc_c2_log_page_header *)data;
 
-	if (hdr_ptr->length > WDC_C2_LOG_BUF_LEN) {
-		fprintf(stderr, "ERROR : WDC : data length > buffer size : 0x%x\n", hdr_ptr->length);
+	if (le32_to_cpu(hdr_ptr->length) > WDC_C2_LOG_BUF_LEN) {
+		fprintf(stderr, "ERROR : WDC : data length > buffer size : 0x%x\n",
+				le32_to_cpu(hdr_ptr->length));
 		goto out;
 	}
 
 	ret = nvme_get_log(fd, 0xFFFFFFFF, WDC_NVME_GET_AVAILABLE_LOG_PAGES_OPCODE,
-			   false,  hdr_ptr->length, data);
+			   false,  le32_to_cpu(hdr_ptr->length), data);
 	/* parse the data until the List of log page ID's is found */
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : Unable to read C2 Log Page data, ret = %d\n", ret);
@@ -682,13 +683,13 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 	}
 
 	length = sizeof(struct wdc_c2_log_page_header);
-	while (length < hdr_ptr->length) {
+	while (length < le32_to_cpu(hdr_ptr->length)) {
 		sph = (struct wdc_c2_log_subpage_header *)(data + length);
 
-		if (sph->entry_id == WDC_C2_LOG_PAGES_SUPPORTED_ID) {
+		if (le32_to_cpu(sph->entry_id) == WDC_C2_LOG_PAGES_SUPPORTED_ID) {
 			cbs_data = (struct wdc_c2_cbs_data *)&sph->data;
 
-			for (i = 0; i < cbs_data->length; i++) {
+			for (i = 0; i < le32_to_cpu(cbs_data->length); i++) {
 				if (log_id == cbs_data->data[i]) {
 					found = 1;
 					ret = 0;
@@ -700,7 +701,7 @@ static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id)
 				fprintf(stderr, "ERROR : WDC : Log Page 0x%x not supported\n", log_id);
 				fprintf(stderr, "WDC : Supported Log Pages:\n");
 				/* print the supported pages */
-				d((__u8 *)&sph->data + 4, sph->length - 12, 16, 1);
+				d((__u8 *)&sph->data + 4, le32_to_cpu(sph->length) - 12, 16, 1);
 				ret = -1;
 			}
 			break;
-- 
2.17.0
