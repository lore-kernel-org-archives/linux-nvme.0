From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 17:50:22 -0700
Subject: [PATCH v2 1/7] nvme: remove unnecessary controller subnqn validation
In-Reply-To: <20180512005028.29661-1-jsmart2021@gmail.com>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
Message-ID: <20180512005028.29661-2-jsmart2021@gmail.com>

After creating the nvme controller, nvmf_create_ctrl() validates
the newly created subsysnqn vs the one specified by the options.

In general, this is an unnecessary check as the Connect message
should implicitly ensure this value matches.

With the change to the FC transport to do an asynchronous connect
for the first association create, the transport will return to
nvmf_create_ctrl() before that first association has been established,
thus the subnqn will not yet be set.

Remove the unnecessary validation.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ae732a77fe8..6fdf499d16b4 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -983,16 +983,6 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_module_put;
 	}
 
-	if (strcmp(ctrl->subsys->subnqn, opts->subsysnqn)) {
-		dev_warn(ctrl->device,
-			"controller returned incorrect NQN: \"%s\".\n",
-			ctrl->subsys->subnqn);
-		module_put(ops->module);
-		up_read(&nvmf_transports_rwsem);
-		nvme_delete_ctrl_sync(ctrl);
-		return ERR_PTR(-EINVAL);
-	}
-
 	module_put(ops->module);
 	up_read(&nvmf_transports_rwsem);
 	return ctrl;
-- 
2.13.1
