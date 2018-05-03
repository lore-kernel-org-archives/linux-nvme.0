From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  3 May 2018 17:00:53 +0200
Subject: [PATCH blktests 2/3] nvme: fix counting the target port
In-Reply-To: <20180503150054.14022-1-jthumshirn@suse.de>
References: <20180503150054.14022-1-jthumshirn@suse.de>
Message-ID: <20180503150054.14022-2-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 common/nvme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index c4a44065cd9f..3e20eeaa5744 100644
--- a/common/nvme
+++ b/common/nvme
@@ -27,11 +27,11 @@ _test_dev_is_nvme() {
 
 _create_nvmet_port() {
 	local trtype="$1"
-	local nvmet_cfs="/sys/kernel/config/nvmet/"
+	local nvmet_cfs="/sys/kernel/config/nvmet"
 
 	local port
 	for ((port = 0; ; port++)); do
-		if [[ ! -e "${nvmet_cfs}/${port}" ]]; then
+		if [[ ! -e "${nvmet_cfs}/ports/${port}" ]]; then
 			break
 		fi
 	done
-- 
2.16.3
