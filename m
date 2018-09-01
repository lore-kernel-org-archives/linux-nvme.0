From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 31 Aug 2018 18:36:03 -0700
Subject: [PATCH nvme-cli 2/4] fabrics: don't fail empty discovery log page
In-Reply-To: <20180901013605.10658-1-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
Message-ID: <20180901013605.10658-3-sagi@grimberg.me>

It can be possible that discovery subsystem will not return
any valid discovery records.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 28a3e3d9ac82..09cb97c5b880 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -762,7 +762,8 @@ static int do_discover(char *argstr, bool connect)
 		fprintf(stderr, "Get discovery log entries failed.\n");
 		break;
 	case DISC_NO_LOG:
-		fprintf(stderr, "No discovery log entries to fetch.\n");
+		fprintf(stdout, "No discovery log entries to fetch.\n");
+		ret = DISC_OK;
 		break;
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
-- 
2.17.1
