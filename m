From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:55 -0700
Subject: [PATCH nvme-cli 07/13] virtium: Fix an endianness issue
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-8-bvanassche@acm.org>

Convert nsze from little endian to CPU endian before using it.

Cc: Quyen Truong <quyen.truong at virtium.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 plugins/virtium/virtium-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/virtium/virtium-nvme.c b/plugins/virtium/virtium-nvme.c
index 7d91ef8d29dd..5b295e2a47eb 100644
--- a/plugins/virtium/virtium-nvme.c
+++ b/plugins/virtium/virtium-nvme.c
@@ -132,7 +132,7 @@ static void vt_convert_smart_data_to_human_readable_format(struct vtview_smart_l
     snprintf(tempbuff, sizeof(tempbuff), "log;%s;%lu;%s;%s;%-.*s;", smart->raw_ctrl.sn, smart->time_stamp, smart->path, \
             smart->raw_ctrl.mn, (int)sizeof(smart->raw_ctrl.fr), smart->raw_ctrl.fr);
     strcpy(text, tempbuff);
-    snprintf(tempbuff, sizeof(tempbuff), "Capacity;%f;", (double)smart->raw_ns.nsze / 1000000000);
+    snprintf(tempbuff, sizeof(tempbuff), "Capacity;%f;", (double)le64_to_cpu(smart->raw_ns.nsze) / 1000000000);
     strcat(text, tempbuff);
     snprintf(tempbuff, sizeof(tempbuff), "Critical_Warning;%u;", smart->raw_smart.critical_warning);
     strcat(text, tempbuff);
-- 
2.22.0.rc3
