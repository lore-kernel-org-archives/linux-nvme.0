From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 16 Jun 2017 10:05:44 +0200
Subject: [PATCH nvmetcli] nvmetcli: add support for NS UUIDs
Message-ID: <20170616080544.8780-1-jthumshirn@suse.de>

Add support for setting the Namespace Universally Unique Identifier in
a NVMe over Fabrics namespace.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 nvmetcli | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvmetcli b/nvmetcli
index 0ada243a6a7f..56dda66c39a7 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -198,6 +198,7 @@ class UINamespaceNode(UINode):
     ui_desc_device = {
         'path': ('string', 'Backing device path.'),
         'nguid': ('string', 'Namspace Global Unique Identifier.'),
+        'uuid': ('string', 'Namespace Universally Unique Identifier.'),
     }
 
     def __init__(self, parent, cfnode):
-- 
2.12.3
