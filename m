Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386EC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D511C20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="do8b97DV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ+EE5CY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D511C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i3qLhANiWiEwH+/BMmaPk6Q7DeEjafcCBpJUqzDI8gY=; b=do8b97DVAtj8C8XfUkwtUjf7q3
	BlJjpc24QZhiFiLTQf19aBUcc3ztEzlHnvxR4uPlvKmD7gDNWPCqAav/v9qNeP8fKzYulNtadDmzf
	nXF60nBKN+mn0qByvVjJRIBhUkDI5y5Xi3BZf32gK1ON+SRPXFfd7kebz7zN/h/C3HMj+l5QyEcGa
	fE0ANHMKWqWsh5t6fu9sD/AVObs98SbuI1NgjPYLkjuZVuK74WA2sCp/n3+rjtRP7jA6Xhwl3bp5D
	Xiu/yhKL9FEri+mJRzwt1mE7wa+aDqtyoVccDcV9M08VXrwXeylZYTfa54WG1hsJeSsN+pgiroxMm
	Blexa4VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPe1-0000JE-E0; Wed, 05 Feb 2020 18:43:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZI-0003qJ-Rr
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id z7so3977907wrl.13
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Cyd56R++xSIDSw1pjR+BLtBHHrmshkP9IJ8p++ICkOY=;
 b=IZ+EE5CYh/DfoT4WID0AvoRsQ4qFp1MfCbGKKgqjyGZ+MKUASTfjnKImY2E8UDiati
 2pqRDJfwBTehmIYmKBGFYqSUizUHxYmmc7gaf5DgDHQvbnqLcdzVFeLbU0lvusKR4QDS
 mF6MCOwhgApGyho/9YT/WHKToxWLBJNDCRsaKF1QGMYVTOaUKwL1liAwHalFE26lAmjU
 lp754/V8sPJtuGho7uX5GAX5NKxPtoRa6vT3Qzs2/j9S46b7xtA/qVDPHX37QbrMxcEi
 8W6YJlDBvFJQGbrcr/WTmimVRvY9IvtYXvbehb3cr3dhce55tnNmkHq8F96Oa4Y54ozc
 EuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Cyd56R++xSIDSw1pjR+BLtBHHrmshkP9IJ8p++ICkOY=;
 b=qHDJ8otxejJrO0cTF7B8lbrD/dgaxTFIJUv/Yf2TNlximh/0hLUema4xeihTRKg2MB
 ZK8Stg7LKV/cHXFdMW8zSupwL4SjTYZ7ic9GX8Uk+WZmRTKZudELf/bNKFBagzw7YvQ5
 Y3Cgfue4oprMVLcPxRhhGNr0SKyNAyWr8nDulYVcMpCZpfwAsHMItTxWmD1kzcKj9BPB
 +8jwUPho4xnoRED0lm0owPcAHQMDWsFSEy+gbNgPm2+dX0/Yf0Ys58dqZ4FE3+umOVzj
 RLqYPx6CFvjrUdcYWNZLZP2bY1IYp/oBX95Avsui/LGpxPvTE2MZ1y1P70WXDKuef+LX
 YGWA==
X-Gm-Message-State: APjAAAVHqE4E5PVifZqQB1YjGxseRUGyc0jNs5X3C+AhcIzGUzumEiNR
 XQfAbkbgkeNtpqibnD2hT+MtfBRi
X-Google-Smtp-Source: APXvYqw3w9HP/u9gIOS3LLS0fcX8dfh2OJPdALPn6Rlmu6KWIxhH9GtVw7xDlFvNLl2Rdzzz5wXbCw==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr30081337wro.421.1580927911417; 
 Wed, 05 Feb 2020 10:38:31 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:31 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 19/29] nvme-fcloop: add target to host LS request support
Date: Wed,  5 Feb 2020 10:37:43 -0800
Message-Id: <20200205183753.25959-20-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103832_948647_2FB65B79 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add support for performing LS requests from target to host.
Include sending request from targetport, reception into host,
host sending ls rsp.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/target/fcloop.c | 131 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 118 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5293069e2769..3610b0bd12da 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -208,10 +208,13 @@ struct fcloop_rport {
 };
 
 struct fcloop_tport {
-	struct nvmet_fc_target_port *targetport;
-	struct nvme_fc_remote_port *remoteport;
-	struct fcloop_nport *nport;
-	struct fcloop_lport *lport;
+	struct nvmet_fc_target_port	*targetport;
+	struct nvme_fc_remote_port	*remoteport;
+	struct fcloop_nport		*nport;
+	struct fcloop_lport		*lport;
+	spinlock_t			lock;
+	struct list_head		ls_list;
+	struct work_struct		ls_work;
 };
 
 struct fcloop_nport {
@@ -226,13 +229,7 @@ struct fcloop_nport {
 	u32 port_id;
 };
 
-enum {
-	H2T	= 0,
-	T2H	= 1,
-};
-
 struct fcloop_lsreq {
-	int				lsdir;	/* H2T or T2H */
 	struct nvmefc_ls_req		*lsreq;
 	struct nvmefc_ls_rsp		ls_rsp;
 	int				status;
@@ -337,7 +334,6 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	struct fcloop_rport *rport = remoteport->private;
 	int ret = 0;
 
-	tls_req->lsdir = H2T;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -351,8 +347,9 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	}
 
 	tls_req->status = 0;
-	ret = nvmet_fc_rcv_ls_req(rport->targetport, NULL, &tls_req->ls_rsp,
-				 lsreq->rqstaddr, lsreq->rqstlen);
+	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
+				  &tls_req->ls_rsp,
+				  lsreq->rqstaddr, lsreq->rqstlen);
 
 	return ret;
 }
@@ -384,6 +381,99 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	return 0;
 }
 
+static void
+fcloop_tport_lsrqst_work(struct work_struct *work)
+{
+	struct fcloop_tport *tport =
+		container_of(work, struct fcloop_tport, ls_work);
+	struct fcloop_lsreq *tls_req;
+
+	spin_lock(&tport->lock);
+	for (;;) {
+		tls_req = list_first_entry_or_null(&tport->ls_list,
+				struct fcloop_lsreq, ls_list);
+		if (!tls_req)
+			break;
+
+		list_del(&tls_req->ls_list);
+		spin_unlock(&tport->lock);
+
+		tls_req->lsreq->done(tls_req->lsreq, tls_req->status);
+		/*
+		 * callee may free memory containing tls_req.
+		 * do not reference lsreq after this.
+		 */
+
+		spin_lock(&tport->lock);
+	}
+	spin_unlock(&tport->lock);
+}
+
+static int
+fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
+			struct nvmefc_ls_req *lsreq)
+{
+	struct fcloop_lsreq *tls_req = lsreq->private;
+	struct fcloop_tport *tport = targetport->private;
+	int ret = 0;
+
+	/*
+	 * hosthandle should be the dst.rport value.
+	 * hosthandle ignored as fcloop currently is
+	 * 1:1 tgtport vs remoteport
+	 */
+	tls_req->lsreq = lsreq;
+	INIT_LIST_HEAD(&tls_req->ls_list);
+
+	if (!tport->remoteport) {
+		tls_req->status = -ECONNREFUSED;
+		spin_lock(&tport->lock);
+		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		spin_unlock(&tport->lock);
+		schedule_work(&tport->ls_work);
+		return ret;
+	}
+
+	tls_req->status = 0;
+	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
+				 lsreq->rqstaddr, lsreq->rqstlen);
+
+	return ret;
+}
+
+static int
+fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
+			struct nvme_fc_remote_port *remoteport,
+			struct nvmefc_ls_rsp *lsrsp)
+{
+	struct fcloop_lsreq *tls_req = ls_rsp_to_lsreq(lsrsp);
+	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+	struct fcloop_rport *rport = remoteport->private;
+	struct nvmet_fc_target_port *targetport = rport->targetport;
+	struct fcloop_tport *tport;
+
+	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
+		((lsreq->rsplen < lsrsp->rsplen) ?
+				lsreq->rsplen : lsrsp->rsplen));
+	lsrsp->done(lsrsp);
+
+	if (targetport) {
+		tport = targetport->private;
+		spin_lock(&tport->lock);
+		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		spin_unlock(&tport->lock);
+		schedule_work(&tport->ls_work);
+	}
+
+	return 0;
+}
+
+static void
+fcloop_t2h_host_release(void *hosthandle)
+{
+	/* host handle ignored for now */
+}
+
 /*
  * Simulate reception of RSCN and converting it to a initiator transport
  * call to rescan a remote port.
@@ -776,6 +866,12 @@ fcloop_h2t_ls_abort(struct nvme_fc_local_port *localport,
 }
 
 static void
+fcloop_t2h_ls_abort(struct nvmet_fc_target_port *targetport,
+			void *hosthandle, struct nvmefc_ls_req *lsreq)
+{
+}
+
+static void
 fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 			struct nvme_fc_remote_port *remoteport,
 			void *hw_queue_handle,
@@ -874,6 +970,7 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
 
+	flush_work(&tport->ls_work);
 	fcloop_nport_put(tport->nport);
 }
 
@@ -891,6 +988,7 @@ static struct nvme_fc_port_template fctemplate = {
 	.fcp_io			= fcloop_fcp_req,
 	.ls_abort		= fcloop_h2t_ls_abort,
 	.fcp_abort		= fcloop_fcp_abort,
+	.xmt_ls_rsp		= fcloop_t2h_xmt_ls_rsp,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
@@ -909,6 +1007,9 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.fcp_abort		= fcloop_tgt_fcp_abort,
 	.fcp_req_release	= fcloop_fcp_req_release,
 	.discovery_event	= fcloop_tgt_discovery_evt,
+	.ls_req			= fcloop_t2h_ls_req,
+	.ls_abort		= fcloop_t2h_ls_abort,
+	.host_release		= fcloop_t2h_host_release,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
@@ -917,6 +1018,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.target_features	= 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
+	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
 static ssize_t
@@ -1266,6 +1368,9 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	spin_lock_init(&tport->lock);
+	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
+	INIT_LIST_HEAD(&tport->ls_list);
 
 	return count;
 }
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
