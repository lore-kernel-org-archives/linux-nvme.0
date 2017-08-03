From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Thu, 3 Aug 2017 21:38:16 +0800
Subject: [PATCH] nvme-cli: fix connecting failure due to invalid uuid format
 of hostid
Message-ID: <1501767496-14144-1-git-send-email-guanjunxiong@huawei.com>

When we connect or discover a target with --hostid option via the
/etc/nvme/hostid file, we fails this operation because the hostid
is only 35 not 36 bytes which doesn't pass the uuid checking in the
kernel.The last character is overridden with null bytes because fgets
reads at most one less than sizeof of buffer characters.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index da4e04e..9ed1127 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -463,7 +463,7 @@ out:
 static int nvmf_hostid_file(void)
 {
 	FILE *f;
-	char hostid[NVMF_HOSTID_SIZE];
+	char hostid[NVMF_HOSTID_SIZE + 1];
 	int ret = false;
 
 	f = fopen(PATH_NVMF_HOSTID, "r");
-- 
2.11.1
