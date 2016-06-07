From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:17 +0200
Subject: [PATCH 01/11] Makefile: introduce OBJS variable
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-2-git-send-email-hch@lst.de>

Instead of listing all the objects twice.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9260ae4..72f5732 100644
--- a/Makefile
+++ b/Makefile
@@ -31,8 +31,10 @@ override CFLAGS += -DNVME_VERSION='"$(NVME_VERSION)"'
 
 NVME_DPKG_VERSION=1~`lsb_release -sc`
 
-nvme: nvme.c ./linux/nvme.h argconfig.o suffix.o nvme-print.o nvme-ioctl.o nvme-lightnvm.o NVME-VERSION-FILE
-	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c $(LDFLAGS) -o $(NVME) argconfig.o suffix.o nvme-print.o nvme-ioctl.o nvme-lightnvm.o
+OBJS := argconfig.o suffix.o nvme-print.o nvme-ioctl.o nvme-lightnvm.o
+
+nvme: nvme.c ./linux/nvme.h $(OBJS) NVME-VERSION-FILE
+	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c $(LDFLAGS) -o $(NVME) $(OBJS)
 
 nvme-ioctl.o: nvme-ioctl.c nvme-ioctl.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c nvme-ioctl.c
-- 
2.1.4
