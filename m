From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Feb 2019 08:22:44 -0700
Subject: [PATCH 13/13] nvmet: convert to SPDX identifiers
In-Reply-To: <20190219152244.17441-1-hch@lst.de>
References: <20190219152244.17441-1-hch@lst.de>
Message-ID: <20190219152244.17441-14-hch@lst.de>

Update license to use SPDX-License-Identifier instead of verbose license
text.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c   | 10 +---------
 drivers/nvme/target/configfs.c    | 10 +---------
 drivers/nvme/target/core.c        | 10 +---------
 drivers/nvme/target/discovery.c   | 10 +---------
 drivers/nvme/target/fabrics-cmd.c | 10 +---------
 drivers/nvme/target/io-cmd-bdev.c | 10 +---------
 drivers/nvme/target/nvmet.h       | 10 +---------
 7 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 11baeb14c388..76250181fee0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe admin command implementation.
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
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 618bbd006544..adb79545cdd7 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Configfs interface for the NVMe target.
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
 #include <linux/kernel.h>
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 88d260f31835..d44ede147263 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common code for the NVMe target.
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
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index d2cb71a0b419..0e1487181bb7 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Discovery service for the NVMe over Fabrics target.
  * Copyright (C) 2016 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/slab.h>
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 6cf1fd9eb32e..3a76ebc3d155 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe Fabrics command implementation.
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
 #include <linux/blkdev.h>
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b6d030d3259f..71dfedbadc26 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NVMe I/O command implementation.
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
 #include <linux/blkdev.h>
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3e4719fdba85..51e49efd7849 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1,14 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
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
 
 #ifndef _NVMET_H
-- 
2.20.1
