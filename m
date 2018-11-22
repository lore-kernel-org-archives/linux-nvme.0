From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:13 -0800
Subject: [PATCH nvme-cli v3 15/13] nvme: Add TCP transport
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-16-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c    | 2 ++
 linux/nvme.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index e7c2021b0c70..86f6f992b14f 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -95,6 +95,7 @@ static const char *arg_str(const char * const *strings,
 static const char * const trtypes[] = {
 	[NVMF_TRTYPE_RDMA]	= "rdma",
 	[NVMF_TRTYPE_FC]	= "fibre-channel",
+	[NVMF_TRTYPE_TCP]	= "tcp",
 	[NVMF_TRTYPE_LOOP]	= "loop",
 };
 
@@ -696,6 +697,7 @@ retry:
 
 	switch (e->trtype) {
 	case NVMF_TRTYPE_RDMA:
+	case NVMF_TRTYPE_TCP:
 		switch (e->adrfam) {
 		case NVMF_ADDR_FAMILY_IP4:
 		case NVMF_ADDR_FAMILY_IP6:
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
