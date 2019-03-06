From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Wed, 6 Mar 2019 17:01:49 +0000
Subject: [PATCH] [NVMe-CLI] WDC plugin Change vs-internal-log Command to Save
 Partial E6 Log Data.
Message-ID: <1551891698-16525-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 6a2dac8..1bdbb77 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -1185,8 +1185,14 @@ static int wdc_do_dump_e6(int fd, __u32 opcode,__u32 data_len,
 
 	if (ret == 0) {
 		fprintf(stderr, "%s:  NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
-		ret = wdc_create_log_file(file, dump_data, data_len);
-	}
+	} else {
+		fprintf(stderr, "%s:  FAILURE: NVMe Status:%s(%x)\n", __func__, nvme_status_to_string(ret), ret);
+		fprintf(stderr, "%s:  Partial data may have been captured\n", __func__);
+		snprintf(file + strlen(file), PATH_MAX, "%s", "-PARTIAL");
+ 	}
+
+	ret = wdc_create_log_file(file, dump_data, data_len);
+
 	free(dump_data);
 	return ret;
 }
-- 
1.8.3.1
