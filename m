From: jsmart2021@gmail.com (James Smart)
Date: Tue, 20 Mar 2018 10:33:57 -0700
Subject: [PATCH] nvme-cli: correct spelling of discovery
Message-ID: <20180320173357.5928-1-jsmart2021@gmail.com>

correct dicovery to discovery

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 774d5dc..62bd3be 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -736,10 +736,10 @@ static int do_discover(char *argstr, bool connect)
 		break;
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
-		"Numrec values of last two get dicovery log page not equal\n");
+		"Numrec values of last two get discovery log page not equal\n");
 		break;
 	default:
-		fprintf(stderr, "Get dicovery log page failed: %d\n", ret);
+		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
 		break;
 	}
 
-- 
2.13.1
