From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:57 -0700
Subject: [PATCH nvme-cli 09/13] Avoid using arrays with a variable length
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-10-bvanassche@acm.org>

Since variable length arrays result in suboptimal code, avoid using
variable length arrays.

Cc: Patrick McCormick <patrick.m.mccormick at intel.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-print.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index ea8f720748ef..94222a3b1c15 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -41,8 +42,9 @@ static long double int128_to_double(__u8 *data)
 void d(unsigned char *buf, int len, int width, int group)
 {
 	int i, offset = 0, line_done = 0;
-	char ascii[width + 1];
+	char ascii[32 + 1];
 
+	assert(width < sizeof(ascii));
 	printf("     ");
 	for (i = 0; i <= 15; i++)
 		printf("%3x", i);
-- 
2.22.0.rc3
