From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:06:56 +0300
Subject: [PATCH 4/3 v1 nvmetcli] nvmetcli: expose nvmet port status and state
In-Reply-To: <20180412080656.1691-1-sagi@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
Message-ID: <20180412080656.1691-5-sagi@grimberg.me>

status reflects if any subsystems are bound and can
accept existing connections. state reflects the
physical state of the port. Also colorize UI if
port state is down.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmet/nvme.py | 11 +++++++++++
 nvmetcli      |  9 ++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index c245a4240dd9..290de2807930 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -174,6 +174,17 @@ class CFSNode(object):
             self._enable = int(file_fd.read().strip())
         return self._enable
 
+    def get_trstate(self):
+        self._check_self()
+        _trstate = None
+        path = "%s/trstate" % self.path
+        if not os.path.isfile(path):
+            return None
+
+        with open(path, 'r') as file_fd:
+            _trstate = file_fd.read().strip()
+        return _trstate
+
     def set_enable(self, value):
         self._check_self()
         path = "%s/enable" % self.path
diff --git a/nvmetcli b/nvmetcli
index 6b102a235450..fc6b0856c249 100755
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
+            trstate = self.cfnode.get_trstate()
+            info.append("state=" + trstate)
+            ret = True if trstate == "up" else False
+        return (", ".join(info), ret)
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.14.1
