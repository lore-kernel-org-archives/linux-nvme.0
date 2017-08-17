From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 Aug 2017 13:59:34 +0200
Subject: [PATCH] nvme-fabrics: fix reporting of unrecognized options
Message-ID: <20170817115934.3999-1-hch@lst.de>

Only print the specified options that are not recognized, instead
of the whole list of options.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6238452af6a4..81d18c2921df 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -795,7 +795,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(opt_tokens); i++) {
-			if (opt_tokens[i].token & ~allowed_opts) {
+			if ((opt_tokens[i].token & opts->mask) &&
+			    (opt_tokens[i].token & ~allowed_opts)) {
 				pr_warn("invalid parameter '%s'\n",
 					opt_tokens[i].pattern);
 			}
-- 
2.11.0
