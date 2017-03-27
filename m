From: maurosr@linux.vnet.ibm.com (Mauro S. M. Rodrigues)
Date: Mon, 27 Mar 2017 14:46:44 -0300
Subject: [PATCH 2/3] nvmetcli: Fix Referral operation in shell
In-Reply-To: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
Message-ID: <1490636805-13688-2-git-send-email-maurosr@linux.vnet.ibm.com>

It's not possible to create or list a Referral under Port entity,
because Referral class is not imported and thus it fails:

/ports/1/referrals> ls

returning "'module' object has no attribute 'Referral'".

This is caused by changes introduced in:
a21ebd54f0 ("nvmetcli: Fix nvmet import").

This patch also fixes the attribute type helper expected for Referral's
portid attribute. It was 'int', causing the system to show error
messages like:

"'UIReferralNode' object has no attribute 'ui_type_int'".
The correct type is 'number'.

Reviewed-by: Guilherme G. Piccoli<gpiccoli at linux.vnet.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr at linux.vnet.ibm.com>
---
 nvmet/__init__.py | 2 +-
 nvmetcli          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index 9a0b51d..6542d87 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1 +1 @@
-from .nvme import Root, Subsystem, Namespace, Port, Host
+from .nvme import Root, Subsystem, Namespace, Port, Host, Referral
diff --git a/nvmetcli b/nvmetcli
index 8140fc6..9f7eacf 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -460,7 +460,7 @@ class UIReferralNode(UINode):
         'traddr': ('string', 'Transport Address (e.g. IP Address)'),
         'trsvcid': ('string', 'Transport Service ID (e.g. IP Port)'),
         'trtype': ('string', 'Transport Type (e.g. rdma or loop)'),
-        'portid': ('int', 'Port identifier'),
+        'portid': ('number', 'Port identifier'),
     }
 
     def __init__(self, parent, cfnode):
-- 
2.7.4
