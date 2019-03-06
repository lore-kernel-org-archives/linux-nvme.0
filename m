From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  6 Mar 2019 01:42:31 -0800
Subject: [PATCH nvme-cli] nvme: print I/O error to stderr
Message-ID: <20190306094231.9197-1-sagi@grimberg.me>

something like blktests might rely on this to output to
stderr.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 8aac2ef1f673..e88d19940df5 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4413,7 +4413,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	if (err < 0)
 		perror("submit-io");
 	else if (err)
-		printf("%s:%s(%04x)\n", command, nvme_status_to_string(err), err);
+		fprintf(stderr, "%s:%s(%04x)\n", command, nvme_status_to_string(err), err);
 	else {
 		if (!(opcode & 1) && write(dfd, (void *)buffer, cfg.data_size) < 0) {
 			fprintf(stderr, "write: %s: failed to write buffer to output file\n",
-- 
2.17.1
