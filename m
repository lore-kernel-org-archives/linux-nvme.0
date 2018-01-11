From: roland@kernel.org (Roland Dreier)
Date: Thu, 11 Jan 2018 13:38:00 -0800
Subject: [PATCH 1/2] nvme-fabrics: Fix memory leak when parsing host ID option
Message-ID: <20180111213800.1767-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

We use match_strdup() to get a copy of the option string for host ID string, but
we just pass it to uuid_parse() and don't store the string pointer, so we need to
kfree() the string after parsing it.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 76b4fe6816a0..2ba52f9f8185 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -738,7 +738,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (uuid_parse(p, &hostid)) {
+			ret = uuid_parse(p, &hostid);
+			kfree(p);
+			if (ret) {
 				pr_err("Invalid hostid %s\n", p);
 				ret = -EINVAL;
 				goto out;
-- 
2.14.1
