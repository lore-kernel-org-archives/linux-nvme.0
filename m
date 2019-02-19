From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:34 -0700
Subject: [PATCH 03/13] nvme-fabrics: convert to SPDX identifiers
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-4-hch@lst.de>

Update license to use SPDX-License-Identifier instead of verbose license
text.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 10 +---------
 drivers/nvme/host/fabrics.h | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3eb908c50e1a..4edfc5b221d2 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe over Fabrics common host code.
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
 #include <linux/init.h>
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 478343b73e38..3044d8b99a24 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * NVMe over Fabrics common host code.
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
 #ifndef _NVME_FABRICS_H
 #define _NVME_FABRICS_H 1
-- 
2.20.1
