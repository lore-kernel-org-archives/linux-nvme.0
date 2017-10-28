From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 29 Oct 2017 03:01:52 +0900
Subject: [PATCH] nvme-cli: fix wrong bitmask in number of rpmb units.
Message-ID: <1509213712-32675-1-git-send-email-minwoo.im.dev@gmail.com>

Number of RPMB Units is a 3-bit field[02:00].
Bitmask should be 0111b(7h) to get this field.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 9f524cd..e79b3f4 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -218,7 +218,7 @@ static void show_nvme_id_ctrl_rpmbs(__le32 ctrl_rpmbs)
 	__u32 tsz = (rpmbs & 0xFF0000) >> 16;
 	__u32 rsvd = (rpmbs & 0xFFC0) >> 6;
 	__u32 auth = (rpmbs & 0x38) >> 3;
-	__u32 rpmb = rpmbs & 0x3;
+	__u32 rpmb = rpmbs & 0x7;
 
 	printf(" [31:24]: %#x\tAccess Size\n", asz);
 	printf(" [23:16]: %#x\tTotal Size\n", tsz);
-- 
2.7.4
