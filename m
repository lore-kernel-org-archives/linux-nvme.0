From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:18 -0700
Subject: [PATCH 4/6] nvme-cli: use uniform if .. else format
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-5-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/nvme.c b/nvme.c
index 220fb18..971a926 100644
--- a/nvme.c
+++ b/nvme.c
@@ -212,8 +212,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 			json_smart_log(&smart_log, cfg.namespace_id, devicename);
 		else
 			show_smart_log(&smart_log, cfg.namespace_id, devicename);
-	}
-	else if (err > 0)
+	} else if (err > 0)
 		show_nvme_status(err);
 	else
 		perror("smart log");
@@ -2244,8 +2243,7 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
 	err = nvme_virtual_mgmt(fd, cfg.cdw10, cfg.cdw11, &result);
 	if (!err) {
 		printf("success, Number of Resources allocated:%#x\n", result);
-	}
-	else if (err > 0) {
+	} else if (err > 0) {
 		show_nvme_status(err);
 	} else
 		perror("virt-mgmt");
-- 
2.17.0
