From: sschricker@suse.de (Simon Schricker)
Date: Tue, 16 Apr 2019 15:27:40 +0200
Subject: [PATCH] nvme-cli: Increase size of ONTAP namespace path variable
Message-ID: <20190416132740.18045-1-sschricker@suse.de>

nspath's size is ONTAP_NS_PATHLEN and is written to by:

snprintf(nspath, ONTAP_NS_PATHLEN, "%s%s%s%s", ontap_vol,
                        vol_name, "/", ns_name);

Required bytes:

- ontap_vol is a constant char pointer, set to "/vol/", so 5 bytes
- vol_name's size is ONTAP_LABEL_LEN, which is 260, deducting the
  null-byte for termination makes 259 required bytes
- "/" is 1 byte
- ns_name's size is also ONTAP_LABEL_LEN, which is 260, deducting
  the null-byte for termination makes 259 required bytes
- the final null-byte: 1

That makes in total 5 + 259 + 1 + 259 + 1 = 525 required bytes

Signed-off-by: Simon Schricker <sschricker at suse.de>
---
 plugins/netapp/netapp-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/netapp/netapp-nvme.c b/plugins/netapp/netapp-nvme.c
index 2951311..aa5a94d 100644
--- a/plugins/netapp/netapp-nvme.c
+++ b/plugins/netapp/netapp-nvme.c
@@ -35,7 +35,7 @@
 #define ONTAP_C2_LOG_ID		0xC2
 #define ONTAP_C2_LOG_SIZE	4096
 #define ONTAP_LABEL_LEN		260
-#define ONTAP_NS_PATHLEN	520
+#define ONTAP_NS_PATHLEN	525
 
 enum {
 	NNORMAL,
-- 
2.16.4
