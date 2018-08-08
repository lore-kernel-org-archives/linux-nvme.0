From: hare@suse.de (Hannes Reinecke)
Date: Wed,  8 Aug 2018 08:35:29 +0200
Subject: [PATCH] nvme: fixup ANA group descriptor format
Message-ID: <20180808063529.92478-1-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

ANA Phase 3 draft had the 'reserved' field in the group descriptor
format set to '23:17' (so that the first namespace identifier started
at byte 24), but that got move with the approved TP to '31:17'
(so that the first namespace identifier started at byte 32).

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 64c9175723de..a661861e9d56 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -446,7 +446,7 @@ struct nvme_ana_group_desc {
 	__le32	nnsids;
 	__le64	chgcnt;
 	__u8	state;
-	__u8	rsvd17[7];
+	__u8	rsvd17[15];
 	__le32	nsids[];
 };
 
-- 
2.13.7
