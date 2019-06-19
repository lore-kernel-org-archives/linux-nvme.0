From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:56 -0700
Subject: [PATCH nvme-cli 08/13] wdc: Fix endianness bugs
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-9-bvanassche@acm.org>

Insert le16_to_cpu() / le32_to_cpu() where required.

Cc: Dong Ho <Dong.Ho at wdc.com>
Fixes: 6bd8ab436693 ("wdc: Add data area extraction for DUI command").
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 plugins/wdc/wdc-nvme.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index a9c86b6eced2..ba90fc09e0fe 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -914,7 +914,8 @@ static bool get_dev_mgment_cbs_data(int fd, __u8 log_id, void **cbs_data)
 	if (le32_to_cpu(hdr_ptr->length) > WDC_C2_LOG_BUF_LEN) {
 		/* Log Page buffer too small, free and reallocate the necessary size */
 		free(data);
-		if ((data = (__u8*) calloc(hdr_ptr->length, sizeof (__u8))) == NULL) {
+		data = calloc(le32_to_cpu(hdr_ptr->length), sizeof(__u8));
+		if (data == NULL) {
 			fprintf(stderr, "ERROR : WDC : malloc : %s\n", strerror(errno));
 			return false;
 		}
@@ -1290,9 +1291,12 @@ static int wdc_do_cap_dui(int fd, char *file, __u32 xfer_size, int data_area)
 		/* parse log header for all sections up to specified data area inclusively */
 		if (data_area != WDC_NVME_DUI_MAX_DATA_AREA) {
 			for(int i = 0; i < WDC_NVME_DUI_MAX_SECTION; i++) {
-				if (log_hdr->log_section[i].data_area_id <= data_area &&
-				    log_hdr->log_section[i].data_area_id != 0)
-					log_size += log_hdr->log_section[i].section_size;
+				__u16 data_area_id = le16_to_cpu(log_hdr->log_section[i].data_area_id);
+				__u16 section_size = le16_to_cpu(log_hdr->log_section[i].section_size);
+
+				if (data_area_id <= data_area &&
+				    data_area_id != 0)
+					log_size += section_size;
 				else
 					break;
 			}
-- 
2.22.0.rc3
