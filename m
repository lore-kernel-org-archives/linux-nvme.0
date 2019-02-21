From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Feb 2019 19:22:34 +0100
Subject: [PATCH] nvmet: disable direct I/O when unavailable
Message-ID: <20190221182234.22345-1-jthumshirn@suse.de>

Some file-systems, like tmpfs, do not support direct IO, but file-backed
namespaces default to using direct IO. If direct IO is unavailable fall
back to using buffered IO for the file-backed namespace.

This might not ultimately be a solution for production environments but
for test environments it sometimes is feasible to use tmpfs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/io-cmd-file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..8a861cc0160e 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -38,11 +38,21 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
+		if (ns->file == ERR_PTR(-EINVAL) && (flags & O_DIRECT)) {
+			flags &= ~O_DIRECT;
+			ns->buffered_io = 0;
+			ns->file = filp_open(ns->device_path, flags, 0);
+			if (!IS_ERR(ns->file)) {
+				pr_info("direct I/O unavailable, falling back to buffered I/O\n");
+				goto getattr;
+			}
+		}
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
 		return PTR_ERR(ns->file);
 	}
 
+getattr:
 	ret = vfs_getattr(&ns->file->f_path,
 			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
 	if (ret)
-- 
2.16.4
