From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 14 Dec 2015 01:14:43 +0000
Subject: [PATCH] nvme: Stop installing kernel-only <linux/nvme.h> as UAPI
Message-ID: <20151214011442.GL28542@decadent.org.uk>

Fixes: 9d99a8dda154 ("nvme: move hardware structures out of the uapi ...")
Signed-off-by: Ben Hutchings <ben at decadent.org.uk>
---
 include/uapi/linux/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 628e6e6..41652af 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -306,7 +306,6 @@ header-y += nfs_mount.h
 header-y += nl80211.h
 header-y += n_r3964.h
 header-y += nubus.h
-header-y += nvme.h
 header-y += nvram.h
 header-y += omap3isp.h
 header-y += omapfb.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20151214/00dbca0f/attachment.sig>
