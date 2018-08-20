From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:06 -0400
Subject: [PATCH 4/5] nvme-cli: don't use unsigned for fd in lnvm-nvme.c
In-Reply-To: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180820003607.21899-5-chaitanya.kulkarni@wdc.com>

Change the data type of the fd from unsigned int -> int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 lnvm-nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lnvm-nvme.c b/lnvm-nvme.c
index 5130919..754931a 100644
--- a/lnvm-nvme.c
+++ b/lnvm-nvme.c
@@ -95,7 +95,8 @@ static int lnvm_id_ns(int argc, char **argv, struct command *cmd, struct plugin
 	const char *raw_binary = "show infos in binary format";
 	const char *human_readable = "show infos in readable format";
 	const char *namespace_id = "identifier of desired namespace. default: 1";
-	unsigned int fd, flags = 0;
+	unsigned int flags = 0;
+	int fd;
 
 	struct config {
 		__u32 namespace_id;
-- 
2.14.1
