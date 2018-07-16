From: hamdyk@mellanox.com (Hamdy Khader)
Date: Mon, 16 Jul 2018 15:13:40 +0300
Subject: [PATCH] Adds the ability to create a port, namespace and subsystem.
Message-ID: <1531743220-10200-1-git-send-email-hamdyk@mellanox.com>

---
 nvmetcli | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index 6b102a2..fba13c2 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -583,6 +583,10 @@ def usage():
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
     print("        %s ls" % sys.argv[0])
+    print("        %s create_port [subsystem_name] [port_id] [ip_version]" % sys.argv[0])
+    print("                       [transport_address] [transport_type] [transport_port]")
+    print("        %s create_subsystem [subsystem_name]" % sys.argv[0])
+    print("        %s create_ns [namespace_id] [subsystem_name] [device_path]" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -613,7 +617,41 @@ def ls(unused):
     sys.exit(0)
 
 
-funcs = dict(save=save, restore=restore, clear=clear, ls=ls)
+def create_subsystem(unused):
+    nqn = sys.argv[2]
+    subsystem_node = nvme.Subsystem(nqn=nqn, mode='create')
+    subsystem_node.set_attr("attr", "allow_any_host", "1")
+
+
+def create_port(unused):
+    nqn = sys.argv[2]
+    port_id = sys.argv[3]
+    ip_version = sys.argv[4]
+    transport_address = sys.argv[5]
+    transport_type = sys.argv[6]
+    transport_port = sys.argv[7]
+    port_node = nvme.Port(portid=port_id, mode='create')
+    port_node.set_attr('addr', 'adrfam', ip_version)
+    port_node.set_attr('addr', 'traddr', transport_address)
+    port_node.set_attr('addr', 'trtype', transport_type)
+    port_node.set_attr('addr', 'trsvcid', transport_port)
+    port_node.add_subsystem(nqn)
+
+
+def create_ns(unused):
+    ns_name = sys.argv[2]
+    ss_name = sys.argv[3]
+    device_path = sys.argv[4]
+    print("creating namespace:%s ,subsystem:%s ,device_path:%s" % (ns_name, ss_name, device_path))
+    subsystem_node = nvme.Subsystem(nqn=ss_name, mode='lookup')
+    namespace_node = nvme.Namespace(subsystem_node, mode='create')
+    namespace_node.set_attr('device', 'path', device_path)
+    namespace_node.set_enable(1)
+
+
+funcs = dict(save=save, restore=restore, clear=clear, ls=ls,
+             create_ns=create_ns, create_subsystem=create_subsystem,
+             create_port=create_port)
 
 
 def main():
@@ -621,10 +659,7 @@ def main():
         print("%s: must run as root." % sys.argv[0], file=sys.stderr)
         sys.exit(-1)
 
-    if len(sys.argv) > 3:
-        usage()
-
-    if len(sys.argv) == 2 or len(sys.argv) == 3:
+    if len(sys.argv) >= 2:
         if sys.argv[1] == "--help":
             usage()
 
-- 
1.9.1
