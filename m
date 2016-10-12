From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Oct 2016 10:45:51 +0200
Subject: [PATCH 1/3] consolidate reporting bugs information
In-Reply-To: <1476261953-23119-1-git-send-email-hch@lst.de>
References: <1476261953-23119-1-git-send-email-hch@lst.de>
Message-ID: <1476261953-23119-2-git-send-email-hch@lst.de>

Add the Linux-nvme list to the main reporting bugs section and remove
the separate ones in the connect and discovery pages.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 Documentation/nvme-connect.txt  | 6 ------
 Documentation/nvme-discover.txt | 6 ------
 Documentation/nvme.txt          | 3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index 18338cb..9ba969e 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -78,12 +78,6 @@ This was co-written by mailto:james.p.freyensee at intel.com[Jay Freyensee]
 and mailto:hch at lst.de[Christoph Hellwig]
 for mailto:keith.busch at intel.com[Keith Busch].
 
-REPORTING BUGS
---------------
-Patches and issues for 'connect' should be submitted to the
-Linux kernel email list mailto:linux-nvme at lists.infradead.org[linux-nvme]
-before merging to https://github.com/linux-nvme/nvme-cli.
-
 NVME
 ----
 Part of the nvme-user suite
diff --git a/Documentation/nvme-discover.txt b/Documentation/nvme-discover.txt
index bff4767..9140f84 100644
--- a/Documentation/nvme-discover.txt
+++ b/Documentation/nvme-discover.txt
@@ -119,12 +119,6 @@ AUTHORS
 This was written by mailto:james.p.freyensee at intel.com[Jay Freyensee]
 for mailto:keith.busch at intel.com[Keith Busch].
 
-REPORTING BUGS
---------------
-Patches and issues for 'discover' should be submitted to the Linux
-kernel email list mailto:linux-nvme at lists.infradead.org[linux-nvme]
-before merging to https://github.com/linux-nvme/nvme-cli.
-
 NVME
 ----
 Part of the nvme-user suite
diff --git a/Documentation/nvme.txt b/Documentation/nvme.txt
index dcbc660..cb64082 100644
--- a/Documentation/nvme.txt
+++ b/Documentation/nvme.txt
@@ -46,7 +46,8 @@ This is written and maintained by mailto:keith.busch at intel.com[Keith Busch].
 Reporting Bugs
 --------------
 Patches and issues may be submitted to the official repository at
-https://github.com/linux-nvme/nvme-cli.
+https://github.com/linux-nvme/nvme-cli or the Linux NVMe mailing list
+mailto:linux-nvme at lists.infradead.org[linux-nvme]
 
 NVME
 ----
-- 
2.10.1.382.ga23ca1b
