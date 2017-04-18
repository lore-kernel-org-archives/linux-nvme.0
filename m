From: yizhan@redhat.com (Yi Zhang)
Date: Tue, 18 Apr 2017 17:20:24 +0800
Subject: [PATCH] nvme-cli: return 0 if disconnect operation with cfg.nqn
 successfully
Message-ID: <20170418092024.18252-1-yizhan@redhat.com>

disconnect_by_nqn function will return the number of controllers
successfully disconnected, so change ret = 0 if disconnect operation
with nqn successfully.

$ ./nvme disconnect -n testnqn
NQN:testnqn disconnected 1 controller(s)
$ echo $?
1

Signed-off-by: Yi Zhang <yizhan at redhat.com>
---
 fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index cd671c7..a2e8f60 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -934,8 +934,10 @@ int disconnect(const char *desc, int argc, char **argv)
 		if (ret < 0)
 			fprintf(stderr, "Failed to disconnect by NQN: %s\n",
 				cfg.nqn);
-		else
+		else {
 			printf("NQN:%s disconnected %d controller(s)\n", cfg.nqn, ret);
+			ret = 0;
+		}
 	}
 
 	if (cfg.device) {
-- 
2.9.3
