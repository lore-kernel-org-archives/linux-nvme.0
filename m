From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Wed, 14 Jun 2017 21:36:35 +0000
Subject: [PATCH] nvme-cli: Get Feature support for Extended Host Id
Message-ID: <BN6PR06MB24813455997AF369D3C5965F8CC30@BN6PR06MB2481.namprd06.prod.outlook.com>


Enable Extended Host Identifier flag is specified in cdw11.
Also added the feature string for kato.

Signed-off-by: Steve Schremmer <steve.schremmer at netapp.com>
---
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
index 184dd73..4cc0f90 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -831,6 +831,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_ASYNC_EVENT:	return "Async Event Configuration";
 	case NVME_FEAT_AUTO_PST:	return "Autonomous Power State Transition";
 	case NVME_FEAT_HOST_MEM_BUF:	return "Host Memory Buffer";
+	case NVME_FEAT_KATO:		return "Keep Alive Timer";
 	case NVME_FEAT_SW_PROGRESS:	return "Software Progress";
 	case NVME_FEAT_HOST_ID:		return "Host Identifier";
 	case NVME_FEAT_RESV_MASK:	return "Reservation Notification Mask";
diff --git a/nvme.c b/nvme.c
index 98f96be..5daf121 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1116,6 +1116,9 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
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
