From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:53 -0700
Subject: [PATCH nvme-cli 05/13] virtium: Declare local symbols static
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-6-bvanassche@acm.org>

This patch avoids that sparse complains about missing declarations.

Cc: Quyen Truong <quyen.truong at virtium.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 plugins/virtium/virtium-nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/virtium/virtium-nvme.c b/plugins/virtium/virtium-nvme.c
index ca5f5774af8c..7d91ef8d29dd 100644
--- a/plugins/virtium/virtium-nvme.c
+++ b/plugins/virtium/virtium-nvme.c
@@ -377,7 +377,9 @@ static int vt_update_vtview_log_header(const int fd, const char *path, const str
     return (ret);
 }
 
-void vt_build_identify_lv2(unsigned int data, unsigned int start, unsigned int count, const char **table, bool isEnd)
+static void vt_build_identify_lv2(unsigned int data, unsigned int start,
+				  unsigned int count, const char **table,
+				  bool isEnd)
 {
     unsigned int i, end, pos, sh = 1;
     unsigned int temp;
-- 
2.22.0.rc3
