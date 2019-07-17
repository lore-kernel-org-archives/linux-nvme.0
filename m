From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 17 Jul 2019 11:12:51 -0600
Subject: [PATCH blktests v2 04/12] nvme/003,
 004: Add missing calls to nvme disconnect
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
Message-ID: <20190717171259.3311-5-logang@deltatee.com>

Tests 003 and 004 do not call  nvme disconnect. In most cases it is
cleaned up by removing the modules but it should be made explicit.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/003     | 1 +
 tests/nvme/003.out | 1 +
 tests/nvme/004     | 1 +
 tests/nvme/004.out | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/nvme/003 b/tests/nvme/003
index c6b3d4037aa6..374e6af0ca6f 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -42,6 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
+	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/003.out b/tests/nvme/003.out
index 01b275612159..beb356128c9d 100644
--- a/tests/nvme/003.out
+++ b/tests/nvme/003.out
@@ -1,2 +1,3 @@
 Running nvme/003
+NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/004 b/tests/nvme/004
index 0506fa220de3..767aedaa0263 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -40,6 +40,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
+	nvme disconnect -n "blktests-subsystem-1"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 53f911ecf329..51f605227320 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,4 +1,5 @@
 Running nvme/004
 91fdba0d-f87b-4c25-b80f-db7be1418b9e
 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
 Test complete
-- 
2.17.1
