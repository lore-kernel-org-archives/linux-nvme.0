From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 15:38:36 +0200
Subject: [PATCH nvmetcli] nvmetcli: Also configure subsystem version
Message-ID: <20170714133836.19369-1-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 nvmetcli | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvmetcli b/nvmetcli
index 354ce4826f11..a8d648a2179c 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -149,6 +149,7 @@ class UISubsystemNode(UINode):
     ui_desc_attr = {
         'allow_any_host': ('string', 'Allow access by any host if set to 1'),
         'serial': ('string', 'Export serial number to hosts'),
+	'version': ('string', 'Export version number to hosts'),
     }
 
     def __init__(self, parent, cfnode):
-- 
2.12.3
