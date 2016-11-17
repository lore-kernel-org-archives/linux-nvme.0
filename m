From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Thu, 17 Nov 2016 00:48:17 -0800
Subject: [PATCH] nvmecli-tests : update the list of dependencies
Message-ID: <CAK0tqinhd3jeasr5+3dtPFB149wREcBwwAw0UrpfNuqpE3Uheg@mail.gmail.com>

README file is updated with complete list of dependencies
required to setup the environment for unitttests.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 tests/README | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/README b/tests/README
index 70686d8..686bd04 100644
--- a/tests/README
+++ b/tests/README
@@ -12,8 +12,17 @@ nvmetests
 ------------------------------

     1. Python(>= 2.7.5 or >= 3.3)
-    2. nose2(Installation guide http://nose2.readthedocs.io/)
-    3. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
+    2. nose(http://nose.readthedocs.io/en/latest/)
+    3. nose2(Installation guide http://nose2.readthedocs.io/)
+    4. pep8(https://pypi.python.org/pypi/setuptools-pep8)
+    5. flake8(https://pypi.python.org/pypi/flake8)
+    6. pylint(https://www.pylint.org/)
+    7. Epydoc(http://epydoc.sourceforge.net/)
+    8. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
+
+    Python package management system pip can be used to install most of the
+    listed packages(https://pip.pypa.io/en/stable/installing/) :-
+    $ pip install nose nose2 pep8 flake8 pylint epydoc

 2. Overview
 -----------
-- 
1.9.1
