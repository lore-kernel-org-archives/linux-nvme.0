From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 12 Apr 2017 16:09:14 -0700
Subject: [PATCH] Add fc transport support to nvmetcli
Message-ID: <20170412230914.23788-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Add fc.json file for example FC configuration.
Small text update for FC in examples/documentation

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 Documentation/nvmetcli.txt | 13 +++++++++++++
 README                     |  6 ++++++
 debian/nvmetcli.examples   |  1 +
 examples/fc.json           | 42 ++++++++++++++++++++++++++++++++++++++++++
 fc.json                    | 42 ++++++++++++++++++++++++++++++++++++++++++
 nvmetcli                   | 12 ++++++------
 6 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 examples/fc.json
 create mode 100644 fc.json

diff --git a/Documentation/nvmetcli.txt b/Documentation/nvmetcli.txt
index 4c99512..1f381cc 100644
--- a/Documentation/nvmetcli.txt
+++ b/Documentation/nvmetcli.txt
@@ -198,6 +198,19 @@ IANA assigned default port for NVMe over Fabrics using RDMA:
 ...> create testnqn
 --------------
 
+* or create an FC port. traddr is the WWNN/WWPN of the FC port.
+--------------
+...> cd /ports/
+...> create 3
+...> cd 3/
+...> set addr trtype=fc
+...> set addr adrfam=fc
+...> set addr traddr=nn-0x1000000044001123:pn-0x2000000055001123
+...> set addr trsvcid=none
+...> cd subsystems/
+...> create testnqn
+--------------
+
 * Saving the NVMe Target configuration:
 --------------
 ./nvmetcli
diff --git a/README b/README
index a3d529a..cd4bd78 100644
--- a/README
+++ b/README
@@ -33,6 +33,12 @@ after you've ensured that the IP address in rdma.json fits your setup:
 
   ./nvmetcli restore rdma.json
 
+Or to load the fc + no host authentication version do the following
+after you've ensured that the port traddr FC address information in
+fc.json fits your setup:
+
+  ./nvmetcli restore fc.json
+
 These files can also be edited directly using your favorite editor.
 
 Testing
diff --git a/debian/nvmetcli.examples b/debian/nvmetcli.examples
index 966124f..53ead2f 100644
--- a/debian/nvmetcli.examples
+++ b/debian/nvmetcli.examples
@@ -1,2 +1,3 @@
 loop.json
 rdma.json
+fc.json
diff --git a/examples/fc.json b/examples/fc.json
new file mode 100644
index 0000000..e120aef
--- /dev/null
+++ b/examples/fc.json
@@ -0,0 +1,42 @@
+{
+  "hosts": [
+    {
+      "nqn": "hostnqn"
+    }
+  ], 
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "fc", 
+        "traddr": "nn-0x1000000044001123:pn-0x2000000055001123", 
+        "treq": "not specified", 
+        "trsvcid": "none", 
+        "trtype": "fc"
+      }, 
+      "portid": 3, 
+      "referrals": [], 
+      "subsystems": [
+        "testnqn"
+      ]
+    }
+  ], 
+  "subsystems": [
+    {
+      "allowed_hosts": [], 
+      "attr": {
+        "allow_any_host": "1"
+      }, 
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a8", 
+            "path": "/dev/nvme0n1"
+          }, 
+          "enable": 1, 
+          "nsid": 1
+        }
+      ], 
+      "nqn": "testnqn"
+    }
+  ]
+}
diff --git a/fc.json b/fc.json
new file mode 100644
index 0000000..e120aef
--- /dev/null
+++ b/fc.json
@@ -0,0 +1,42 @@
+{
+  "hosts": [
+    {
+      "nqn": "hostnqn"
+    }
+  ], 
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "fc", 
+        "traddr": "nn-0x1000000044001123:pn-0x2000000055001123", 
+        "treq": "not specified", 
+        "trsvcid": "none", 
+        "trtype": "fc"
+      }, 
+      "portid": 3, 
+      "referrals": [], 
+      "subsystems": [
+        "testnqn"
+      ]
+    }
+  ], 
+  "subsystems": [
+    {
+      "allowed_hosts": [], 
+      "attr": {
+        "allow_any_host": "1"
+      }, 
+      "namespaces": [
+        {
+          "device": {
+            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a8", 
+            "path": "/dev/nvme0n1"
+          }, 
+          "enable": 1, 
+          "nsid": 1
+        }
+      ], 
+      "nqn": "testnqn"
+    }
+  ]
+}
diff --git a/nvmetcli b/nvmetcli
index 9f7eacf..0ada243 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -341,11 +341,11 @@ class UIPortsNode(UINode):
 
 class UIPortNode(UINode):
     ui_desc_addr = {
-        'adrfam': ('string', 'Address Family (e.g. ipv4)'),
+        'adrfam': ('string', 'Address Family (e.g. ipv4 or fc)'),
         'treq': ('string', 'Transport Security Requirements'),
-        'traddr': ('string', 'Transport Address (e.g. IP Address)'),
+        'traddr': ('string', 'Transport Address (e.g. IP Address or FC wwnn:wwpn)'),
         'trsvcid': ('string', 'Transport Service ID (e.g. IP Port)'),
-        'trtype': ('string', 'Transport Type (e.g. rdma or loop)'),
+        'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
     }
 
     def __init__(self, parent, cfnode):
@@ -455,11 +455,11 @@ class UIReferralsNode(UINode):
 
 class UIReferralNode(UINode):
     ui_desc_addr = {
-        'adrfam': ('string', 'Address Family (e.g. ipv4)'),
+        'adrfam': ('string', 'Address Family (e.g. ipv4 or fc)'),
         'treq': ('string', 'Transport Security Requirements'),
-        'traddr': ('string', 'Transport Address (e.g. IP Address)'),
+        'traddr': ('string', 'Transport Address (e.g. IP Address or FC wwnn:wwpn)'),
         'trsvcid': ('string', 'Transport Service ID (e.g. IP Port)'),
-        'trtype': ('string', 'Transport Type (e.g. rdma or loop)'),
+        'trtype': ('string', 'Transport Type (e.g. rdma or loop or fc)'),
         'portid': ('number', 'Port identifier'),
     }
 
-- 
2.9.3
