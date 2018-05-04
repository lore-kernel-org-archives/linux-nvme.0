From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:44 +0200
Subject: [PATCH 4/5] block: BLK_STS_NEXUS is a path failure
In-Reply-To: <20180504112845.38820-1-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
Message-ID: <20180504112845.38820-5-hare@suse.de>

A block error of BLK_STS_NEXUS is equivalent to a path failure,
so blk_path_error() should reflect this.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 include/linux/blk_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 17b18b91ebac..3c6aeba732f1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -80,7 +80,6 @@ static inline bool blk_path_error(blk_status_t error)
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
-	case BLK_STS_NEXUS:
 	case BLK_STS_MEDIUM:
 	case BLK_STS_PROTECTION:
 		return false;
-- 
2.12.3
