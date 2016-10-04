From: james.smart@broadcom.com (James Smart)
Date: Mon, 03 Oct 2016 23:27:00 -0700
Subject: [PATCH 4/7] nvme-fabrics: Updates to FC LLDD api
Message-ID: <57f34bb4.88wY2eZRXxyCcIzu%james.smart@broadcom.com>


Updated the FC-NVME LLDD api for the following:
- removal of fabric name for nport qualifier. No longer necessary in T11
- Added sqid to the initiator FCP request structure.
  Useful to the LLDD when re-generating successful CQE payloads
  which were not transferred due to protocol reasons.
- Add poll_queue() callback to initiator template. Supports the blk-mq
  polling interfaces to look for command completion.
- Add callbacks for localport, remoteport, and targetport unregister
  completions. Required after change for ref-counting.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme-fc-driver.h | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 78918a7..22c1b07 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -42,9 +42,6 @@
  * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
  *
  * Initialization values for dynamic port fields:
- * @fabric_name:  FC Fabric name the port is connected to. If connection is
- *                point-to-point (no switch) use srcport WWPN. If no current
- *                Link Up, set to 0.
  * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
  *                be set to 0.
  */
@@ -52,7 +49,6 @@ struct nvme_fc_port_info {
 	u64			node_name;
 	u64			port_name;
 	u32			port_role;
-	u64			fabric_name;
 	u32			port_id;
 };
 
@@ -125,6 +121,7 @@ enum nvmefc_fcp_datadir {
  * @first_sgl: memory for 1st scatter/gather list segment for payload data
  * @sg_cnt:    number of elements in the scatter/gather list
  * @io_dir:    direction of the FCP request (see NVMEFC_FCP_xxx)
+ * @sqid:      The nvme SQID the command is being issued on
  * @done:      The callback routine the LLDD is to invoke upon completion of
  *             the FCP operation. req argument is the pointer to the original
  *             FCP IO operation.
@@ -158,6 +155,8 @@ struct nvmefc_fcp_req {
 	int			sg_cnt;
 	enum nvmefc_fcp_datadir	io_dir;
 
+	__le16			sqid;
+
 	void (*done)(struct nvmefc_fcp_req *req);
 
 	void			*private;
@@ -209,9 +208,6 @@ enum nvme_fc_obj_state {
  * port_info struct supplied to the registration call.
  * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
  *                be set to 0.
- * @fabric_name:  FC Fabric name the port is connected to. If connection is
- *                point-to-point (no switch) use srcport WWPN. If no current
- *                Link Up, set to 0.
  * @port_state:   Operational state of the port.
  */
 struct nvme_fc_local_port {
@@ -225,7 +221,6 @@ struct nvme_fc_local_port {
 
 	/* dynamic fields */
 	u32 port_id;
-	u64 fabric_name;
 	enum nvme_fc_obj_state port_state;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
@@ -284,6 +279,18 @@ struct nvme_fc_remote_port {
  *
  * Host/Initiator Transport Entrypoints/Parameters:
  *
+ * @localport_delete:  The LLDD initiates deletion of a localport via
+ *       nvme_fc_deregister_localport(). However, the teardown is
+ *       asynchronous. This routine is called upon the completion of the
+ *       teardown to inform the LLDD that the localport has been deleted.
+ *       Entrypoint is Mandatory.
+ *
+ * @remoteport_delete:  The LLDD initiates deletion of a remoteport via
+ *       nvme_fc_deregister_remoteport(). However, the teardown is
+ *       asynchronous. This routine is called upon the completion of the
+ *       teardown to inform the LLDD that the remoteport has been deleted.
+ *       Entrypoint is Mandatory.
+ *
  * @create_queue:  Upon creating a host<->controller association, queues are
  *       created such that they can be affinitized to cpus/cores. This
  *       callback into the LLDD to notify that a controller queue is being
@@ -305,6 +312,9 @@ struct nvme_fc_remote_port {
  *       hw queue should be torn down.
  *       Entrypoint is Optional.
  *
+ * @poll_queue:  Called to poll for the completion of an io on a blk queue.
+ *       Entrypoint is Optional.
+ *
  * @ls_req:  Called to issue a FC-NVME FC-4 LS service request.
  *       The nvme_fc_ls_req structure will fully describe the buffers for
  *       the request payload and where to place the response payload. The
@@ -383,11 +393,14 @@ struct nvme_fc_remote_port {
  */
 struct nvme_fc_port_template {
 	/* initiator-based functions */
+	void	(*localport_delete)(struct nvme_fc_local_port *);
+	void	(*remoteport_delete)(struct nvme_fc_remote_port *);
 	int	(*create_queue)(struct nvme_fc_local_port *,
 				unsigned int qidx, u16 qsize,
 				void **handle);
 	void	(*delete_queue)(struct nvme_fc_local_port *,
 				unsigned int qidx, void *handle);
+	void	(*poll_queue)(struct nvme_fc_local_port *, void *handle);
 	int	(*ls_req)(struct nvme_fc_local_port *,
 				struct nvme_fc_remote_port *,
 				struct nvmefc_ls_req *);
@@ -453,17 +466,12 @@ int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
  * @port_name: FC WWPN for the port
  *
  * Initialization values for dynamic port fields:
- * @fabric_name:  FC Fabric name the port is connected to. If connection is
- *                point-to-point (no switch) use srcport WWPN. If no current
- *                Link Up, set to 0.
  * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
  *                be set to 0.
  */
 struct nvmet_fc_port_info {
 	u64			node_name;
 	u64			port_name;
-
-	u64			fabric_name;
 	u32			port_id;
 };
 
@@ -655,9 +663,6 @@ enum {
  * port_info struct supplied to the registration call.
  * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
  *                be set to 0.
- * @fabric_name:  FC Fabric name the port is connected to. If connection is
- *                point-to-point (no switch) use srcport WWPN. If no current
- *                Link Up, set to 0.
  * @port_state:   Operational state of the port.
  */
 struct nvmet_fc_target_port {
@@ -670,7 +675,6 @@ struct nvmet_fc_target_port {
 
 	/* dynamic fields */
 	u32 port_id;
-	u64 fabric_name;
 	enum nvme_fc_obj_state port_state;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
@@ -684,6 +688,12 @@ struct nvmet_fc_target_port {
  *
  * Subsystem/Target Transport Entrypoints/Parameters:
  *
+ * @targetport_delete:  The LLDD initiates deletion of a targetport via
+ *       nvmet_fc_unregister_targetport(). However, the teardown is
+ *       asynchronous. This routine is called upon the completion of the
+ *       teardown to inform the LLDD that the targetport has been deleted.
+ *       Entrypoint is Mandatory.
+ *
  * @xmt_ls_rsp:  Called to transmit the response to a FC-NVME FC-4 LS service.
  *       The nvmefc_tgt_ls_req structure is the same LLDD-supplied exchange
  *       structure specified in the nvmet_fc_rcv_ls_req() call made when
@@ -788,6 +798,7 @@ struct nvmet_fc_target_port {
  *       Value is Mandatory. Allowed to be zero.
  */
 struct nvmet_fc_target_template {
+	void (*targetport_delete)(struct nvmet_fc_target_port *tgtport);
 	int (*xmt_ls_rsp)(struct nvmet_fc_target_port *tgtport,
 				struct nvmefc_tgt_ls_req *tls_req);
 	int (*fcp_op)(struct nvmet_fc_target_port *tgtport,
-- 
2.5.0
