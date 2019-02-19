From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:36 -0700
Subject: [PATCH 05/13] nvme-rdma: convert to SPDX identifiers
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-6-hch@lst.de>

Update license to use SPDX-License-Identifier instead of verbose license
text.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c  | 10 +---------
 include/linux/nvme-rdma.h | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ac365366c2ec..7c0d29185249 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe over Fabrics RDMA host code.
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
 #include <linux/module.h>
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index a72fd04aa5e1..3aa97b98dc89 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -1,14 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 Mellanox Technologies. All rights reserved.
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
 
 #ifndef _LINUX_NVME_RDMA_H
-- 
2.20.1
