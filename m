From: hch@lst.de (Christoph Hellwig)
Date: Fri,  9 Oct 2015 18:19:20 +0200
Subject: [PATCH] =?UTF-8?q?nvme:=20include=20<linux/types.=C4=A5>=20in=20<?=
 =?UTF-8?q?linux/nvme.h>?=
Message-ID: <1444407560-23454-1-git-send-email-hch@lst.de>

The buildbot complains about this even if it doesn't generate
a a build warning.  But it's an easy fix, so here we go:

Reported-by: kbuild test robot <fengguang.wu at intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9668d35..3af5f45 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -15,6 +15,8 @@
 #ifndef _LINUX_NVME_H
 #define _LINUX_NVME_H
 
+#include <linux/types.h>
+
 struct nvme_bar {
 	__u64			cap;	/* Controller Capabilities */
 	__u32			vs;	/* Version */
-- 
1.9.1
