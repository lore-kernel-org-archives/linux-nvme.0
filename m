From: jsmart2021@gmail.com (James Smart)
Date: Mon,  4 Feb 2019 13:39:54 -0800
Subject: [PATCH] nvme-cli: fix fc trtype string
Message-ID: <20190204213954.32509-1-jsmart2021@gmail.com>

Commit 55b4ec12ffe4
("fabrics: use trtype_str when parsing a discovery log entry")
changed to use the trtypes string names in a generic fashion for
the "transport=?" string passed in the connect string to the kernel.

For FC, this meant the hardcoding of "transport=fc" was removed and
the generic code would now create "transport=fibre-channel", which
doesn't match any transport name anymore once the string is attempted
to be matched in the kernel.

Change the string used by for trtype for FC to use "fc" to restore
operation.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 594789b..f5cd212 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -98,7 +98,7 @@ static const char *arg_str(const char * const *strings,
 
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
-	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_FC]	= "fc",
 	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
-- 
2.13.7
