From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  3 Aug 2017 11:28:48 +0200
Subject: [PATCH 2/2] nvmet: fcloop: remove ALL_OPTS define
In-Reply-To: <20170803092848.7788-1-jthumshirn@suse.de>
References: <20170803092848.7788-1-jthumshirn@suse.de>
Message-ID: <20170803092848.7788-2-jthumshirn@suse.de>

ALL_OPTS isn't used anywhere, remove it.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/fcloop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1bb9d5b311b1..1cb9847ec261 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -193,9 +193,6 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
 
 #define TGTPORT_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN)
 
-#define ALL_OPTS	(NVMF_OPT_WWNN | NVMF_OPT_WWPN | NVMF_OPT_ROLES | \
-			 NVMF_OPT_FCADDR | NVMF_OPT_LPWWNN | NVMF_OPT_LPWWPN)
-
 
 static DEFINE_SPINLOCK(fcloop_lock);
 static LIST_HEAD(fcloop_lports);
-- 
2.12.3
