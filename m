From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Fri, 23 Jun 2017 16:18:25 +0000
Subject: [RESEND PATCH] nvme-cli: Get Feature support for Extended Host Id
Message-ID: <BN6PR06MB24818697459A7616E5B822CE8CD80@BN6PR06MB2481.namprd06.prod.outlook.com>

Enable Extended Host Identifier flag is specified in cdw11.
Also added the feature string for kato.
---
Rebased to latest upstream.

 Documentation/nvme-get-feature.txt | 3 +--
 nvme-print.c                       | 1 +
 nvme.c                             | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/nvme-get-feature.txt b/Documentation/nvme-get-feature.txt
index 4be581f..cdf6eef 100644
--- a/Documentation/nvme-get-feature.txt
+++ b/Documentation/nvme-get-feature.txt
@@ -63,8 +63,7 @@ OPTIONS
 	Range Type
 
 --cdw11=<cdw11>::
-	The value for command dword 11, if applicable. Only known feature
-	using this is the interrupt vector configuration feature.
+	The value for command dword 11, if applicable.
 
 -b::
 --raw-binary::
diff --git a/nvme-print.c b/nvme-print.c
index 2da5acd..c08f312 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -919,6 +919,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_ASYNC_EVENT:	return "Async Event Configuration";
 	case NVME_FEAT_AUTO_PST:	return "Autonomous Power State Transition";
 	case NVME_FEAT_HOST_MEM_BUF:	return "Host Memory Buffer";
+	case NVME_FEAT_KATO:		return "Keep Alive Timer";
 	case NVME_FEAT_SW_PROGRESS:	return "Software Progress";
 	case NVME_FEAT_HOST_ID:		return "Host Identifier";
 	case NVME_FEAT_RESV_MASK:	return "Reservation Notification Mask";
diff --git a/nvme.c b/nvme.c
index a4e1b71..515d135 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1118,6 +1118,9 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 		break;
 	case NVME_FEAT_HOST_ID:
 		cfg.data_len = 8;
+		/* check for Extended Host Identifier */
+		if (cfg.cdw11 & 0x1)
+			cfg.data_len = 16;
 		break;
 	}
 
-- 
2.12.2
