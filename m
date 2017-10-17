From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 17 Oct 2017 13:34:56 +0300
Subject: [PATCH nvmetcli 2/2] nvmetcli: decorate namespace,
 subsystem and port UI
In-Reply-To: <1508236496-23921-1-git-send-email-sagi@grimberg.me>
References: <1508236496-23921-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508236496-23921-2-git-send-email-sagi@grimberg.me>

Display some info on the on the UI node.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmetcli | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 951b6431e6f0..ae86e89b61aa 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -24,7 +24,10 @@ import os
 import sys
 import configshell_fb as configshell
 import nvmet as nvme
+import uuid
 
+def ngiud_set(nguid):
+    return any(c.isdigit() and c != '0' for c in nguid)
 
 class UINode(configshell.node.ConfigNode):
     def __init__(self, name, parent=None, cfnode=None, shell=None):
@@ -160,6 +163,13 @@ class UISubsystemNode(UINode):
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
@@ -247,6 +257,19 @@ class UINamespaceNode(UINode):
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
@@ -361,6 +384,13 @@ class UIPortNode(UINode):
             return "enabled"
         return "disabled"
 
+    def summary(self):
+        info = []
+        info.append("traddr=" + self.cfnode.get_attr("addr", "traddr"))
+        info.append("trsvcid=" + self.cfnode.get_attr("addr", "trsvcid"))
+        info.append("trtype=" + self.cfnode.get_attr("addr", "trtype"))
+        return (", ".join(info), True)
+
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.7.4
