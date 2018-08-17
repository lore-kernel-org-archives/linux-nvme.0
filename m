From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 Aug 2018 09:29:04 +0200
Subject: [PATCH 2/6] nvme-vendor: fixup c99 declaration in huawei plugin
In-Reply-To: <20180817072908.56784-1-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
Message-ID: <20180817072908.56784-3-hare@suse.de>

We can't use c99 declaration with older compilers.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 huawei-nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/huawei-nvme.c b/huawei-nvme.c
index f305405..f91d3e3 100644
--- a/huawei-nvme.c
+++ b/huawei-nvme.c
@@ -245,12 +245,13 @@ static void huawei_print_list_item(struct huawei_list_item list_item,
 	char usage[128];
 	char nguid_buf[2 * sizeof(list_item.ns.nguid) + 1];
 	char *nguid = nguid_buf;
+	int i;
 
 	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
 		nsze, s_suffix);
 
 	memset(nguid, 0, sizeof(nguid_buf));
-	for (int i = 0; i < sizeof(list_item.ns.nguid); i++)
+	for (i = 0; i < sizeof(list_item.ns.nguid); i++)
 		nguid += sprintf(nguid, "%02x", list_item.ns.nguid[i]);
 
 	printf("%-*.*s %-*.*s %-*.*s %-*d %-*.*s %-*.*s\n",
-- 
2.13.7
