From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:38 -0700
Subject: [PATCH 07/13] nvme-pci: convert to SPDX identifiers
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-8-hch@lst.de>

Update license to use SPDX-License-Identifier instead of verbose license
text.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..0ba02c7d677d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVM Express device driver
  * Copyright (c) 2011-2014, Intel Corporation.
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
 
 #include <linux/aer.h>
-- 
2.20.1
