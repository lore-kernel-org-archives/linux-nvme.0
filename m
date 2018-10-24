From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Oct 2018 11:47:01 -0700
Subject: [PATCH]  nvme-cli: fix ana-log endianness
Message-ID: <20181024184701.12158-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 4b2d1d2..c961cc5 100644
--- a/nvme.c
+++ b/nvme.c
@@ -273,7 +273,7 @@ static int get_ana_log(int argc, char **argv, struct command *cmd,
 	ana_log_len = sizeof(struct nvme_ana_rsp_hdr) +
 		le32_to_cpu(ctrl.nanagrpid) * sizeof(struct nvme_ana_group_desc);
 	if (!(ctrl.anacap & (1 << 6)))
-		ana_log_len += ctrl.mnan * sizeof(__le32);
+		ana_log_len += le32_to_cpu(ctrl.mnan) * sizeof(__le32);
 
 	ana_log = malloc(ana_log_len);
 	if (!ana_log) {
-- 
2.17.0
