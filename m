From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 18 Apr 2017 17:32:15 -0600
Subject: [PATCH] nvmet: convert from kmap to nvmet_copy_from_sgl
Message-ID: <1492558335-2845-1-git-send-email-logang@deltatee.com>

This is safer as it doesn't rely on the data being stored in
a single page in an sgl.

It also aids our effort to start phasing out users of sg_page. See [1].

For this we kmalloc some memory, copy to it and free at the end. Note:
we can't allocate this memory on the stack as the kbuild test robot
reports some frame size overflows on i386.

[1] https://lwn.net/Articles/720053/

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/fabrics-cmd.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 8bd022af..2e0ab10 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -122,7 +122,15 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
-	d = kmap(sg_page(req->sg)) + req->sg->offset;
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto complete;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (status)
+		goto out;
 
 	/* zero out initial completion result, assign values as needed */
 	req->rsp->result.u32 = 0;
@@ -143,7 +151,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	}
 
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
-			le32_to_cpu(c->kato), &ctrl);
+				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
 		goto out;
 
@@ -158,7 +166,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
-	kunmap(sg_page(req->sg));
+	kfree(d);
+complete:
 	nvmet_req_complete(req, status);
 }
 
@@ -170,7 +179,15 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
-	d = kmap(sg_page(req->sg)) + req->sg->offset;
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto complete;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (status)
+		goto out;
 
 	/* zero out initial completion result, assign values as needed */
 	req->rsp->result.u32 = 0;
@@ -183,8 +200,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	}
 
 	status = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-			le16_to_cpu(d->cntlid),
-			req, &ctrl);
+				     le16_to_cpu(d->cntlid),
+				     req, &ctrl);
 	if (status)
 		goto out;
 
@@ -205,7 +222,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	pr_info("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
 out:
-	kunmap(sg_page(req->sg));
+	kfree(d);
+complete:
 	nvmet_req_complete(req, status);
 	return;
 
-- 
2.1.4
