From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 30 Nov 2017 11:27:23 +0100
Subject: [PATCH nvmetcli] nvmetcli: remove status method for the UIPortNode
Message-ID: <20171130102723.6488-1-jthumshirn@suse.de>

nvmetcli defines a status method for the UIPortNode class but there is
no corresponding 'enable' file in configfs so typing in status will
always result in nvmetcli printing disbaled if one types 'status' in
the port node:

/> cd ports/1/
/ports/1> status
Status for /ports/1: disabled
/ports/1>

There are two possible ways for fixing this issue, provide a configfs
file to enable/disable the port node in the kernel or delete the
method in nvmetcli. Having a configfs file in the kernel is pointless,
as ports get enabled when symlinked to a namespace so zap the pointless status
method in user-space.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reported-by: Hannes Reinecke <hare at suse.de>
---
 nvmetcli | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index 5378365eb91f..4fbc12ec430f 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -356,11 +356,6 @@ class UIPortNode(UINode):
         UIPortSubsystemsNode(self)
         UIReferralsNode(self)
 
-    def status(self):
-        if self.cfnode.get_enable():
-            return "enabled"
-        return "disabled"
-
 
 class UIPortSubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.13.6
