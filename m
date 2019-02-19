From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:42 -0700
Subject: [PATCH 11/13] nvme-loop: convert to SPDX identifiers
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-12-hch@lst.de>

Update license to use SPDX-License-Identifier instead of verbose license
text.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/loop.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4aac1b4a8112..b9f623ab01f3 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe over Fabrics loopback device.
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/scatterlist.h>
-- 
2.20.1
