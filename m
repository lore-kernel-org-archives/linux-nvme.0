From: hare@suse.de (Hannes Reinecke)
Date: Mon,  5 Nov 2018 16:00:36 +0100
Subject: [PATCH] nvme: fixup ANA group descriptor offset
Message-ID: <20181105150036.17041-1-hare@suse.de>

The ANA group descriptor offset changed between the specification
sent for ratification and the final ratified document, causing the
ANA log page not to be displayed correctly.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 37d3bc1..1ad970a 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -546,7 +546,7 @@ struct nvme_ana_group_desc {
 	__le32  nnsids;
 	__le64  chgcnt;
 	__u8    state;
-	__u8    rsvd17[7];
+	__u8    rsvd17[15];
 	__le32  nsids[];
 };
 
-- 
2.13.7
