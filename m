From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Thu,  1 Mar 2018 09:50:44 -0700
Subject: [PATCH] nvme-cli: fix typo in 'disconnect' docs
Message-ID: <20180301165044.26272-1-daniel.verkamp@intel.com>

Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 Documentation/nvme-disconnect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme-disconnect.txt b/Documentation/nvme-disconnect.txt
index 703d901..4d5b362 100644
--- a/Documentation/nvme-disconnect.txt
+++ b/Documentation/nvme-disconnect.txt
@@ -8,7 +8,7 @@ nvme-disconnect - Disonnect one or more Fabrics controller(s).
 SYNOPSIS
 --------
 [verse]
-'nvme connect'
+'nvme disconnect'
 		[--nqn=<subnqn>           | -n <subnqn>]
 		[--device=<device>        | -d <device>]
 
-- 
2.14.3
