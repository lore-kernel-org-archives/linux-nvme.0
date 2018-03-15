From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:35:03 -0700
Subject: [PATCH v2 12/13] qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan
In-Reply-To: <20180315033504.12628-1-himanshu.madhani@cavium.com>
References: <20180315033504.12628-1-himanshu.madhani@cavium.com>
Message-ID: <20180315033504.12628-13-himanshu.madhani@cavium.com>

From: Quinn Tran <quinn.tran@cavium.com>

This patch combines FCP and FC-NVMe scan into single scan when
driver detects FC-NVMe capability on same port.

Signed-off-by: Quinn Tran <quinn.tran at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_def.h  |   7 +
 drivers/scsi/qla2xxx/qla_gbl.h  |   2 +-
 drivers/scsi/qla2xxx/qla_gs.c   | 274 ++++++++++++++++++++++++++++++----------
 drivers/scsi/qla2xxx/qla_init.c |   8 +-
 drivers/scsi/qla2xxx/qla_os.c   |   8 +-
 5 files changed, 225 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 576b72bef01d..eb2ec1fb07cb 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -2983,8 +2983,14 @@ enum scan_flags_t {
 	SF_QUEUED = BIT_1,
 };
 
+enum fc4type_t {
+	FS_FC4TYPE_FCP	= BIT_0,
+	FS_FC4TYPE_NVME	= BIT_1,
+};
+
 struct fab_scan_rp {
 	port_id_t id;
+	enum fc4type_t fc4type;
 	u8 port_name[8];
 	u8 node_name[8];
 };
@@ -3276,6 +3282,7 @@ struct qla_work_evt {
 		} nack;
 		struct {
 			u8 fc4_type;
+			srb_t *sp;
 		} gpnft;
 	 } u;
 };
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 19f44e12926b..3c4c84ed0f0f 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -658,7 +658,7 @@ void qla24xx_handle_gpsc_event(scsi_qla_host_t *, struct event_arg *);
 int qla2x00_mgmt_svr_login(scsi_qla_host_t *);
 void qla24xx_handle_gffid_event(scsi_qla_host_t *vha, struct event_arg *ea);
 int qla24xx_async_gffid(scsi_qla_host_t *vha, fc_port_t *fcport);
-int qla24xx_async_gpnft(scsi_qla_host_t *, u8);
+int qla24xx_async_gpnft(scsi_qla_host_t *, u8, srb_t *);
 void qla24xx_async_gpnft_done(scsi_qla_host_t *, srb_t *);
 void qla24xx_async_gnnft_done(scsi_qla_host_t *, srb_t *);
 int qla24xx_async_gnnid(scsi_qla_host_t *, fc_port_t *);
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index e6bb78e6f1d4..7ab93a0d19c1 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3860,7 +3860,6 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 	fc_port_t *fcport;
 	u32 i, rc;
 	bool found;
-	u8 fc4type = sp->gen2;
 	struct fab_scan_rp *rp;
 	unsigned long flags;
 
@@ -3933,7 +3932,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 			    "%s %d %8phC post new sess\n",
 			    __func__, __LINE__, rp->port_name);
 			qla24xx_post_newsess_work(vha, &rp->id, rp->port_name,
-			    rp->node_name, NULL, fc4type);
+			    rp->node_name, NULL, rp->fc4type);
 		}
 	}
 
@@ -3972,23 +3971,114 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 	vha->scan.scan_flags &= ~SF_SCANNING;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 
-	if ((fc4type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
-		qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
 }
 
-static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
+static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
+	struct srb *sp)
 {
-	struct srb *sp = s;
-	struct scsi_qla_host *vha = sp->vha;
-	struct qla_work_evt *e;
+	struct qla_hw_data *ha = vha->hw;
+	int num_fibre_dev = ha->max_fibre_devices;
 	struct ct_sns_req *ct_req =
 		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
 	struct ct_sns_gpnft_rsp *ct_rsp =
 		(struct ct_sns_gpnft_rsp *)sp->u.iocb_cmd.u.ctarg.rsp;
 	struct ct_sns_gpn_ft_data *d;
 	struct fab_scan_rp *rp;
+	u16 cmd = be16_to_cpu(ct_req->command);
+	u8 fc4_type = sp->gen2;
 	int i, j, k;
+	port_id_t id;
+	u8 found;
+	u64 wwn;
+
+	j = 0;
+	for (i = 0; i < num_fibre_dev; i++) {
+		d  = &ct_rsp->entries[i];
+
+		id.b.rsvd_1 = 0;
+		id.b.domain = d->port_id[0];
+		id.b.area   = d->port_id[1];
+		id.b.al_pa  = d->port_id[2];
+		wwn = wwn_to_u64(d->port_name);
+
+		if (id.b24 == 0 || wwn == 0)
+			continue;
+
+		if (fc4_type == FC4_TYPE_FCP_SCSI) {
+			if (cmd == GPN_FT_CMD) {
+				rp = &vha->scan.l[j];
+				rp->id = id;
+				memcpy(rp->port_name, d->port_name, 8);
+				j++;
+				rp->fc4type = FS_FC4TYPE_FCP;
+			} else {
+				for (k = 0; k < num_fibre_dev; k++) {
+					rp = &vha->scan.l[k];
+					if (id.b24 == rp->id.b24) {
+						memcpy(rp->node_name,
+						    d->port_name, 8);
+						break;
+					}
+				}
+			}
+		} else {
+			/* Search if the fibre device supports FC4_TYPE_NVME */
+			if (cmd == GPN_FT_CMD) {
+				found = 0;
+
+				for (k = 0; k < num_fibre_dev; k++) {
+					rp = &vha->scan.l[k];
+					if (!memcmp(rp->port_name,
+					    d->port_name, 8)) {
+						/*
+						 * Supports FC-NVMe & FCP
+						 */
+						rp->fc4type |= FS_FC4TYPE_NVME;
+						found = 1;
+						break;
+					}
+				}
+
+				/* We found new FC-NVMe only port */
+				if (!found) {
+					for (k = 0; k < num_fibre_dev; k++) {
+						rp = &vha->scan.l[k];
+						if (wwn_to_u64(rp->port_name)) {
+							continue;
+						} else {
+							rp->id = id;
+							memcpy(rp->port_name,
+							    d->port_name, 8);
+							rp->fc4type =
+							    FS_FC4TYPE_NVME;
+							break;
+						}
+					}
+				}
+			} else {
+				for (k = 0; k < num_fibre_dev; k++) {
+					rp = &vha->scan.l[k];
+					if (id.b24 == rp->id.b24) {
+						memcpy(rp->node_name,
+						    d->port_name, 8);
+						break;
+					}
+				}
+			}
+		}
+	}
+}
+
+static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
+{
+	struct srb *sp = s;
+	struct scsi_qla_host *vha = sp->vha;
+	struct qla_work_evt *e;
+	struct ct_sns_req *ct_req =
+		(struct ct_sns_req *)sp->u.iocb_cmd.u.ctarg.req;
 	u16 cmd = be16_to_cpu(ct_req->command);
+	u8 fc4_type = sp->gen2;
+	unsigned long flags;
 
 	/* gen2 field is holding the fc4type */
 	ql_dbg(ql_dbg_disc, vha, 0xffff,
@@ -4016,40 +4106,51 @@ static void qla2x00_async_gpnft_gnnft_sp_done(void *s, int res)
 		return;
 	}
 
-	if (!res) {
-		port_id_t id;
-		u64 wwn;
+	if (!res)
+		qla2x00_find_free_fcp_nvme_slot(vha, sp);
 
-		j = 0;
-		for (i = 0; i < vha->hw->max_fibre_devices; i++) {
-			d  = &ct_rsp->entries[i];
-
-			id.b.rsvd_1 = 0;
-			id.b.domain = d->port_id[0];
-			id.b.area   = d->port_id[1];
-			id.b.al_pa  = d->port_id[2];
-			wwn = wwn_to_u64(d->port_name);
-
-			if (id.b24 == 0 || wwn == 0)
-				continue;
+	if ((fc4_type == FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled &&
+	    cmd == GNN_FT_CMD) {
+		del_timer(&sp->u.iocb_cmd.timer);
+		spin_lock_irqsave(&vha->work_lock, flags);
+		vha->scan.scan_flags &= ~SF_SCANNING;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
 
-			if (cmd == GPN_FT_CMD) {
-				rp = &vha->scan.l[j];
-				rp->id = id;
-				memcpy(rp->port_name, d->port_name, 8);
-				j++;
-			} else {/* GNN_FT_CMD */
-				for (k = 0; k < vha->hw->max_fibre_devices;
-				    k++) {
-					rp = &vha->scan.l[k];
-					if (id.b24 == rp->id.b24) {
-						memcpy(rp->node_name,
-						    d->port_name, 8);
-						break;
-					}
-				}
+		e = qla2x00_alloc_work(vha, QLA_EVT_GPNFT);
+		if (!e) {
+			/*
+			 * please ignore kernel warning. Otherwise,
+			 * we have mem leak.
+			 */
+			if (sp->u.iocb_cmd.u.ctarg.req) {
+				dma_free_coherent(&vha->hw->pdev->dev,
+				    sizeof(struct ct_sns_pkt),
+				    sp->u.iocb_cmd.u.ctarg.req,
+				    sp->u.iocb_cmd.u.ctarg.req_dma);
+				sp->u.iocb_cmd.u.ctarg.req = NULL;
 			}
+			if (sp->u.iocb_cmd.u.ctarg.rsp) {
+				dma_free_coherent(&vha->hw->pdev->dev,
+				    sizeof(struct ct_sns_pkt),
+				    sp->u.iocb_cmd.u.ctarg.rsp,
+				    sp->u.iocb_cmd.u.ctarg.rsp_dma);
+				sp->u.iocb_cmd.u.ctarg.rsp = NULL;
+			}
+
+			ql_dbg(ql_dbg_disc, vha, 0xffff,
+			    "Async done-%s unable to alloc work element\n",
+			    sp->name);
+			sp->free(sp);
+			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
+			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
+			return;
 		}
+		e->u.gpnft.fc4_type = FC4_TYPE_NVME;
+		sp->rc = res;
+		e->u.gpnft.sp = sp;
+
+		qla2x00_post_work(vha, e);
+		return;
 	}
 
 	if (cmd == GPN_FT_CMD)
@@ -4100,9 +4201,12 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 	int rval = QLA_FUNCTION_FAILED;
 	struct ct_sns_req *ct_req;
 	struct ct_sns_pkt *ct_sns;
+	unsigned long flags;
 
 	if (!vha->flags.online) {
+		spin_lock_irqsave(&vha->work_lock, flags);
 		vha->scan.scan_flags &= ~SF_SCANNING;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
 		goto done_free_sp;
 	}
 
@@ -4111,10 +4215,18 @@ static int qla24xx_async_gnnft(scsi_qla_host_t *vha, struct srb *sp,
 		    "%s: req %p rsp %p are not setup\n",
 		    __func__, sp->u.iocb_cmd.u.ctarg.req,
 		    sp->u.iocb_cmd.u.ctarg.rsp);
+		spin_lock_irqsave(&vha->work_lock, flags);
 		vha->scan.scan_flags &= ~SF_SCANNING;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
 		WARN_ON(1);
 		goto done_free_sp;
 	}
+
+	ql_dbg(ql_dbg_disc, vha, 0xfffff,
+	    "%s: FC4Type %x, CT-PASSTRHU %s command ctarg rsp size %d, ctarg req size %d\n",
+	    __func__, fc4_type, sp->name, sp->u.iocb_cmd.u.ctarg.rsp_size,
+	     sp->u.iocb_cmd.u.ctarg.req_size);
+
 	sp->type = SRB_CT_PTHRU_CMD;
 	sp->name = "gnnft";
 	sp->gen1 = vha->hw->base_qpair->chip_reset;
@@ -4177,15 +4289,17 @@ void qla24xx_async_gpnft_done(scsi_qla_host_t *vha, srb_t *sp)
 }
 
 /* Get WWPN list for certain fc4_type */
-int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type)
+int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 {
 	int rval = QLA_FUNCTION_FAILED;
 	struct ct_sns_req       *ct_req;
-	srb_t *sp;
 	struct ct_sns_pkt *ct_sns;
 	u32 rspsz;
 	unsigned long flags;
 
+	ql_dbg(ql_dbg_disc, vha, 0xffff,
+	    "%s enter\n", __func__);
+
 	if (!vha->flags.online)
 		return rval;
 
@@ -4198,9 +4312,58 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type)
 	vha->scan.scan_flags |= SF_SCANNING;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
 
-	sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
-	if (!sp) {
-		vha->scan.scan_flags &= ~SF_SCANNING;
+	if (fc4_type == FC4_TYPE_FCP_SCSI) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "%s: Performing FCP Scan\n", __func__);
+
+		if (sp)
+			sp->free(sp); /* should not happen */
+
+		sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
+		if (!sp) {
+			spin_lock_irqsave(&vha->work_lock, flags);
+			vha->scan.scan_flags &= ~SF_SCANNING;
+			spin_unlock_irqrestore(&vha->work_lock, flags);
+			return rval;
+		}
+
+		sp->u.iocb_cmd.u.ctarg.req = dma_zalloc_coherent(
+			&vha->hw->pdev->dev, sizeof(struct ct_sns_pkt),
+			&sp->u.iocb_cmd.u.ctarg.req_dma, GFP_KERNEL);
+		if (!sp->u.iocb_cmd.u.ctarg.req) {
+			ql_log(ql_log_warn, vha, 0xffff,
+			    "Failed to allocate ct_sns request.\n");
+			spin_lock_irqsave(&vha->work_lock, flags);
+			vha->scan.scan_flags &= ~SF_SCANNING;
+			spin_unlock_irqrestore(&vha->work_lock, flags);
+			goto done_free_sp;
+		}
+		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
+
+		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
+			((vha->hw->max_fibre_devices - 1) *
+			    sizeof(struct ct_sns_gpn_ft_data));
+
+		sp->u.iocb_cmd.u.ctarg.rsp = dma_zalloc_coherent(
+			&vha->hw->pdev->dev, rspsz,
+			&sp->u.iocb_cmd.u.ctarg.rsp_dma, GFP_KERNEL);
+		if (!sp->u.iocb_cmd.u.ctarg.rsp) {
+			ql_log(ql_log_warn, vha, 0xffff,
+			    "Failed to allocate ct_sns request.\n");
+			spin_lock_irqsave(&vha->work_lock, flags);
+			vha->scan.scan_flags &= ~SF_SCANNING;
+			spin_unlock_irqrestore(&vha->work_lock, flags);
+			goto done_free_sp;
+		}
+		sp->u.iocb_cmd.u.ctarg.rsp_size = rspsz;
+
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "%s scan list size %d\n", __func__, vha->scan.size);
+
+		memset(vha->scan.l, 0, vha->scan.size);
+	} else if (!sp) {
+		ql_dbg(ql_dbg_disc, vha, 0xffff,
+		    "NVME scan did not provide SP\n");
 		return rval;
 	}
 
@@ -4210,31 +4373,10 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type)
 	sp->gen2 = fc4_type;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
 
-	sp->u.iocb_cmd.u.ctarg.req = dma_zalloc_coherent(&vha->hw->pdev->dev,
-	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
-	    GFP_KERNEL);
-	if (!sp->u.iocb_cmd.u.ctarg.req) {
-		ql_log(ql_log_warn, vha, 0xffff,
-		    "Failed to allocate ct_sns request.\n");
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		goto done_free_sp;
-	}
-
 	rspsz = sizeof(struct ct_sns_gpnft_rsp) +
 		((vha->hw->max_fibre_devices - 1) *
 		    sizeof(struct ct_sns_gpn_ft_data));
 
-	sp->u.iocb_cmd.u.ctarg.rsp = dma_zalloc_coherent(&vha->hw->pdev->dev,
-	    rspsz, &sp->u.iocb_cmd.u.ctarg.rsp_dma, GFP_KERNEL);
-	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
-		ql_log(ql_log_warn, vha, 0xffff,
-		    "Failed to allocate ct_sns request.\n");
-		vha->scan.scan_flags &= ~SF_SCANNING;
-		goto done_free_sp;
-	}
-
-	memset(vha->scan.l, 0, vha->scan.size);
-
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 	/* CT_IU preamble  */
 	ct_req = qla2x00_prep_ct_req(ct_sns, GPN_FT_CMD, rspsz);
@@ -4242,8 +4384,6 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type)
 	/* GPN_FT req */
 	ct_req->req.gpn_ft.port_type = fc4_type;
 
-	sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
-	sp->u.iocb_cmd.u.ctarg.rsp_size = rspsz;
 	sp->u.iocb_cmd.u.ctarg.nport_handle = NPH_SNS;
 
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
@@ -4251,7 +4391,9 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type)
 
 	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS) {
+		spin_lock_irqsave(&vha->work_lock, flags);
 		vha->scan.scan_flags &= ~SF_SCANNING;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
 		goto done_free_sp;
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 5520477a66d9..8aeb0ed524a1 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5039,9 +5039,9 @@ qla2x00_iidma_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 		    fcport->port_name, rval, fcport->fp_speed, mb[0], mb[1]);
 	} else {
 		ql_dbg(ql_dbg_disc, vha, 0x2005,
-		    "iIDMA adjusted to %s GB/s on %8phN.\n",
+		    "iIDMA adjusted to %s GB/s (%X) on %8phN.\n",
 		    qla2x00_get_link_speed_str(ha, fcport->fp_speed),
-		    fcport->port_name);
+		    fcport->fp_speed, fcport->port_name);
 	}
 }
 
@@ -5267,8 +5267,8 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		qlt_do_generation_tick(vha, &discovery_gen);
 
 		if (USE_ASYNC_SCAN(ha)) {
-			rval = QLA_SUCCESS;
-			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI);
+			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
+			    NULL);
 			if (rval)
 				set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
 		} else  {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7fe265aca617..00b41528af5a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4821,9 +4821,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 			fcport->d_id = e->u.new_sess.id;
 			fcport->flags |= FCF_FABRIC_DEVICE;
 			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
-			if (e->u.new_sess.fc4_type == FC4_TYPE_FCP_SCSI) {
+			if (e->u.new_sess.fc4_type & FS_FC4TYPE_FCP)
 				fcport->fc4_type = FC4_TYPE_FCP_SCSI;
-			} else if (e->u.new_sess.fc4_type == FC4_TYPE_NVME) {
+
+			if (e->u.new_sess.fc4_type & FS_FC4TYPE_NVME) {
 				fcport->fc4_type = FC4_TYPE_OTHER;
 				fcport->fc4f_nvme = FC4_TYPE_NVME;
 			}
@@ -5046,7 +5047,8 @@ qla2x00_do_work(struct scsi_qla_host *vha)
 			    e->u.logio.data);
 			break;
 		case QLA_EVT_GPNFT:
-			qla24xx_async_gpnft(vha, e->u.gpnft.fc4_type);
+			qla24xx_async_gpnft(vha, e->u.gpnft.fc4_type,
+			    e->u.gpnft.sp);
 			break;
 		case QLA_EVT_GPNFT_DONE:
 			qla24xx_async_gpnft_done(vha, e->u.iosb.sp);
-- 
2.12.0
