From: agrover@redhat.com (Andy Grover)
Date: Wed, 12 Oct 2016 17:00:40 -0700
Subject: [PATCH 1/3] Add nvmetcli to setup.py scripts
In-Reply-To: <1476316842-23718-1-git-send-email-agrover@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
Message-ID: <1476316842-23718-2-git-send-email-agrover@redhat.com>

This results in nvmetcli being placed in the right place on install, and
the interpreter name will be changed to the current interpreter name,
which may be different, e.g. /usr/bin/python3.

Signed-off-by: Andy Grover <agrover at redhat.com>
---
 setup.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.py b/setup.py
index 078020f..f62ce5b 100755
--- a/setup.py
+++ b/setup.py
@@ -27,4 +27,5 @@ setup(
     maintainer_email = 'hch at lst.de',
     test_suite='nose2.collector.collector',
     packages = ['nvmet'],
+    scripts = ['nvmetcli'],
     )
-- 
2.7.4
