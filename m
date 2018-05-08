From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  8 May 2018 01:45:32 -0400
Subject: [PATCH] blktests: use global configfs variable
Message-ID: <20180508054532.13712-1-chaitanya.kulkarni@wdc.com>

This patch introduces a global variable to hold the
configfs nvmet path. Now we don't need repetitive
local variables to hold the path and testcases
can use the newly introduced variable if needed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 common/nvme | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/common/nvme b/common/nvme
index c6718f0..797e6db 100644
--- a/common/nvme
+++ b/common/nvme
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+NVMET_CFS="/sys/kernel/config/nvmet/"
+
 _test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
 		SKIP_REASON="$TEST_DEV is not a NVMe device"
@@ -27,33 +29,29 @@ _test_dev_is_nvme() {
 
 _create_nvmet_port() {
 	local trtype="$1"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
-
 	local port
 	for ((port = 0; ; port++)); do
-		if [[ ! -e "${nvmet_cfs}/${port}" ]]; then
+		if [[ ! -e "${NVMET_CFS}/${port}" ]]; then
 			break
 		fi
 	done
 
-	mkdir "${nvmet_cfs}/ports/${port}"
-	echo "${trtype}" > "${nvmet_cfs}/ports/${port}/addr_trtype"
+	mkdir "${NVMET_CFS}/ports/${port}"
+	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
 
 	echo "${port}"
 }
 
 _remove_nvmet_port() {
 	local port="$1"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
-	rmdir "${nvmet_cfs}/ports/${port}"
+	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
 _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid="00000000-0000-0000-0000-000000000000"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
-	local cfs_path="${nvmet_cfs}/subsystems/${nvmet_subsystem}"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	if [[ $# -eq 3 ]]; then
 		uuid="$3"
@@ -69,8 +67,7 @@ _create_nvmet_subsystem() {
 
 _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
-	local cfs_path="${nvmet_cfs}/subsystems/${nvmet_subsystem}"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	echo 0 > "${cfs_path}/namespaces/1/enable"
 	rmdir "${cfs_path}/namespaces/1/"
@@ -80,16 +77,14 @@ _remove_nvmet_subsystem() {
 _add_nvmet_subsys_to_port() {
 	local port="$1"
 	local nvmet_subsystem="$2"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
 
-	ln -s "${nvmet_cfs}/subsystems/${nvmet_subsystem}" \
-		"${nvmet_cfs}/ports/${port}/subsystems/${nvmet_subsystem}"
+	ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
+		"${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
 _remove_nvmet_subsystem_from_port() {
 	local port="$1"
 	local nvmet_subsystem="$2"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
 
-	rm "${nvmet_cfs}/ports/${port}/subsystems/${nvmet_subsystem}"
+	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
-- 
2.9.5
