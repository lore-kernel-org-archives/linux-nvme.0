From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 19:00:17 -0800
Subject: [PATCH nvme-cli v2 15/14] nvme: Add TCP transport
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Message-ID: <20181120030019.31738-17-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c    | 5 ++++-
 linux/nvme.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index be6a18cd4787..b4fac97253ba 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -96,6 +96,7 @@ static const char *arg_str(const char * const *strings,
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
@@ -703,11 +704,13 @@ retry:
 		/* we can safely ignore the rest of the entries */
 		break;
 	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
 			/* FALLTHRU */
-			len = sprintf(p, ",transport=rdma");
+			len = sprintf(p, ",transport=%s",
+				e->trtype == NVMF_TRTYPE_RDMA ? "rdma" : "tcp");
 			if (len < 0)
 				return -EINVAL;
 			p += len;
diff --git a/linux/nvme.h b/linux/nvme.h
index a6a44b066267..7a600c791877 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -52,6 +52,7 @@ enum {
 enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
+	NVMF_TRTYPE_TCP		= 3,	/* TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.17.1
