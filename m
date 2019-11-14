Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31AEC432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 23:15:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EA7206F0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 23:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YoJ1fbSv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am5nwUWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EA7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YQFwhFvPD+kWH2uYqEveTVYKtFH8E1xmRAPepjA6cmI=; b=YoJ
	1fbSvO4yZ+UHKJORuZ89EunTkbRWY9WEWO7AIDkUTHSCznzlH5g9JD+BSGe3VQ0AaT3DXgsgkuibf
	f6TNlc8Xrp02p2T3q81+vFBJ1Ppfp45eCNIPlo3KORIis6MPf4AXLpcAFjAsfE+Hk1nhlCIl6+s6y
	lJkq15UfPllx6YDw4ev7pFk+vGNGPvEkym4a9BY2OUyfXPnd7ObjSzSLgPjQ7ea8M74dVprBaBYd9
	57nEHaM30x8QL5zHxQY1iR/b1OIInrN8g145KezpZUHd1B2WnQ6Ksz3aII0zMevJfSFuFsApzvuTI
	mvMpnWAHdb3KDcAJTjr5hVP0sau2Uiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVOKx-0001LU-NA; Thu, 14 Nov 2019 23:15:39 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVOKv-0001L6-8H
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 23:15:38 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so8834833wrx.3
 for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2019 15:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=8i0AqV+VUYLylsY5/HnR0rGUCfx4wnLnL4MwG4yBjkk=;
 b=am5nwUWgkzBsUzdqJBit8u87bDbQTaA4YtAZw9fVKspfDljQVk+fsTOied6/tsBI4L
 B8qgl+A/T2NfGWLo3Gyxwn3hTf8kh15t63AQMbky/GrvKiyXiGDkUuYSuhIPu3TgghIA
 unOlrEVtxi982dplObpvm/0TdcYlo/6oHbv+3wRPHMUgYmffacJU3sDhzI1QPPpsWZrM
 YkG4j+lWUqmjkr7OoZG3sqOqkdiGD7Uwl7Zn0dj47OHVgNaQ7lpYY9j7j4jPeRedIWBn
 v0g43WjmNdf6BtK7B3pe0sP8pAnD4fQCu4K6MZpYdygDtTAOsWwRswutoiRgx2+gNXFj
 +vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8i0AqV+VUYLylsY5/HnR0rGUCfx4wnLnL4MwG4yBjkk=;
 b=VW2Xoh0Ti+bTkzYQQ0VcWxJMoTggObAYmm/TMVoyAg18yz1XlK272xR5aE+jHGnfsM
 r315XR6dQFc3OUQRM54QRNGV2xEgySSnAiONNl1RKdlGCeAB1HT7Sz/YOha1xzRGNmVr
 vVv/uxFQcY60TkPv3Mb1q9Xz5xNKQA6mO8whPsiWcdVugYqtoSJwIPJq7FXzgEXjytLb
 WFJlAhfLmKphDt2UXY51sFH1g7D+6U66TJYOLB5C5A2fAUB3ElyDSLiFyt2b8r7W135U
 ZiAfs4GaPNf9ba9tT53l4ppZ3hhBtvKIhKFG5tPrDLdRrndGQRj1onnp8kYf+E9NyyDX
 hmmA==
X-Gm-Message-State: APjAAAU31wFZXba8PofwU6Mp2lg7mcZC/AhEhbEKakX0MejPUPOEiG0Z
 9zT3D6wuHGjfJGW/8080bfahgKOK
X-Google-Smtp-Source: APXvYqx0OO3pUfVTQap/q/mbgmVKuNe5BCrx4/f54oPEIPR/0ApcyoMkCdFiqOY1J9JfpsxOFxyYUA==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr1778445wrr.207.1573773335052; 
 Thu, 14 Nov 2019 15:15:35 -0800 (PST)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id w81sm8948157wmg.5.2019.11.14.15.15.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Nov 2019 15:15:34 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme_fc : add module to ops template to allow module
 references
Date: Thu, 14 Nov 2019 15:15:26 -0800
Message-Id: <20191114231526.21807-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191114_151537_321828_C3CA9FE1 
X-CRM114-Status: GOOD (  17.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme-fc: it's possible to have connected active controllers
and as no references are taken on the LLDD, the LLDD can be
unloaded.  The controller would enter a reconnect state and as
long as the LLDD resumed within the reconnect timeout, the
controller would resume.  But if a namespace on the controller
is the root device, allowing the driver to unload can be problematic.
To reload the driver, it may require new io to the boot device,
and as it's no longer connected we get into a catch-22 that
eventually fails, and the system locks up.

Fix this issue by taking a module reference for every connected
controller (which is what the core layer did to the transport
module). Reference is cleared when the controller is removed.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c          | 14 ++++++++++++--
 drivers/nvme/target/fcloop.c    |  1 +
 drivers/scsi/lpfc/lpfc_nvme.c   |  2 ++
 drivers/scsi/qla2xxx/qla_nvme.c |  1 +
 include/linux/nvme-fc-driver.h  |  4 ++++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 679a721ae229..40f9241c592f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -342,7 +342,8 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	    !template->ls_req || !template->fcp_io ||
 	    !template->ls_abort || !template->fcp_abort ||
 	    !template->max_hw_queues || !template->max_sgl_segments ||
-	    !template->max_dif_sgl_segments || !template->dma_boundary) {
+	    !template->max_dif_sgl_segments || !template->dma_boundary ||
+	    !template->module) {
 		ret = -EINVAL;
 		goto out_reghost_failed;
 	}
@@ -2015,6 +2016,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 {
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
+	struct nvme_fc_lport *lport = ctrl->lport;
 	unsigned long flags;
 
 	if (ctrl->ctrl.tagset) {
@@ -2041,6 +2043,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	if (ctrl->ctrl.opts)
 		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
+	module_put(lport->ops->module);
 }
 
 static void
@@ -3059,10 +3062,15 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
+	if (!try_module_get(lport->ops->module)) {
+		ret = -EUNATCH;
+		goto out_free_ctrl;
+	}
+
 	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
-		goto out_free_ctrl;
+		goto out_mod_put;
 	}
 
 	ctrl->ctrl.opts = opts;
@@ -3215,6 +3223,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ida:
 	put_device(ctrl->dev);
 	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
+out_mod_put:
+	module_put(lport->ops->module);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b50b53db3746..1c50af6219f3 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -850,6 +850,7 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 #define FCLOOP_DMABOUND_4G		0xFFFFFFFF
 
 static struct nvme_fc_port_template fctemplate = {
+	.module			= THIS_MODULE,
 	.localport_delete	= fcloop_localport_delete,
 	.remoteport_delete	= fcloop_remoteport_delete,
 	.create_queue		= fcloop_create_queue,
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index a227e36cbdc2..8e0f03ef346b 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1976,6 +1976,8 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 
 /* Declare and initialization an instance of the FC NVME template. */
 static struct nvme_fc_port_template lpfc_nvme_template = {
+	.module	= THIS_MODULE,
+
 	/* initiator-based functions */
 	.localport_delete  = lpfc_nvme_localport_delete,
 	.remoteport_delete = lpfc_nvme_remoteport_delete,
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 6cc19e060afc..6e4d71302534 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -610,6 +610,7 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 }
 
 static struct nvme_fc_port_template qla_nvme_fc_transport = {
+	.module	= THIS_MODULE,
 	.localport_delete = qla_nvme_localport_delete,
 	.remoteport_delete = qla_nvme_remoteport_delete,
 	.create_queue   = qla_nvme_alloc_queue,
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 10f81629b9ce..6d0d70f3219c 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -270,6 +270,8 @@ struct nvme_fc_remote_port {
  *
  * Host/Initiator Transport Entrypoints/Parameters:
  *
+ * @module:  The LLDD module using the interface
+ *
  * @localport_delete:  The LLDD initiates deletion of a localport via
  *       nvme_fc_deregister_localport(). However, the teardown is
  *       asynchronous. This routine is called upon the completion of the
@@ -383,6 +385,8 @@ struct nvme_fc_remote_port {
  *       Value is Mandatory. Allowed to be zero.
  */
 struct nvme_fc_port_template {
+	struct module	*module;
+
 	/* initiator-based functions */
 	void	(*localport_delete)(struct nvme_fc_local_port *);
 	void	(*remoteport_delete)(struct nvme_fc_remote_port *);
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
