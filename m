From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:34 +0200
Subject: [PATCH 1/6] nvme-discover: Retry discovery log if the generation
 counter changes
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920090939.6348-2-hare@suse.de>

If the generation counter changes we need to validate if the number
of records has changed, too.
If so we need to retry retrieving the discovery log to the most recent
values. The retry will be terminated after MAX_DISC_RETRIES (currently
set to 10) to avoid infinite recursion.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 fabrics.c | 67 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 029105b..83eeb00 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -71,6 +71,7 @@ static struct config {
 #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
 #define SYS_NVME		"/sys/class/nvme"
 #define MAX_DISC_ARGS		10
+#define MAX_DISC_RETRIES	10
 
 enum {
 	OPT_INSTANCE,
@@ -283,7 +284,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	struct nvmf_disc_rsp_page_hdr *log;
 	unsigned int log_size = 0;
 	unsigned long genctr;
-	int error, fd;
+	int error, fd, max_retries = MAX_DISC_RETRIES, retries = 0;
 
 	fd = open(dev_path, O_RDWR);
 	if (fd < 0) {
@@ -315,42 +316,46 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		goto out_free_log;
 	}
 
-	/* check numrec limits */
-	*numrec = le64_to_cpu(log->numrec);
-	genctr = le64_to_cpu(log->genctr);
-	free(log);
+	do {
+		/* check numrec limits */
+		*numrec = le64_to_cpu(log->numrec);
+		genctr = le64_to_cpu(log->genctr);
+		free(log);
 
-	if (*numrec == 0) {
-		error = DISC_NO_LOG;
-		goto out_close;
-	}
+		if (*numrec == 0) {
+			error = DISC_NO_LOG;
+			goto out_close;
+		}
 
-	/* we are actually retrieving the entire discovery tables
-	 * for the second get_log_page(), per
-	 * NVMe spec so no need to round_up(), or there is something
-	 * seriously wrong with the standard
-	 */
-	log_size = sizeof(struct nvmf_disc_rsp_page_hdr) +
+		/* we are actually retrieving the entire discovery tables
+		 * for the second get_log_page(), per
+		 * NVMe spec so no need to round_up(), or there is something
+		 * seriously wrong with the standard
+		 */
+		log_size = sizeof(struct nvmf_disc_rsp_page_hdr) +
 			sizeof(struct nvmf_disc_rsp_page_entry) * *numrec;
 
-	/* allocate discovery log pages based on page_hdr->numrec */
-	log = calloc(1, log_size);
-	if (!log) {
-		error = -ENOMEM;
-		goto out_close;
-	}
+		/* allocate discovery log pages based on page_hdr->numrec */
+		log = calloc(1, log_size);
+		if (!log) {
+			error = -ENOMEM;
+			goto out_close;
+		}
 
-	/*
-	 * issue new get_log_page w/numdl+numdh set to get all records,
-	 * up to MAX_DISC_LOGS.
-	 */
-	error = nvme_discovery_log(fd, log, log_size);
-	if (error) {
-		error = DISC_GET_LOG;
-		goto out_free_log;
-	}
+		/*
+		 * issue new get_log_page w/numdl+numdh set to get all records,
+		 * up to MAX_DISC_LOGS.
+		 */
+		error = nvme_discovery_log(fd, log, log_size);
+		if (error) {
+			error = DISC_GET_LOG;
+			goto out_free_log;
+		}
+
+	} while (genctr != le64_to_cpu(log->genctr) &&
+		 ++retries < max_retries);
 
-	if (*numrec != le32_to_cpu(log->numrec) || genctr != le64_to_cpu(log->genctr)) {
+	if (*numrec != le32_to_cpu(log->numrec)) {
 		error = DISC_NOT_EQUAL;
 		goto out_free_log;
 	}
-- 
2.13.7
