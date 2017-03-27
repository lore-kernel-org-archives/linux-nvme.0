From: maurosr@linux.vnet.ibm.com (Mauro S. M. Rodrigues)
Date: Mon, 27 Mar 2017 14:46:43 -0300
Subject: [PATCH 1/3] nvmetcli: Fix Port and Host operations in shell
Message-ID: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>

Operations against Port and Host entities are broken. When performing
operations like the follow:

/ports> create 1
/hosts> create 1

nvmetcli fails, saying the object doesn't have the attribute we're
trying to access, for instance:
'module' object has no attribute 'Port'

This patch fixes this issue by importing the classes Port and Host in
nvmet/__init__.py which was forgotten during the follow change:

a21ebd54f0 ("nvmetcli: Fix nvmet import").

Tested-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr at linux.vnet.ibm.com>
---
 nvmet/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index a084151..9a0b51d 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1 +1 @@
-from .nvme import Root, Subsystem, Namespace
+from .nvme import Root, Subsystem, Namespace, Port, Host
-- 
2.7.4
