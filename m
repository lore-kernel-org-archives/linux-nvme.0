From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 9 Jul 2018 10:00:26 -0700
Subject: [PATCH v2] Support inline_data_size port parameter
Message-ID: <20180709170251.71AD32B8E5@smtp.opengridcomputing.com>

The port parameter attribute param_inline_data_size allows adjusting
the amount of inline data that can be included in a write IO. Setting
it to < 0 (or not setting it at all) allows the transport to choose a
reasonable default, which will be 0 if that transport does not support
inline.  Setting it to 0 disables the transport from using inline_data.
And setting it to > 0 configures that port/transport to use that inline
data size, in bytes, if the transport supports it.

Signed_off_by: Steve Wise <swise at opengridcomputing.com>

---

Changes since v1:
	- remove inline_data_size from the UIReferralNode class
	- support older kernels w/o the new parameter
---
 nvmet/nvme.py |  4 ++--
 nvmetcli      | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 8253ea9264b7..1aac7bc3fea3 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -609,7 +609,7 @@ class Port(CFSNode):
     def __init__(self, portid, mode='any'):
         super(Port, self).__init__()
 
-        self.attr_groups = ['addr']
+        self.attr_groups = ['addr', 'param']
         self._portid = int(portid)
         self._path = "%s/ports/%d" % (self.configfs_dir, self._portid)
         self._create_in_cfs(mode)
@@ -710,7 +710,7 @@ class Referral(CFSNode):
         if not isinstance(port, Port):
             raise CFSError("Invalid parent class")
 
-        self.attr_groups = ['addr']
+        self.attr_groups = ['addr', 'param']
         self.port = port
         self._name = name
         self._path = "%s/referrals/%s" % (self.port.path, self._name)
diff --git a/nvmetcli b/nvmetcli
index 6b102a235450..131d7845262c 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -374,6 +374,9 @@ class UIPortNode(UINode):
         'trsvcid': ('string', 'Transport Service ID (e.g. IP Port)'),
         'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
     }
+    ui_desc_param = {
+        'inline_data_size': ('string', 'Port inline data size in bytes'),
+    }
 
     def __init__(self, parent, cfnode):
         UINode.__init__(self, str(cfnode.portid), parent, cfnode)
@@ -387,6 +390,16 @@ class UIPortNode(UINode):
         trsvcid = self.cfnode.get_attr("addr", "trsvcid")
         if trsvcid != "none":
             info.append("trsvcid=%s" % trsvcid)
+
+	'''
+	Support older target driver w/o the inline_data_size parameter
+	'''
+	try:
+		inline_data_size = self.cfnode.get_attr("param", "inline_data_size")
+	except:
+		inline_data_size = "n/a"
+	if inline_data_size != "n/a":
+		info.append("inline_data_size=" + inline_data_size);
         enabled = not (not self.cfnode.subsystems and not list(self.cfnode.referrals))
         return (", ".join(info), True if enabled else 0)
 
-- 
1.8.3.1
