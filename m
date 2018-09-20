From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:36 +0200
Subject: [PATCH 3/6] nvme-discover: Re-check generation counter after log page
 transfer
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920090939.6348-4-hare@suse.de>

The log page transfer might have been split up in several chunks, so
it might happen that the generation counter changed inbetween these
transfer. Hence we need to re-fetch the header again to figure out
if there had been changes to the generation counter; if so we need
to fetch the entire page again.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 fabrics.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 83eeb00..1c25ccb 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -282,7 +282,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		struct nvmf_disc_rsp_page_hdr **logp, int *numrec)
 {
 	struct nvmf_disc_rsp_page_hdr *log;
-	unsigned int log_size = 0;
+	unsigned int hdr_size;
 	unsigned long genctr;
 	int error, fd, max_retries = MAX_DISC_RETRIES, retries = 0;
 
@@ -297,26 +297,28 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	/* first get_log_page we just need numrec entry from discovery hdr.
 	 * host supplies its desired bytes via dwords, per NVMe spec.
 	 */
-	log_size = round_up((offsetof(struct nvmf_disc_rsp_page_hdr, numrec) +
+	hdr_size = round_up((offsetof(struct nvmf_disc_rsp_page_hdr, numrec) +
 			    sizeof(log->numrec)), sizeof(__u32));
 
 	/*
 	 * Issue first get log page w/numdl small enough to retrieve numrec.
 	 * We just want to know how many records to retrieve.
 	 */
-	log = calloc(1, log_size);
+	log = calloc(1, hdr_size);
 	if (!log) {
 		error = -ENOMEM;
 		goto out_close;
 	}
 
-	error = nvme_discovery_log(fd, log, log_size);
+	error = nvme_discovery_log(fd, log, hdr_size);
 	if (error) {
 		error = DISC_GET_NUMRECS;
 		goto out_free_log;
 	}
 
 	do {
+		unsigned int log_size;
+
 		/* check numrec limits */
 		*numrec = le64_to_cpu(log->numrec);
 		genctr = le64_to_cpu(log->genctr);
@@ -352,6 +354,18 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 			goto out_free_log;
 		}
 
+		/*
+		 * The above call to nvme_discovery_log() might result
+		 * in several calls (with different offsets), so we need
+		 * to fetch the header again to have the most up-to-date
+		 * value for the generation counter
+		 */
+		genctr = le64_to_cpu(log->genctr);
+		error = nvme_discovery_log(fd, log, hdr_size);
+		if (error) {
+			error = DISC_GET_LOG;
+			goto out_free_log;
+		}
 	} while (genctr != le64_to_cpu(log->genctr) &&
 		 ++retries < max_retries);
 
-- 
2.13.7
