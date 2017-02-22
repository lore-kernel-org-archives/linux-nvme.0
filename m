From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 10:15:08 -0700
Subject: [PATCH 3/3] block/sed-opal: Propagate original error message to
 userland.
In-Reply-To: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
References: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1487783708-16285-4-git-send-email-scott.bauer@intel.com>

During an error on a comannd, ex: user provides wrong pw to unlock
range, we will gracefully terminate the opal session. We want to
propagate the original error to userland instead of the result of
the session termination, which is almost always a success.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 block/sed-opal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 020bf3e..1e18dca 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -396,8 +396,11 @@ static int next(struct opal_dev *dev)
 			 * session. Therefore we shouldn't attempt to terminate
 			 * a session, as one has not yet been created.
 			 */
-			if (state > 1)
-				return end_opal_session_error(dev);
+			if (state > 1) {
+				end_opal_session_error(dev);
+				return error;
+			}
+
 		}
 		state++;
 	} while (!error);
-- 
2.7.4
