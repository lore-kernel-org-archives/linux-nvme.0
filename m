Return-Path: <SRS0=GfOp=4X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394DC10DCE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F158C24679
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqzIJz6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F158C24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=T99VbpCnOTwahqOOy4CqJGbZU5FGciWFU1CEWen7gPU=; b=iqzIJz6QTbl/rIOmvuYIMMwKvr
	tlorFCCLf/LoZs9xIiglThuf66HL0ZBkX/MvcA5VqZAW/Vs5ThktQUjy4pBtsdoQaukfoYjPAv2bX
	YHIOtDU9iJuNLuRdMUXNXnft435g16eYDcEJKa19hvOIpLavErdh4i/Yg/GYWjS0hFkVPYjxUS3bE
	Fl1OuC6H34prNyAheiVpZeyTWmy0aV36CsvnIZ3iI9esqpzvaHom2y1d/gi/a0Te8zigXuVKnXqLl
	lt9/l+5n3YvJ//1Jih5kDIUYd6ll/tBdKyJnDh2g2NVNSGBW12nwD5K9BfdvD84/JhXrsDiPXc6Iq
	Bo0vWbSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jACfO-0001Yj-6Z; Fri, 06 Mar 2020 13:05:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jACeq-0008EN-Lk
 for linux-nvme@lists.infradead.org; Fri, 06 Mar 2020 13:04:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2FD1AAC6B;
 Fri,  6 Mar 2020 13:04:49 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme/fcloop: short-circuit LS requests if no association
 is present
Date: Fri,  6 Mar 2020 14:04:39 +0100
Message-Id: <20200306130440.16864-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200306130440.16864-1-hare@suse.de>
References: <20200306130440.16864-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_050452_874674_68671094 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If no association or targetport is present shifting LS processing
to a workqueue is a bad idea as the targetport itself is about
to be removed, and we would deadlock with targetport deletion.
So instead return an error directly and treat it as a send error,
avoiding the deadlock.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 3610b0bd12da..4f9435d9fa61 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -332,26 +332,17 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 {
 	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_rport *rport = remoteport->private;
-	int ret = 0;
+
+	if (!rport->targetport)
+		return  -ECONNREFUSED;
 
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
-	if (!rport->targetport) {
-		tls_req->status = -ECONNREFUSED;
-		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
-		spin_unlock(&rport->lock);
-		schedule_work(&rport->ls_work);
-		return ret;
-	}
-
 	tls_req->status = 0;
-	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
+	return nvmet_fc_rcv_ls_req(rport->targetport, rport,
 				  &tls_req->ls_rsp,
 				  lsreq->rqstaddr, lsreq->rqstlen);
-
-	return ret;
 }
 
 static int
@@ -415,7 +406,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 {
 	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_tport *tport = targetport->private;
-	int ret = 0;
+
+	if (!tport->remoteport)
+		return -ECONNREFUSED;
 
 	/*
 	 * hosthandle should be the dst.rport value.
@@ -425,20 +418,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
-	if (!tport->remoteport) {
-		tls_req->status = -ECONNREFUSED;
-		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
-		spin_unlock(&tport->lock);
-		schedule_work(&tport->ls_work);
-		return ret;
-	}
-
 	tls_req->status = 0;
-	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
-				 lsreq->rqstaddr, lsreq->rqstlen);
-
-	return ret;
+	return nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
+				  lsreq->rqstaddr, lsreq->rqstlen);
 }
 
 static int
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
