From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat,  1 Jun 2019 16:00:03 +0900
Subject: [PATCH] nvme-cli: add default value for nsid of write-zeroes
Message-ID: <20190601070003.20142-1-minwoo.im.dev@gmail.com>

-L 3772,3778 is doing the default value check and update the nsid if
it's not given by the input:

	if (!cfg.namespace_id) {
		cfg.namespace_id = get_nsid(fd);
		if (cfg.namespace_id == 0) {
			err = EINVAL;
			goto close_fd;
		}
	}

This patch adds nsid default value to zero for the case user does not
give the nsid input.

Cc: Keith Busch <kbusch at kernel.org>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvme.c b/nvme.c
index 9819fcb..a7a96a1 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3731,6 +3731,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 
 	struct config cfg = {
 		.start_block     = 0,
+		.namespace_id    = 0,
 		.block_count     = 0,
 		.prinfo          = 0,
 		.ref_tag         = 0,
-- 
2.21.0
