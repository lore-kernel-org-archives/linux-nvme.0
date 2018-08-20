From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:03 -0400
Subject: [PATCH 1/5] nvme-cli: fix scaandir() return value
In-Reply-To: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180820003607.21899-2-chaitanya.kulkarni@wdc.com>

Don't use unsigned int for scandir() return value as it can return -1.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme.c b/nvme.c
index 99640cb..a893366 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1618,8 +1618,8 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	char path[264];
 	struct dirent **devices;
 	struct list_item *list_items;
-	unsigned int i, n, list_cnt = 0;
-	int fmt, ret, fd;
+	unsigned int list_cnt = 0;
+	int fmt, ret, fd, i, n;
 	const char *desc = "Retrieve basic information for the given device";
 	struct config {
 		char *output_format;
-- 
2.14.1
