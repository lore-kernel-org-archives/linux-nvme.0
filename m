From: bkenward@solarflare.com (Bert Kenward)
Date: Fri, 10 Mar 2017 11:31:04 +0000
Subject: [PATCH RFC 1/4] nvme-fabrics: add TCP as valid NVMe transport type
In-Reply-To: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
Message-ID: <6d0af936-06b2-ffbc-248a-2586efa35064@solarflare.com>

From: Ripduman Sohan <rip.sohan@verrko.com>

Cc: Lucian Carata <lucian.carata at cl.cam.ac.uk>
Signed-off-by: Ripduman Sohan <rip.sohan at verrko.com>
Signed-off-by: Bert Kenward <bkenward at solarflare.com>
---
 include/linux/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c43d435d4225..bfe6f2121e5b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -49,6 +49,7 @@ enum {
 enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP         = 3,    /* TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.7.4
