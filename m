From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:16 -0700
Subject: [PATCH 2/6] nvme-cli: code cleanup adjust if statement
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-3-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 242a01f..f3a56dc 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -563,7 +563,7 @@ static int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 at
 
 	if (fctype == nvme_fabrics_type_property_get){
 		cmd.nsid = nvme_fabrics_type_property_get;
-	} else if(fctype == nvme_fabrics_type_property_set) {
+	} else if (fctype == nvme_fabrics_type_property_set) {
 		cmd.nsid = nvme_fabrics_type_property_set;
 		cmd.cdw12 = *value;
 	} else {
-- 
2.17.0
