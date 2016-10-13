From: agrover@redhat.com (Andy Grover)
Date: Wed, 12 Oct 2016 17:00:42 -0700
Subject: [PATCH 3/3] nvmetcli: Fix nvmet import
In-Reply-To: <1476316842-23718-1-git-send-email-agrover@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
Message-ID: <1476316842-23718-4-git-send-email-agrover@redhat.com>

We should just need to import nvmet, which will run __init__.py and import
just the public things from nvmet/nvme.py.

Signed-off-by: Andy Grover <agrover at redhat.com>
---
 nvmetcli | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmetcli b/nvmetcli
index a318aa6..8140fc6 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -23,7 +23,7 @@ from __future__ import print_function
 import os
 import sys
 import configshell_fb as configshell
-import nvmet.nvme as nvme
+import nvmet as nvme
 
 
 class UINode(configshell.node.ConfigNode):
-- 
2.7.4
