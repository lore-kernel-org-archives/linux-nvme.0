From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  5 Dec 2017 13:48:42 +0200
Subject: [PATCH] nvmetcli: port decoration coloring only if its enabled
Message-ID: <20171205114842.15212-1-sagi@grimberg.me>

Only color the port if its enabled (has subsystems or
referrals symlinks).

Also, don't display none trsvcid (like in the fc case).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmetcli | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index ead6429d5be5..6b102a235450 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -382,10 +382,13 @@ class UIPortNode(UINode):
 
     def summary(self):
         info = []
-        info.append("traddr=" + self.cfnode.get_attr("addr", "traddr"))
-        info.append("trsvcid=" + self.cfnode.get_attr("addr", "trsvcid"))
         info.append("trtype=" + self.cfnode.get_attr("addr", "trtype"))
-        return (", ".join(info), True)
+        info.append("traddr=" + self.cfnode.get_attr("addr", "traddr"))
+        trsvcid = self.cfnode.get_attr("addr", "trsvcid")
+        if trsvcid != "none":
+            info.append("trsvcid=%s" % trsvcid)
+        enabled = not (not self.cfnode.subsystems and not list(self.cfnode.referrals))
+        return (", ".join(info), True if enabled else 0)
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.14.1
