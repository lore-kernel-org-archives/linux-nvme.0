From: dmilburn@redhat.com (David Milburn)
Date: Thu, 31 May 2018 14:07:47 -0500
Subject: [PATCH] nvme-cli: report subsystem-reset not supported by controller
Message-ID: <1527793667-14356-1-git-send-email-dmilburn@redhat.com>

Add a little more description for "nvme subsystem-reset"
failures, currently driver reports "Inappropriate ioctl
for device".

$ nvme subsystem-reset /dev/nvme0
Subsystem-reset: Inappropriate ioctl for device

With this change report controller doesn't support
NVM Subsystem Reset.

$ nvme subsystem-reset /dev/nvme0
Subsystem-reset: NVM Subsystem Reset not supported.
---
 nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index a065e5d..2798e4b 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2154,7 +2154,10 @@ static int subsystem_reset(int argc, char **argv, struct command *cmd, struct pl
 	err = nvme_subsystem_reset(fd);
 	if (err < 0) {
 		close(fd);
-		perror("Subsystem-reset");
+		if (errno == ENOTTY)
+			fprintf(stderr, "Subsystem-reset: NVM Subsystem Reset not supported.\n");
+		else
+			perror("Subsystem-reset");
 		return errno;
 	}
 
-- 
1.8.3.1
