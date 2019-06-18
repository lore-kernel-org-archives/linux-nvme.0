From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 18 Jun 2019 22:12:15 +0900
Subject: [PATCH V7 6/7] fabrics: return error when discovery retry exhausted
In-Reply-To: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
References: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
Message-ID: <20190618131216.3661-7-minwoo.im.dev@gmail.com>

If the discovery page is not updated to the latest one over the 10
times, it's currently returning DISC_OK if the numrec has no problem.
If so, the caller might think that the discovery has been successfully
done without any errors even there is.

This patch makes it return an error -EAGAIN if retry(10 times) has been
exhausted.

Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 fabrics.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index adedca0..8470d97 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -291,6 +291,7 @@ enum {
 	DISC_NO_LOG,
 	DISC_GET_NUMRECS,
 	DISC_GET_LOG,
+	DISC_RETRY_EXHAUSTED,
 	DISC_NOT_EQUAL,
 };
 
@@ -385,6 +386,16 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	} while (genctr != le64_to_cpu(log->genctr) &&
 		 ++retries < max_retries);
 
+	/*
+	 * If genctr is still different with the one in the log entry, it
+	 * means the retires have been exhausted to max_retries.  Then it
+	 * should be retried by the caller or the user.
+	 */
+	if (genctr != le64_to_cpu(log->genctr)) {
+		error = DISC_RETRY_EXHAUSTED;
+		goto out_free_log;
+	}
+
 	if (*numrec != le32_to_cpu(log->numrec)) {
 		error = DISC_NOT_EQUAL;
 		goto out_free_log;
@@ -882,6 +893,10 @@ static int do_discover(char *argstr, bool connect)
 		fprintf(stdout, "No discovery log entries to fetch.\n");
 		ret = DISC_OK;
 		break;
+	case DISC_RETRY_EXHAUSTED:
+		fprintf(stdout, "Discovery retries exhausted.\n");
+		ret = -EAGAIN;
+		break;
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
 		"Numrec values of last two get discovery log page not equal\n");
-- 
2.21.0
