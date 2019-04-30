From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 08:05:53 +0200
Subject: [nvme-cli 8/9] tests/nvme_get_features_test.py: skip features for Qemu
In-Reply-To: <20190430060554.24368-1-hare@suse.de>
References: <20190430060554.24368-1-hare@suse.de>
Message-ID: <20190430060554.24368-9-hare@suse.de>

Qemu doesn't implement all mandatory features, so we should
only be querying the implemented features when running under
qemu.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme_get_features_test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme_get_features_test.py b/tests/nvme_get_features_test.py
index 8888e4a..7236b60 100644
--- a/tests/nvme_get_features_test.py
+++ b/tests/nvme_get_features_test.py
@@ -54,6 +54,8 @@ class TestNVMeGetMandatoryFeatures(TestNVMe):
         self.setup_log_dir(self.__class__.__name__)
         self.feature_id_list = ["0x01", "0x02", "0x04", "0x05", "0x07",
                                 "0x08", "0x09", "0x0A", "0x0B"]
+        if self.is_qemu_controller():
+            self.feature_id_list = [ "0x06", "0x07" ]
         get_vector_list_cmd = "cat /proc/interrupts | grep nvme |" \
                               " cut -d : -f 1 | tr -d ' ' | tr '\n' ' '"
         proc = subprocess.Popen(get_vector_list_cmd,
-- 
2.13.7
