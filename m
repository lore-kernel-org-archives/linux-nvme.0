From: maurosr@linux.vnet.ibm.com (Mauro S. M. Rodrigues)
Date: Mon, 27 Mar 2017 14:46:45 -0300
Subject: [PATCH 3/3] nvmetcli: Install nvmetcli executable in $PATH
In-Reply-To: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
Message-ID: <1490636805-13688-3-git-send-email-maurosr@linux.vnet.ibm.com>

According to the README, one can install nvmetcli through setup.py.
When we try this, though, the nvmetcli wasn't configured in system's
$PATH.
Adding it to script list in setup.py solved the issue.

Tested-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr at linux.vnet.ibm.com>
---
 setup.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.py b/setup.py
index fdd6cea..4bd2ac2 100755
--- a/setup.py
+++ b/setup.py
@@ -27,4 +27,5 @@ setup(
     maintainer_email = 'hch at lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
+    scripts=['./nvmetcli'],
     )
-- 
2.7.4
