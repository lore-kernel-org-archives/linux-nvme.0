From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu,  8 Mar 2018 19:38:16 +0200
Subject: [PATCH 1/1] nvme-cli: fabrics: Fix passing "host_traddr" for all
 transports
Message-ID: <1520530696-32210-1-git-send-email-maxg@mellanox.com>

Currently only FC transport passes "host_traddr" to the kernel during
nvme connect-all command. Fix it for all transports.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 4bdaaf2..774d5dc 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -614,6 +614,14 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p += len;
 	}
 
+	if (cfg.host_traddr) {
+		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
+		if (len < 0)
+			return -EINVAL;
+		p+= len;
+	}
+
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
@@ -659,11 +667,6 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 				return -EINVAL;
 			p += len;
 
-			len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
-			if (len < 0)
-				return -EINVAL;
-			p+= len;
-
 			len = sprintf(p, ",traddr=%.*s",
 				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
 				      e->traddr);
-- 
2.14.1
