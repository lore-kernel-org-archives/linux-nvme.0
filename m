From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 10:57:29 -0700
Subject: [PATCH v2 2/1 nvmetcli] nvmet: add namespace debug attr group
In-Reply-To: <20181030175729.25011-1-sagi@grimberg.me>
References: <20181030175729.25011-1-sagi@grimberg.me>
Message-ID: <20181030175729.25011-2-sagi@grimberg.me>

Add a debug class for setting/getting namespace debug features.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmet/nvme.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 7ab0846bf835..561a9a4c9ba2 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -554,7 +554,7 @@ class Namespace(CFSNode):
             if nsid < 1 or nsid > self.MAX_NSID:
                 raise CFSError("NSID must be 1 to %d" % self.MAX_NSID)
 
-        self.attr_groups = ['device']
+        self.attr_groups = ['device', 'debug']
         self._subsystem = subsystem
         self._nsid = nsid
         self._path = "%s/namespaces/%d" % (self.subsystem.path, self.nsid)
-- 
2.17.1
