From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Feb 2019 12:30:55 +0200
Subject: [PATCH 1/1] nvme-cli: enforce memory buffer for Host Identifier
Message-ID: <1551004255-13562-1-git-send-email-maxg@mellanox.com>

According to the NVMe spec, the NVMe Set Features command for Host
Identifier (fid=0x81) must use memory buffer for its attributes.
Enforce that and set the correct data length (16 for extended Host
Identifier, 8 for non-extended). The data for the Host Identifier
can be taken from a data file or from the stdin (same as before):
1. stdin example:
 - echo "host1234" | nvme set-feature /dev/nvme2n1 --feature-id=0x81 --value=0
2. data file example:
 - echo "host5555" > /tmp/hostid.data
 - nvme set-feature /dev/nvme2n1 --feature-id=0x81 --value=0 --data=/tmp/hostid.data

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 nvme.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/nvme.c b/nvme.c
index 8aac2ef..7897510 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3279,6 +3279,12 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 	}
 	if (cfg.feature_id == NVME_FEAT_LBA_RANGE)
 		cfg.data_len = 4096;
+	if (cfg.feature_id == NVME_FEAT_HOST_ID) {
+		cfg.data_len = 8;
+		/* check for Extended Host Identifier */
+		if (cfg.value & 0x1)
+			cfg.data_len = 16;
+	}
 	if (cfg.data_len) {
 		if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
 			fprintf(stderr, "can not allocate feature payload\n");
-- 
1.8.3.1
