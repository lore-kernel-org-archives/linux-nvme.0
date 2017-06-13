From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 15:07:09 +0200
Subject: [PATCH] nvme: fix string_matches() helper
Message-ID: <20170613130709.7150-1-hch@lst.de>

NVMe "ASCII" strings are not nul-terminated and can use up every single
byte in the field.  Thus use strnlen to determine the match length instead
of possibly overrunning the field.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 434b18863895..2658a3a3cbb5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1581,9 +1581,7 @@ static bool string_matches(const char *idstr, const char *match, size_t len)
 	if (!match)
 		return true;
 
-	matchlen = strlen(match);
-	WARN_ON_ONCE(matchlen > len);
-
+	matchlen = strnlen(match, len);
 	if (memcmp(idstr, match, matchlen))
 		return false;
 
-- 
2.11.0
