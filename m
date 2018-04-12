From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:07 -0600
Subject: [PATCH 05/13] nvme: target: fix buffer overflow
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-6-keith.busch@intel.com>

From: Arnd Bergmann <arnd@arndb.de>

nvmet_execute_get_disc_log_page() passes a fixed-length string into
nvmet_format_discovery_entry(), which then does a longer memcpy() on
it, as pointed out by gcc-8:

In function 'nvmet_format_discovery_entry',
    inlined from 'nvmet_execute_get_disc_log_page' at drivers/nvme/target/discovery.c:126:4:
drivers/nvme/target/discovery.c:62:2: error: 'memcpy' forming offset [38, 223] is out of the bounds [0, 37] [-Werror=array-bounds]
  memcpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);

Using strncpy() will make this well-defined, filling the rest of the
buffer with zeroes, under the assumption that the input is either
a NUL-terminated string, or a byte sequence containing no zeroes.
If the input is a string that is longer than NVMF_NQN_SIZE, we
continue to have no NUL-termination in the output.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Arnd Bergmann <arnd at arndb.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index a72425d8bce0..231e04e0a496 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -59,7 +59,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, traddr, NVMF_TRADDR_SIZE);
 	memcpy(e->tsas.common, port->disc_addr.tsas.common, NVMF_TSAS_SIZE);
-	memcpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
+	strncpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
 }
 
 /*
-- 
2.14.3
