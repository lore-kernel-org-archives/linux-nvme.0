Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B0CC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:58:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60512063A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dt6TQdJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60512063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wFcp2qaZJ3jWKb2OXxiiRtQLuk8zlgvLHxghO2i6vUg=; b=dt6TQdJwlJc6bQyr8DAXbVIMd5
	lyB4d0yop0nhOzfMhZ8JhVhW+AG98v16BcfYBvd7WjVhtp3MOoNeTptMi8SdUnf+BkNdXk04/2Fjl
	9mQwSGX14OlmuN3okn3eyxhOTmncJxGr8iajLEXAvngFfUDokmW5GVtx+uImWYCqIw7/11clL+JZw
	tiTr+QaXq3jip1rIa0BFG0ZQFYTb1GzRKID7VXuNPRLRHhDwWC8C1Rv9ZzZmrZ3tk4KktRVN/RaXu
	72P5rr5KGSZGicq3OjXOoq9BiEZwq3wQxoAF0x0LiLXzyMbc8CHaNgEFKMyvN07Mdj3+v+u+SUmjm
	VtveVsHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k91wW-0002sN-Vy; Fri, 21 Aug 2020 07:58:33 +0000
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]
 helo=smtp.smtpout.orange.fr)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k91wU-0002rM-2b
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 07:58:31 +0000
Received: from localhost.localdomain ([93.22.37.159]) by mwinf5d23 with ME
 id J7yN2300H3S18rh037yPUT; Fri, 21 Aug 2020 09:58:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Aug 2020 09:58:25 +0200
X-ME-IP: 93.22.37.159
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Subject: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in
 'nvmet_fc_fod_op_done()'
Date: Fri, 21 Aug 2020 09:58:19 +0200
Message-Id: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_035830_346716_F29B0029 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
in this function.

Use 'spin_lock_irqsave()' also here, as there is no guarantee that
interruptions are disabled at that point, according to surrounding code.

Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not tested, only based on what looks logical to me according to
surrounding code
---
 drivers/nvme/target/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 55bafd56166a..e6861cc10e7d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 			return;
 		if (fcpreq->fcp_error ||
 		    fcpreq->transferred_length != fcpreq->transfer_length) {
-			spin_lock(&fod->flock);
+			spin_lock_irqsave(&fod->flock, flags);
 			fod->abort = true;
-			spin_unlock(&fod->flock);
+			spin_unlock_irqrestore(&fod->flock, flags);
 
 			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
