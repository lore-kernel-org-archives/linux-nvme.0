From: hamdyk@mellanox.com (Hamdy Khader)
Date: Sun, 15 Jul 2018 17:11:35 +0300
Subject: [PATCH] Adds the appility to print json to stdout, create ports,
 namespaces and subsystems using cli.
Message-ID: <1531663895-5151-1-git-send-email-hamdyk@mellanox.com>

---
 nvmet/nvme.py |  3 +++
 nvmetcli      | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 8253ea9..3ca8429 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -388,6 +388,9 @@ class Root(CFSNode):
         d['hosts'] = [h.dump() for h in self.hosts]
         return d
 
+    def dump_json(self):
+        return json.dumps(self.dump(), sort_keys=True, indent=2)
+
 
 class Subsystem(CFSNode):
     '''
diff --git a/nvmetcli b/nvmetcli
index 6b102a2..b784162 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -583,6 +583,12 @@ def usage():
     print("        %s restore [file_to_restore_from]" % sys.argv[0])
     print("        %s clear" % sys.argv[0])
     print("        %s ls" % sys.argv[0])
+    print("        %s create_port [subsystem_name] [port_id] [ip_version]" % sys.argv[0])
+    print("                       [transport_address] [transport_type] [transport_port]")
+    print("        %s create_subsystem [subsystem_name]" % sys.argv[0])
+    print("        %s create_ns [namespace_id] [subsystem_name] [device_path]" % sys.argv[0])
+    print("        %s delete_ns [namespace_id] [subsystem_name]" % sys.argv[0])
+    print("        %s dump" % sys.argv[0])
     sys.exit(-1)
 
 
@@ -590,6 +596,10 @@ def save(to_file):
     nvme.Root().save_to_file(to_file)
 
 
+def dump(unused):
+    print(nvme.Root().dump_json())
+
+
 def restore(from_file):
     try:
         errors = nvme.Root().restore_from_file(from_file)
@@ -613,7 +623,51 @@ def ls(unused):
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
+def delete_ns(unused):
+    ns_name = sys.argv[2]
+    ss_name = sys.argv[3]
+    print("deleting namespace:%s ,subsystem:%s" % (ns_name, ss_name))
+    subsystem_node = nvme.Subsystem(nqn=ss_name, mode='lookup')
+    namespace_node = nvme.Namespace(subsystem_node, nsid=ns_name, mode='lookup')
+    namespace_node.set_enable(0)
+    namespace_node.delete()
+
+
+funcs = dict(save=save, restore=restore, clear=clear, ls=ls,
+             dump=dump, create_ns=create_ns, delete_ns=delete_ns,
+             create_subsystem=create_subsystem, create_port=create_port)
 
 
 def main():
@@ -621,10 +675,7 @@ def main():
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
