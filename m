Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD727C4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 15:42:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673F860F01
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 15:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 673F860F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ypDs5bsgzFMe5HZB2Ej7mFCpACdJe8m+SgMYmP4E/n0=; b=IhmY9T3p1XAG9Q
	X4CICgqWMAlXSwQtMMyntgqCvP5nnps7x5lbafa15YJLHhGonF6/zRL76lcPOvm/KeVWrFnJ03vQQ
	XsG2sWi9uiXg/6m0/5ldLGyt6kT5bEikM1PgKSwdHoXnaqep19dkBo4lWUhh+pRN3vmAETMWG2JFx
	h9Jzi5aKIGxuGmnblUKBh3ioVmOLmDtgjLks7iXiiLUEKV9vf6Q81zsrmMwuO/DRgn1otkq9vK9C3
	0isdzJuSvBv/fiSzpb5iftdKX1PZrFHMe1VtNN6v5zNI/guEryBqMeai8lFbXhlUyREn4qJgtcT/O
	RhZCgTKN/fFSuiBQiORw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC1zB-00CsyI-3h; Fri, 06 Aug 2021 15:42:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC1yj-00Csy0-RR
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 15:41:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B1C61165;
 Fri,  6 Aug 2021 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628264505;
 bh=1qKwvbcYXlB+fxJ6fPoWdo/1bUH37C++aLUZAu2kYZY=;
 h=From:To:Cc:Subject:Date:From;
 b=f5KifKovvMzV34paKTsZCgcq/Vpur0+pTug+a3V/CQsMxv4GgaDxh5Rqluxr/qnSs
 kPh+DWfamGTJrtZ0PVS+et3TbzvWivIOEckSLTxsocV9p98BQwnt1TUbdggRczoOkd
 wjdg4DNPNfyMtlxYgjo4h/uhX7za+46Llp+N4WpmPE/DMoGfZyA5dWWKhDGqm9mSzR
 KovwUnVYQ2MRQhPAYkmq2Wos1NDKdN4wwL8vmMWMtGVRdk+7JrOtd7nLqvxb0SYcJk
 tw+mve3uNmmQy0KdIsuq/MMD/mCREl16r3s+2RozEIY+1NrgjlY/UBXOM6X8cm6+mo
 jwhVyepG9V72w==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme/tcp: pair send_mutex init with destroy
Date: Fri,  6 Aug 2021 08:41:43 -0700
Message-Id: <20210806154143.2576327-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_084145_940453_E4DFEFBD 
X-CRM114-Status: UNSURE (   7.45  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Each mutex_init() should have a corresponding mutex_destroy().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8cb15ee5b249..b7a5e5e289dc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1228,6 +1228,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 
 	sock_release(queue->sock);
 	kfree(queue->pdu);
+	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
 }
 
@@ -1533,6 +1534,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	sock_release(queue->sock);
 	queue->sock = NULL;
 err_destroy_mutex:
+	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
