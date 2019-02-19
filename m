From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:32 -0700
Subject: [PATCH 01/13] nvme_ioctl.h: remove duplicate GPL boilerplate
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-2-hch@lst.de>

We already have a SPDX header, so no need to duplicate the information.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h            | 10 +---------
 include/uapi/linux/nvme_ioctl.h |  9 ---------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bbcc83886899..baa49e6a23cc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1,15 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Definitions for the NVM Express interface
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
 
 #ifndef _LINUX_NVME_H
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 6e74b1eaf541..1c215ea1798e 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -2,15 +2,6 @@
 /*
  * Definitions for the NVM Express ioctl interface
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
 
 #ifndef _UAPI_LINUX_NVME_IOCTL_H
-- 
2.20.1
