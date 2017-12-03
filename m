From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  3 Dec 2017 10:25:35 +0200
Subject: [PATCH v2 2/2] nvmetcli: decorate namespace, subsystem and port UI
In-Reply-To: <20171203082535.17663-1-sagi@grimberg.me>
References: <20171203082535.17663-1-sagi@grimberg.me>
Message-ID: <20171203082535.17663-2-sagi@grimberg.me>

Display some info on the on the UI node.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- Fixed nguid_set detection to refer to hex digits

 nvmetcli | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 0c590c9638f1..ead6429d5be5 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -24,7 +24,11 @@ import os
 import sys
 import configshell_fb as configshell
 import nvmet as nvme
+from string import hexdigits
+import uuid
 
+def ngiud_set(nguid):
+    return any(c in hexdigits and c != '0' for c in nguid)
 
 class UINode(configshell.node.ConfigNode):
     def __init__(self, name, parent=None, cfnode=None, shell=None):
@@ -160,6 +164,13 @@ class UISubsystemNode(UINode):
         UINamespacesNode(self)
         UIAllowedHostsNode(self)
 
+    def summary(self):
+        info = []
+        info.append("version=" + self.cfnode.get_attr("attr","version"))
+        info.append("allow_any=" + self.cfnode.get_attr("attr","allow_any_host"))
+        info.append("serial=" + self.cfnode.get_attr("attr","serial"))
+        return (", ".join(info), True)
+
 
 class UINamespacesNode(UINode):
     def __init__(self, parent):
@@ -247,6 +258,19 @@ class UINamespaceNode(UINode):
                 raise configshell.ExecutionError(
                     "The Namespace could not be disabled.")
 
+    def summary(self):
+        info = []
+        info.append("path=" + self.cfnode.get_attr("device", "path"))
+        ns_uuid = self.cfnode.get_attr("device", "uuid")
+        if uuid.UUID(ns_uuid).int != 0:
+            info.append("uuid=" + str(ns_uuid))
+        ns_nguid = self.cfnode.get_attr("device", "nguid")
+        if ngiud_set(ns_nguid):
+            info.append("nguid=" + ns_nguid)
+        info.append("enabled" if self.cfnode.get_enable() else "disabled")
+        ns_enabled = self.cfnode.get_enable()
+        return (", ".join(info), True if ns_enabled == 1 else ns_enabled)
+
 
 class UIAllowedHostsNode(UINode):
     def __init__(self, parent):
@@ -356,6 +380,12 @@ class UIPortNode(UINode):
         UIPortSubsystemsNode(self)
         UIReferralsNode(self)
 
+    def summary(self):
+        info = []
+        info.append("traddr=" + self.cfnode.get_attr("addr", "traddr"))
+        info.append("trsvcid=" + self.cfnode.get_attr("addr", "trsvcid"))
+        info.append("trtype=" + self.cfnode.get_attr("addr", "trtype"))
+        return (", ".join(info), True)
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.14.1
