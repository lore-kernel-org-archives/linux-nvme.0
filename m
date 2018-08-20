From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:07 -0400
Subject: [PATCH 5/5] nvme-cli: fix dead-code nvmf log page discovery
In-Reply-To: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180820003607.21899-6-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 9bf2594..514082e 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -353,9 +353,9 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 
 	/* needs to be freed by the caller */
 	*logp = log;
+	error = DISC_OK;
 	goto out_close;
 
-	error = DISC_OK;
 out_free_log:
 	free(log);
 out_close:
-- 
2.14.1
