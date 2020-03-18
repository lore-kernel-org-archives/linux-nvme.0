Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A37C4332B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1440820752
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 21:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJ3/u7FA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP8aRORd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1440820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zKJ5bewWXRDmuhfwDRurfI/Ke6r1cOR26DdLMxxjsPw=; b=AJ3
	/u7FAIikDgxJm81T0TMPI0hPSwBhy3SKf9271WgSVb1/qCub+9tB44/TRpA23cTY8R7BnPvQ+jjyE
	mr2IUl3k42X9dsl3f99A1IcSdSydU0ZufC32KdFbgEeJHBJBC97+sv0q9JIch/f5uyvbYyX9ijqrz
	MnZlpT/d2pQaVyqv66Gl9dIH5loKWKN9iGcK2nxbA7Go5Yt2l+OKdsprxhVI9CXHPVyTDDDC87OkD
	vD7z89QHixlJxufS/XKdkCzR652nl1Po8ODujwITDQxfMktLjv9AZAVbNgxORiDsbV69pBJs/QHD6
	8HGW1H7Z8nCa4U5Z87oLNmykD9aOrZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEgRI-0002YH-5y; Wed, 18 Mar 2020 21:41:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEgRF-0002XJ-8B
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 21:41:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id v11so288740wrm.9
 for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2020 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=svaBa+2qy2xUm5Zo6EIp6m5XVnp6d6f/tr6lHnhCp2c=;
 b=vP8aRORdHjiE+aERahSeO1GB5G5P2MbyBxBMaXteanunenZSDVSoAk2OXY45DoE0Z2
 CCKfd1wVGWJpWthpMaxxib6tgpLLWY25bpSvdXCn3GPD74oYC6H+XERkPwHCNe4pR5kf
 AcKvH14VzLF9uJEKHfG80HqI4oAOq29liLPajn4+hVMWNZRRcbFzNlubyXJTs4V/Bmx4
 KI1F+Ug7foYKaOKKUWtLUiZDsEyp/mrXtA1oc7ggJ3xxOG5aWUHJb1xqzm+/PSYJKHak
 r1R9K02SllCwqE+VqBCg36aZDfvNyFy4pK7bm7RqBB8TtYDPOUxIUnZREvMV9SCxJY1a
 hcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=svaBa+2qy2xUm5Zo6EIp6m5XVnp6d6f/tr6lHnhCp2c=;
 b=b80eFYZyBOtcv8Y4VuxxM+0SxofOISrn8yGmsdDQVwyjUuKhd986njiEIP//q0ieHs
 O59xmbG8fDdi0NQw7Urdrx7600ufWDujtaR/OG1rqJi/oNA+k2GtLsZUpF1IRhWJJZxD
 fJSeZT9QvM7z6XN4LPcKtGWCrS0vj73Y/jUrsC2V1W6+wwjdD1kf+Wg3cs3hQv5NaqeT
 e8TPNge5FGmUR5HaCn7+AGWPymDBCUwTrAWEvA/4oAxGaref4JaTtVZ6GwpRA8kwB6v0
 YMQvjCwcFW5qhC5GcRHZENRwp+pozS+oKAWFLa0d4XvgUCTDEaFP6vwjK5zv1ZLXccUl
 DaBw==
X-Gm-Message-State: ANhLgQ1IYWLlpEeMZ/DC80sJ1zGsXGWZQmd7P+bQ6bUk/aoXeTzNm41A
 FzrGZUMs1rnHruAJryJhxjJ135sn
X-Google-Smtp-Source: ADFU+vud+NrOuseZPr4vj9dAxhUvCVbmLQyCdye/ifFAEVPaUiTdPB15oon2/m9tkPNvOOwhV6oLPQ==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr6336400wrn.293.1584567679242; 
 Wed, 18 Mar 2020 14:41:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id d21sm196317wrb.51.2020.03.18.14.41.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2020 14:41:18 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fcloop: Fix deallocation of working context
Date: Wed, 18 Mar 2020 14:41:12 -0700
Message-Id: <20200318214112.18317-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_144121_293880_4A9D6E7D 
X-CRM114-Status: GOOD (  14.44  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There's been a longstanding bug of LS completions which freed ls
op's, particularly the disconnect LS, while executing on a work
context that is in the memory being free. Not a good thing to do.

Rework LS handling to make callbacks in the rport context
rather than the ls_request context.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 76 ++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1c50af6219f3..9861fcea39f6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -198,10 +198,13 @@ struct fcloop_lport_priv {
 };
 
 struct fcloop_rport {
-	struct nvme_fc_remote_port *remoteport;
-	struct nvmet_fc_target_port *targetport;
-	struct fcloop_nport *nport;
-	struct fcloop_lport *lport;
+	struct nvme_fc_remote_port	*remoteport;
+	struct nvmet_fc_target_port	*targetport;
+	struct fcloop_nport		*nport;
+	struct fcloop_lport		*lport;
+	spinlock_t			lock;
+	struct list_head		ls_list;
+	struct work_struct		ls_work;
 };
 
 struct fcloop_tport {
@@ -224,11 +227,10 @@ struct fcloop_nport {
 };
 
 struct fcloop_lsreq {
-	struct fcloop_tport		*tport;
 	struct nvmefc_ls_req		*lsreq;
-	struct work_struct		work;
 	struct nvmefc_tgt_ls_req	tgt_ls_req;
 	int				status;
+	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };
 
 struct fcloop_rscn {
@@ -292,21 +294,32 @@ fcloop_delete_queue(struct nvme_fc_local_port *localport,
 {
 }
 
-
-/*
- * Transmit of LS RSP done (e.g. buffers all set). call back up
- * initiator "done" flows.
- */
 static void
-fcloop_tgt_lsrqst_done_work(struct work_struct *work)
+fcloop_rport_lsrqst_work(struct work_struct *work)
 {
-	struct fcloop_lsreq *tls_req =
-		container_of(work, struct fcloop_lsreq, work);
-	struct fcloop_tport *tport = tls_req->tport;
-	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+	struct fcloop_rport *rport =
+		container_of(work, struct fcloop_rport, ls_work);
+	struct fcloop_lsreq *tls_req;
 
-	if (!tport || tport->remoteport)
-		lsreq->done(lsreq, tls_req->status);
+	spin_lock(&rport->lock);
+	for (;;) {
+		tls_req = list_first_entry_or_null(&rport->ls_list,
+				struct fcloop_lsreq, ls_list);
+		if (!tls_req)
+			break;
+
+		list_del(&tls_req->ls_list);
+		spin_unlock(&rport->lock);
+
+		tls_req->lsreq->done(tls_req->lsreq, tls_req->status);
+		/*
+		 * callee may free memory containing tls_req.
+		 * do not reference lsreq after this.
+		 */
+
+		spin_lock(&rport->lock);
+	}
+	spin_unlock(&rport->lock);
 }
 
 static int
@@ -319,17 +332,18 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 	int ret = 0;
 
 	tls_req->lsreq = lsreq;
-	INIT_WORK(&tls_req->work, fcloop_tgt_lsrqst_done_work);
+	INIT_LIST_HEAD(&tls_req->ls_list);
 
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
-		tls_req->tport = NULL;
-		schedule_work(&tls_req->work);
+		spin_lock(&rport->lock);
+		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		spin_unlock(&rport->lock);
+		schedule_work(&rport->ls_work);
 		return ret;
 	}
 
 	tls_req->status = 0;
-	tls_req->tport = rport->targetport->private;
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
@@ -337,18 +351,28 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 }
 
 static int
-fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
+fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 			struct nvmefc_tgt_ls_req *tgt_lsreq)
 {
 	struct fcloop_lsreq *tls_req = tgt_ls_req_to_lsreq(tgt_lsreq);
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+	struct fcloop_tport *tport = targetport->private;
+	struct nvme_fc_remote_port *remoteport = tport->remoteport;
+	struct fcloop_rport *rport;
 
 	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
 		((lsreq->rsplen < tgt_lsreq->rsplen) ?
 				lsreq->rsplen : tgt_lsreq->rsplen));
+
 	tgt_lsreq->done(tgt_lsreq);
 
-	schedule_work(&tls_req->work);
+	if (remoteport) {
+		rport = remoteport->private;
+		spin_lock(&rport->lock);
+		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		spin_unlock(&rport->lock);
+		schedule_work(&rport->ls_work);
+	}
 
 	return 0;
 }
@@ -834,6 +858,7 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
 
+	flush_work(&rport->ls_work);
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1136,6 +1161,9 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	spin_lock_init(&rport->lock);
+	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
+	INIT_LIST_HEAD(&rport->ls_list);
 
 	return count;
 }
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
