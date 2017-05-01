From: sbates@raithlin.com (sbates@raithlin.com)
Date: Mon,  1 May 2017 15:22:45 -0600
Subject: [PATCH nvme-cli] nvme-print: Fix line spacing on -H option
Message-ID: <1493673765-11528-1-git-send-email-sbates@raithlin.com>

From: Stephen Bates <sbates@raithlin.com>

Add newlines to make the ASQ and ACQ human readable output consistent
with other fields.

Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 nvme-print.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index a86902e..33f6722 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1662,11 +1662,11 @@ void show_ctrl_registers(void *bar, unsigned int mode)
 		show_registers_aqa(aqa);
 
 		printf("asq     : %"PRIx64"\n", asq);
-		printf("\tAdmin Submission Queue Base (ASQB): %"PRIx64"\n",
+		printf("\tAdmin Submission Queue Base (ASQB): %"PRIx64"\n\n",
 				asq);
 
 		printf("acq     : %"PRIx64"\n", acq);
-		printf("\tAdmin Completion Queue Base (ACQB): %"PRIx64"\n",
+		printf("\tAdmin Completion Queue Base (ACQB): %"PRIx64"\n\n",
 				acq);
 
 		printf("cmbloc  : %x\n", cmbloc);
-- 
2.7.4
