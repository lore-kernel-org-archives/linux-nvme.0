Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8A9C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:39:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0047320674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qe0l0szM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idwu41Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0047320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VZHtq/DN6tlkIGb2dt2XHWPSTO38VnmybK2Ch/tPQJU=; b=Qe0l0szMiO57lPeoozqoFAcxl6
	oRgeDcvy/aje0JEkuJxg2sBiod6UVxW7eQjSZlKVtBQAccgzchMZjgXims/KH5zMxNn6qLSuhw/bv
	amEGDFcnvKa6NaHMcROrYCG8GXvL3Lic+c9C6IKnjr8VlFPr5Q5mxlyqpp6IuShVkuOW1wPBjZvZy
	h1EoBqhZm3G7F8gck/3j8DtoIz+Ga1FwEiFpjR2w916O/R+Y0woEal/L3rY53h4/QM2ltQgcqVC/k
	evZVgDoWznbdj0AIfTFRgfK3Q6k8CeeNWJaXsFb/QYay0MHgfMkhgiksl56YNzcCpXTQl7DcrsamY
	JAPf0Ggw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPaW-0004kn-Jk; Wed, 05 Feb 2020 18:39:48 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPYy-0003Vt-UX
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:14 +0000
Received: by mail-wr1-x442.google.com with SMTP id k11so3999658wrd.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Yp9TZooszV5F1uxWb4Cymy654qWbUKJf2z9HSpJncXA=;
 b=idwu41PqyJHmvlIo35JaC49xXG8JIrdRO9PstYG1eqY2caCIJrG4ASJYaTBiwYqABs
 i85zskb7rDz06RQHCjYVuPe05YfYQCvJLGpZrje6ndQgDgR6e2bxuCvV/2avxKm8nOUs
 ugosjsR5OWrrSF33IpA7qs27ULfm3ugjx7g8GdXylZbRy87wSCBI5EYFDVbO6i0KS4tA
 WwmctDswGjqPDBK15llypI9OYDU+FnqzhWfMn8QBG05BjoOdgDdZwbVe6f0o406mOyLu
 CNR2ige5hPJuT1o7jLuKIqPdeWD3Xp7FDG1WRf3HG8GEaXqDxfNH3hsvCGFt5iV46VkO
 3mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Yp9TZooszV5F1uxWb4Cymy654qWbUKJf2z9HSpJncXA=;
 b=K5b/tzthLmYOTJwsXYldpIv69URG2gmEX94m6nFK/xf9x8KEgLqXVOfRya5GqG/fqk
 wOnrNVyJnb8w8eBYegCF04GM0Ug61meu+P52ovUZLhSo0uvSpwMmL+teuQZBKApdPYfG
 e5YS3cXDBS4Lq6PwcnL0raO7DUX4RcgPoMFsro1i3QnR6F6g37ZuQddgpUDX8U8X9v2r
 Rpgmy7gbROGfBC3gohrpUSor6GAD6j/UlXVw/xc+M0EUPKtB+kkvdgV945Fv/Aa5rg1K
 I+pcIpmBF4qEssbkmcs3PZ5oDH60u1294I9CUqISdlVcp+TBxGwTFjskBsotcToPvtBc
 5hsQ==
X-Gm-Message-State: APjAAAXqojlGCudADQ8ShNceE0iyWwc4QHEv2SDqMaUucIDEkgt2/yJV
 xN4ImxNyNv3ti57lkQN2vEXwvYcp
X-Google-Smtp-Source: APXvYqzTHFhQ0g+osHt1g8eKielRRXRQ/xfU/4XiJUkoPoM8A7mCQIsJjp+103D3Sr/YyfyocD8mkQ==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr31931019wrm.394.1580927891438; 
 Wed, 05 Feb 2020 10:38:11 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:11 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 06/29] nvme-fcloop: Fix deallocation of working context
Date: Wed,  5 Feb 2020 10:37:30 -0800
Message-Id: <20200205183753.25959-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103813_023498_00D56F02 
X-CRM114-Status: GOOD (  15.15  )
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

There's been a longstanding bug of LS completions which freed ls
op's, particularly the disconnect LS, while executing on a work
context that is in the memory being free. Not a good thing to do.

Rework LS handling to make callbacks in the rport context
rather than the ls_request context.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/target/fcloop.c | 76 ++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 130932a5db0c..6533f4196005 100644
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
 	struct nvmefc_ls_rsp		ls_rsp;
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
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, NULL, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
@@ -337,18 +351,28 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 }
 
 static int
-fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
+fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 			struct nvmefc_ls_rsp *lsrsp)
 {
 	struct fcloop_lsreq *tls_req = ls_rsp_to_lsreq(lsrsp);
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
+	struct fcloop_tport *tport = targetport->private;
+	struct nvme_fc_remote_port *remoteport = tport->remoteport;
+	struct fcloop_rport *rport;
 
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
 		((lsreq->rsplen < lsrsp->rsplen) ?
 				lsreq->rsplen : lsrsp->rsplen));
+
 	lsrsp->done(lsrsp);
 
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
