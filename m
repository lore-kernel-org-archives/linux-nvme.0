From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 15:57:47 +0200
Subject: [PATCH] nvme: use upper_32_bits() instead of bit shift
Message-ID: <20180328135817.2419127-1-arnd@arndb.de>

On 32-bit architectures, we cannot shift a size_t by 32 bits to the right
without a compiler warning:

drivers/nvme/host/core.c: In function 'nvme_get_log_ext':
drivers/nvme/host/core.c:2237:43: error: right shift count >= width of type [-Werror=shift-count-overflow]
  c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
                                           ^~
include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__cpu_to_le32'
 #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                   ^
drivers/nvme/host/core.c:2237:24: note: in expansion of macro 'cpu_to_le32'
  c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);

The code is correct, but using the upper_32_bits() and lower_32_bits()
macros that were introduced for this operation makes it easier to read
and avoids the warning.

Fixes: 70da6094a646 ("nvme: implement log page low/high offset and dwords")
Signed-off-by: Arnd Bergmann <arnd at arndb.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e4136bfc37f..0a81704b763f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2233,8 +2233,8 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.get_log_page.lid = log_page;
 	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
-	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
-	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
+	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
+	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
-- 
2.9.0
