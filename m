From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 17 Jul 2019 11:12:48 -0600
Subject: [PATCH blktests v2 01/12] Add filter function for nvme discover
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
Message-ID: <20190717171259.3311-2-logang@deltatee.com>

From: Michael Moese <mmoese@suse.de>

Several NVMe tests (002, 016, 017) used a pipe to a sed call filtering
the output. This call is moved to a new filter function nvme/rc and
the calls to sed are replaced by this function.

Additionally, the test nvme/016 failed for me due to the Generation
counter being greater than 1, so the new filter function was expanded to
replace the Generation counter with 'X'.

Signed-off-by: Michael Moese <mmoese at suse.de>
[logang at deltatee.com: added missing changes to 002.out and 017.out]
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/002     | 2 +-
 tests/nvme/002.out | 2 +-
 tests/nvme/016     | 2 +-
 tests/nvme/016.out | 2 +-
 tests/nvme/017     | 2 +-
 tests/nvme/017.out | 2 +-
 tests/nvme/rc      | 5 +++++
 7 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 106a5a8395f2..ceac1c677bd4 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -32,7 +32,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/002.out b/tests/nvme/002.out
index aa71d8f5f5f8..7437a21f60a9 100644
--- a/tests/nvme/002.out
+++ b/tests/nvme/002.out
@@ -1,6 +1,6 @@
 Running nvme/002
 
-Discovery Log Number of Records 1000, Generation counter 1000
+Discovery Log Number of Records 1000, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/016 b/tests/nvme/016
index 966d5dc0a4a2..dd1b84a16daa 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index 59bd2935346f..b70603144d5c 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,6 +1,6 @@
 Running nvme/016
 
-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0b86bece9520..5f8d60907293 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -37,7 +37,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 4b0877aaf3ca..cf212971d180 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,6 +1,6 @@
 Running nvme/017
 
-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd992460..22833d8ef9bb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -118,3 +118,8 @@ _find_nvme_loop_dev() {
 		fi
 	done
 }
+
+_filter_discovery() {
+	sed -r  -e "s/portid:  [0-9]+/portid:  X/" \
+		-e "s/Generation counter [0-9]+/Generation counter X/"
+}
-- 
2.17.1
