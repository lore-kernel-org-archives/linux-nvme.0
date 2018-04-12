From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 16:32:33 +0300
Subject: [PATCH v2 nvmetcli] nvmetcli: expose nvmet port status and state
Message-ID: <20180412133233.13920-1-sagi@grimberg.me>

status reflects if any subsystems are bound and can
accept existing connections. state reflects the
physical state of the port. Also colorize UI if
port state is down.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmet/nvme.py | 13 +++++++++++++
 nvmetcli      |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index c245a4240dd9..f5d0555d2acd 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -618,6 +618,19 @@ class Port(CFSNode):
 
     portid = property(_get_portid, doc="Get the Port ID as an int.")
 
+    def _get_state(self):
+        self._check_self()
+        _state = None
+        path = "%s/trstate" % self.path
+        if not os.path.isfile(path):
+            return None
+
+        with open(path, 'r') as file_fd:
+            _state = file_fd.read().strip()
+        return _state
+
+    state = property(_get_state, doc="Get the Port state.")
+
     def _list_subsystems(self):
         return [os.path.basename(name)
                 for name in os.listdir("%s/subsystems/" % self._path)]
diff --git a/nvmetcli b/nvmetcli
index 6b102a235450..5d5aabc89b1c 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -388,7 +388,14 @@ class UIPortNode(UINode):
         if trsvcid != "none":
             info.append("trsvcid=%s" % trsvcid)
         enabled = not (not self.cfnode.subsystems and not list(self.cfnode.referrals))
-        return (", ".join(info), True if enabled else 0)
+        info.append("status=" + ("enabled" if enabled else "disabled"))
+        if not enabled:
+            ret = 0
+        else:
+            trstate = self.cfnode.state
+            info.append("state=" + trstate)
+            ret = True if trstate == "up" else False
+        return (", ".join(info), ret)
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.14.1
