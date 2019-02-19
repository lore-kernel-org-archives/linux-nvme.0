From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:33 -0700
Subject: [PATCH 02/13] nvme-tcp.h: fix SPDX header
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-3-hch@lst.de>

For .h files we need to use /* */ style comments.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme-tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 03d87c0550a9..959e0bd9a913 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * NVMe over Fabrics TCP protocol header.
  * Copyright (c) 2018 Lightbits Labs. All rights reserved.
-- 
2.20.1
