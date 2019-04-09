From: jsmart2021@gmail.com (James Smart)
Date: Tue,  9 Apr 2019 13:51:54 -0700
Subject: [PATCH] nvme-cli: Revert stop-on-failure with connect-all
Message-ID: <20190409205154.15197-1-jsmart2021@gmail.com>

The patch that added special treatment for EALREADY connect failures
also changed the behavior on what happens if a discovery log contains
an entry that is not connectable by the system or host port. If it
encounters a log entry that can't be connected to, it will not attempt
to connect to any log entries beyond it. This can leave lots of devices
unconnected to.

Revert the stop-on-failure introduced by the previous patch.

Specifically, this failed for me on an FC array that had a discovery log
entry for a port that was not visible via zoning for the initiator
port being used.

Fixes: 1a922e0e121d7 ("connect-all: special treatment to EALREADY afetr write to /dev/nvme-fabrics"
Signed-off-by: James Smart <jsmart2021 at gmail.com>
CC: Eyal Ben David <eyalbe at il.ibm.com>
CC: Martin George <Martin.George at netapp.com>
---
 fabrics.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 1a9a3fb..511de06 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -833,9 +833,12 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 			continue;
 		}
 
-		/* otherwise error */
-		ret = -instance;
-		break;
+		/*
+		 * don't error out. The Discovery Log may contain
+		 * devices that aren't necessarily connectable via
+		 * the system/host transport port. Let those items
+		 * fail and continue on to the next log element.
+		 */
 	}
 
 	return ret;
-- 
2.13.7
