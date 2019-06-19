From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:51 -0700
Subject: [PATCH nvme-cli 03/13] huawei: Declare local functions static
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-4-bvanassche@acm.org>

This patch avoids that sparse complains about missing declarations.

Cc: Zou Ming <zouming.zouming at huawei.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 plugins/huawei/huawei-nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index b68e05c55aee..3130607a6443 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -163,7 +163,8 @@ static void format(char *formatter, size_t fmt_sz, char *tofmt, size_t tofmtsz)
 	}
 }
 
-void huawei_json_print_list_items(struct huawei_list_item *list_items, unsigned len)
+static void huawei_json_print_list_items(struct huawei_list_item *list_items,
+					 unsigned len)
 {
 	struct json_object *root;
 	struct json_array *devices;
-- 
2.22.0.rc3
