From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 24 Apr 2018 10:12:49 -0600
Subject: [PATCH blktests 1/3] nvme: fix counting available ports
Message-ID: <20180424161251.6502-1-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 common/nvme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index 400f66690f52..506612f27297 100644
--- a/common/nvme
+++ b/common/nvme
@@ -29,7 +29,7 @@ _create_nvmet_port() {
 	local trtype="$1"
 	local nvmet_cfs="/sys/kernel/config/nvmet/"
 
-	local port=$(($(ls "${nvmet_cfs}" | wc -l) + 1))
+	local port=$(($(ls "${nvmet_cfs}/ports" | wc -l) + 1))
 
 	mkdir "${nvmet_cfs}/ports/${port}"
 	echo "${trtype}" > "${nvmet_cfs}/ports/${port}/addr_trtype"
-- 
2.16.3
