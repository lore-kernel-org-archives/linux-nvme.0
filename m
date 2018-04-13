From: lduncan@suse.com (Lee Duncan)
Date: Fri, 13 Apr 2018 11:56:29 -0700
Subject: [PATCH] Support python3 dictionary access.
Message-ID: <20180413185629.18592-1-lduncan@suse.com>

Support python2 and python3 dictionary
access by using the 'python-six' module's
iteritems() function.

Also, add info to the README about supporting
both Python2 and Python3.

Signed-off-by: Lee Duncan <lduncan at suse.com>
---
 README        | 8 +++++---
 nvmet/nvme.py | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/README b/README
index cd4bd7838637..920a4ad40d91 100644
--- a/README
+++ b/README
@@ -14,9 +14,11 @@ using setup.py.
 
 Common Package Dependencies and Problems
 -----------------------------------------
-nvmetcli uses the 'python-six' and 'pyparsing' packages
-(running nvmetcli without these packages may produce
-hard-to-decipher errors).
+Both python2 and python3 are supported via use of the
+'python-six' package. 
+
+nvmetcli uses the 'pyparsing' package -- running nvmetcli
+without this package may produce hard-to-decipher errors.
 
 Usage
 -----
diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index c245a4240dd9..8253ea9264b7 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -23,6 +23,7 @@ import stat
 import uuid
 import json
 from glob import iglob as glob
+from six import iteritems
 
 DEFAULT_SAVE_FILE = '/etc/nvmet/config.json'
 
@@ -219,7 +220,7 @@ class CFSNode(object):
 
     def _setup_attrs(self, attr_dict, err_func):
         for group in self.attr_groups:
-            for name, value in attr_dict.get(group, {}).iteritems():
+            for name, value in iteritems(attr_dict.get(group, {})):
                 try:
                     self.set_attr(group, name, value)
                 except CFSError as e:
-- 
2.13.6
