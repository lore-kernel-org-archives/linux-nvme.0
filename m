From: agrover@redhat.com (Andy Grover)
Date: Wed, 12 Oct 2016 17:00:41 -0700
Subject: [PATCH 2/3] Use relative import in nvmet/__init__.py
In-Reply-To: <1476316842-23718-1-git-send-email-agrover@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
Message-ID: <1476316842-23718-3-git-send-email-agrover@redhat.com>

This is supported by Python 2.7 and later.

Signed-off-by: Andy Grover <agrover at redhat.com>
---
 nvmet/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmet/__init__.py b/nvmet/__init__.py
index eba0ebb..a084151 100644
--- a/nvmet/__init__.py
+++ b/nvmet/__init__.py
@@ -1 +1 @@
-from nvme import Root, Subsystem, Namespace
+from .nvme import Root, Subsystem, Namespace
-- 
2.7.4
