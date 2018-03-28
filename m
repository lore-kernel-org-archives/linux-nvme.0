From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 15:55:13 +0200
Subject: [PATCH] nvme: target: fix buffer overflow
Message-ID: <20180328135522.2345359-1-arnd@arndb.de>

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
---
I'm not sure why this only showed up in linux-next now, the bug seems
to have been in that file for a while.
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index d5e19493e3fa..84e731e57f07 100644
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
2.9.0
