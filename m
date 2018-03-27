From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Tue, 27 Mar 2018 11:34:00 +0300
Subject: [PATCH 4/3 rfc nvmetcli] nvmetcli: expose nvmet port status and
 state
In-Reply-To: <20180322190303.10951-5-sagi@grimberg.me>
References: <20180322190303.10951-5-sagi@grimberg.me>
Message-ID: <1522139640-1961-1-git-send-email-nitzanc@mellanox.com>

Hi Sagi,

Please see my suggestion below, for a minor improvement to your
nvmetcli patch, which makes the built-in "status" UI function
available for the port (like in namespaces).

Besides, I think the terminology of "status"/"state" might be confusing.
Don't you think it is better to stay with "trstate"/"tractive" namings?

Nitzan.

---
 nvmet/nvme.py |  5 +++++
 nvmetcli      | 15 +++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index c245a42..dc28b31 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -625,6 +625,11 @@ class Port(CFSNode):
     subsystems = property(_list_subsystems,
                           doc="Get the list of Subsystem for this Port.")
 
+    def _is_active(self):
+        return bool(int(self.get_attr("addr", "tractive")))
+
+    active = property(_is_active, doc="Physical state of the port")
+
     def add_subsystem(self, nqn):
         '''
         Enable access to the Subsystem identified by I{nqn} through this Port.
diff --git a/nvmetcli b/nvmetcli
index 1a7cf67..46e34b2 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -380,6 +380,11 @@ class UIPortNode(UINode):
         UIPortSubsystemsNode(self)
         UIReferralsNode(self)
 
+    def status(self):
+        status = "enabled" if self.cfnode.subsystems else "disabled"
+        state = "up" if self.cfnode.active else "down"
+        return "status=%s, state=%s" % (status, state)
+
     def summary(self):
         info = []
         info.append("trtype=" + self.cfnode.get_attr("addr", "trtype"))
@@ -387,14 +392,8 @@ class UIPortNode(UINode):
         trsvcid = self.cfnode.get_attr("addr", "trsvcid")
         if trsvcid != "none":
             info.append("trsvcid=%s" % trsvcid)
-        enabled = not (not self.cfnode.subsystems and not list(self.cfnode.referrals))
-        info.append("status=" + ("enabled" if enabled else "disabled"))
-        if not enabled:
-            ret = 0
-        else:
-            active = not (not int(self.cfnode.get_attr("addr", "tractive")))
-            info.append("state=" + ("up" if active else "down"))
-            ret = True if active else False
+        info.append(self.status())
+        ret = self.cfnode.active
         return (", ".join(info), ret)
 
 class UIPortSubsystemsNode(UINode):
-- 
1.8.3.1
