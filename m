From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 13 Jul 2017 12:48:45 +0200
Subject: [PATCH nvmetcli] nvmetcli: allow setting of serial number number
Message-ID: <20170713104845.12470-1-jthumshirn@suse.de>

Allow a user to set a serial number of a controller in configfs in order to
have persistent serials that survive a reboot of the target.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 nvmetcli | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvmetcli b/nvmetcli
index 56dda66c39a7..354ce4826f11 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -148,6 +148,7 @@ class UISubsystemsNode(UINode):
 class UISubsystemNode(UINode):
     ui_desc_attr = {
         'allow_any_host': ('string', 'Allow access by any host if set to 1'),
+        'serial': ('string', 'Export serial number to hosts'),
     }
 
     def __init__(self, parent, cfnode):
-- 
2.12.3
