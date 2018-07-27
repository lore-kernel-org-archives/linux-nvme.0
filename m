From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:28 +0200
Subject: [PATCH 2/6] nvme-discover: Retry discovery log if the generation
 counter changes
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-3-hare@suse.de>

If the generation counter changes we need to validate if the number
of records has changed, too.
If so we need to retry retrieving the discovery log to the most recent
values. The retry will be terminated after MAX_DISC_RETRIES (currently
set to 30) to avoid infinite recursion.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 fabrics.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index ca8aaf7..b1219a0 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -71,6 +71,7 @@ static struct config {
 #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
 #define SYS_NVME		"/sys/class/nvme"
 #define MAX_DISC_ARGS		10
+#define MAX_DISC_RETRIES	30
 
 enum {
 	OPT_INSTANCE,
@@ -281,7 +282,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	struct nvmf_disc_rsp_page_hdr *log;
 	unsigned int log_size = 0;
 	unsigned long genctr;
-	int error, fd;
+	int error, fd, max_retries = MAX_DISC_RETRIES, retries = 0;
 
 	fd = open(dev_path, O_RDWR);
 	if (fd < 0) {
@@ -311,6 +312,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		goto out_free_log;
 	}
 
+retry_log:
 	/* check numrec limits */
 	*numrec = le64_to_cpu(log->numrec);
 	genctr = le64_to_cpu(log->genctr);
@@ -346,7 +348,12 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		goto out_free_log;
 	}
 
-	if (*numrec != le32_to_cpu(log->numrec) || genctr != le64_to_cpu(log->genctr)) {
+	if (genctr != le64_to_cpu(log->genctr) &&
+	    *numrec != le32_to_cpu(log->numrec) &&
+	    ++retries < max_retries)
+		goto retry_log;
+
+	if (*numrec != le32_to_cpu(log->numrec)) {
 		error = DISC_NOT_EQUAL;
 		goto out_free_log;
 	}
-- 
2.13.7
