From: yizhan@redhat.com (Yi Zhang)
Date: Wed, 12 Apr 2017 19:34:28 +0800
Subject: [PATCH] nvmetcli: create json file's dir first if it doesn't exist
Message-ID: <20170412113428.32541-1-yizhan@redhat.com>

The saveconfig operation will be failed as the /etc/nvmet dir
doesn't exist by default, so create it first before save operation.

$ ./nvmetcli
/> saveconfig
[Errno 2] No such file or directory: '/etc/nvmet/config.json.temp'

Signed-off-by: Yi Zhang <yizhan at redhat.com>
---
 nvmet/nvme.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 3316cab..c245a42 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -290,6 +290,11 @@ class Root(CFSNode):
         else:
             savefile = DEFAULT_SAVE_FILE
 
+        savefile_abspath = os.path.abspath(savefile)
+        savefile_dir = os.path.dirname(savefile_abspath)
+        if not os.path.exists(savefile_dir):
+            os.makedirs(savefile_dir)
+
         with open(savefile + ".temp", "w+") as f:
             os.fchmod(f.fileno(), stat.S_IRUSR | stat.S_IWUSR)
             f.write(json.dumps(self.dump(), sort_keys=True, indent=2))
-- 
2.9.3
