From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 22 Mar 2018 21:03:03 +0200
Subject: [PATCH 4/3 rfc nvmetcli] nvmetcli: expose nvmet port status and state
In-Reply-To: <20180322190303.10951-1-sagi@grimberg.me>
References: <20180322190303.10951-1-sagi@grimberg.me>
Message-ID: <20180322190303.10951-5-sagi@grimberg.me>

status reflects if any subsystems are bound and can
accept existing connections. state reflects the
physical state of the port.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvmetcli | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/nvmetcli b/nvmetcli
index 6b102a235450..86f7c01708cb 100755
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
+            active = not (not int(self.cfnode.get_attr("addr", "tractive")))
+            info.append("state=" + ("up" if active else "down"))
+            ret = True if active else False
+        return (", ".join(info), ret)
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.14.1
