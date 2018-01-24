From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jan 2018 21:26:02 +0900
Subject: [PATCH] nvme-cli: add command specific field to json output of
 error-log
Message-ID: <1516796762-32007-1-git-send-email-minwoo.im.dev@gmail.com>

Add command specific field to json output of error-log command.
This field was added in commit 662c1618 without considering json output
format.

Fixes: 662c1618("nvme-cli: add print for command specific info field of error log page")
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme-print.c b/nvme-print.c
index 1ca4b71..2e8e56f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1841,6 +1841,7 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 		json_object_add_value_int(error, "lba", err_log[i].lba);
 		json_object_add_value_int(error, "nsid", err_log[i].nsid);
 		json_object_add_value_int(error, "vs", err_log[i].vs);
+		json_object_add_value_uint(error, "cs", err_log[i].cs);
 
 		json_array_add_value_object(errors, error);
 	}
-- 
2.7.4
