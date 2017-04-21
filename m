From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:05 +0200
Subject: [PATCH 7/7] nvmet/fcloop: mark two symbols static
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-8-hch@lst.de>

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fcloop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index aaa3dbe22bd5..15551ef79c8c 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -666,7 +666,7 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 #define	FCLOOP_SGL_SEGS			256
 #define FCLOOP_DMABOUND_4G		0xFFFFFFFF
 
-struct nvme_fc_port_template fctemplate = {
+static struct nvme_fc_port_template fctemplate = {
 	.localport_delete	= fcloop_localport_delete,
 	.remoteport_delete	= fcloop_remoteport_delete,
 	.create_queue		= fcloop_create_queue,
@@ -686,7 +686,7 @@ struct nvme_fc_port_template fctemplate = {
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
-struct nvmet_fc_target_template tgttemplate = {
+static struct nvmet_fc_target_template tgttemplate = {
 	.targetport_delete	= fcloop_targetport_delete,
 	.xmt_ls_rsp		= fcloop_xmt_ls_rsp,
 	.fcp_op			= fcloop_fcp_op,
-- 
2.11.0
