From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Thu, 15 Feb 2018 14:11:58 +0100
Subject: [PATCH v2 4/6] lightnvm: remove max_rq_size
In-Reply-To: <20180215131200.3354-1-mb@lightnvm.io>
References: <20180215131200.3354-1-mb@lightnvm.io>
Message-ID: <20180215131200.3354-5-mb@lightnvm.io>

The field is no longer used.

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 drivers/lightnvm/core.c  | 1 -
 include/linux/lightnvm.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9b1255b3e05e..511c81c319ee 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -874,7 +874,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	geo->sec_size = id->csecs;
 	geo->oob_size = id->sos;
 	geo->mccap = id->mccap;
-	geo->max_rq_size = dev->ops->max_phys_sect * geo->sec_size;
 
 	geo->sec_per_chk = id->clba;
 	geo->sec_per_lun = geo->sec_per_chk * geo->nr_chks;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b717c000b712..67b4fa8e4906 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -295,8 +295,6 @@ struct nvm_geo {
 	int ws_seq;
 	int ws_per_chk;
 
-	int max_rq_size;
-
 	int op;
 
 	struct nvm_addr_format ppaf;
-- 
2.11.0
