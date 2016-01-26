From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 26 Jan 2016 12:27:34 +0300
Subject: [patch] nvme: lightnvm: buffer overflow in nvme_nvm_identity()
Message-ID: <20160126092734.GE15717@mwanda>

nvme_nvm_id->ppaf is 4 bytes larger than nvm_id->ppaf.  We're using the
larger size struct for the sizeof() so we end up corrupting the
first four bytes of nvm_id->groups[].  It doesn't look like we actually
want to copy those last bytes anyway.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
---
Static analysis, not tested.  Please review this one carefully, I think
this bug would show up in testing.

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 5cd3725..0f0864f 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -319,7 +319,7 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
 	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
 	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
-					sizeof(struct nvme_nvm_addr_format));
+					sizeof(struct nvm_addr_format));
 
 	ret = init_grps(nvm_id, nvme_nvm_id);
 out:
