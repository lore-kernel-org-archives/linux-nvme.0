From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  7 Aug 2016 15:19:24 +0300
Subject: [PATCH nvme-cli 3/4] fabrics: Remove redundant build_options
In-Reply-To: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470572365-20674-4-git-send-email-sagi@grimberg.me>

We call it again in do_discover.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 9f99e6175428..8c1a8331cc45 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -584,7 +584,6 @@ static int do_discover(char *argstr, bool connect)
 int discover(const char *desc, int argc, char **argv, bool connect)
 {
 	char argstr[BUF_SIZE];
-	int ret;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"transport", 't', "LIST", CFG_STRING, &cfg.transport, required_argument,
 			"transport type" },
@@ -599,12 +598,6 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 
 	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	cfg.nqn = NVME_DISC_SUBSYS_NAME;
-
-	ret = build_options(argstr, BUF_SIZE);
-	if (ret)
-		return ret;
-
 	return do_discover(argstr, connect);
 }
 
-- 
1.9.1
