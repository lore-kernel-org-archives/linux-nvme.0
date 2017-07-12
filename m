From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 12 Jul 2017 10:58:19 -0600
Subject: [RFC] nvme: Fabrics should use the fctype field for data direction
Message-ID: <20170712165819.5326-1-jonathan.derrick@intel.com>

Fabrics commands with opcode 0x7F use the fctype field to indicate data
direction.

Fixes: eb793e2c ("nvme.h: add NVMe over Fabrics definitions")

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
I don't have a setup available to test this, but according to the fabrics spec,
we should be using fctype. Any write commands would appear to work, including
Connect, but Property Get and other read commands with opcode 0x7F looks like
they should fail.

 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 983975b..7246059 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1017,7 +1017,7 @@ static inline bool nvme_is_write(struct nvme_command *cmd)
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
 	 */
 	if (unlikely(cmd->common.opcode == nvme_fabrics_command))
-		return cmd->fabrics.opcode & 1;
+		return cmd->fabrics.fctype & 1;
 	return cmd->common.opcode & 1;
 }
 
-- 
2.9.3
