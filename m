Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A0C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 21:58:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769AB61468
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 21:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769AB61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WOaMN0+5gMAt9Xcvolh1gyHqIV28TClPe8z0kusOYXs=; b=JEuIsrtQ4KLhtXK66ov9fBe7F
	ifQ/DRTKwfgdINnNhVg8oKdfNhAdAUNtCTzmEvllSUmUkTi2ijTFHeyXp0LIg0PoIYX3TFZltNBQ3
	9aTQDrOaGzuNrG4Tvqx9j2QRyyZDrBpmdwmIMHaAMbp01/E+VffABwe0f7nvbrBSb2APRqhNsY0j5
	NZYMu/2IqfP8AC197GztOWG5wz+AjQhB2n4zfv1BNIZ1vTAY+1SnGL5OeA+6x7Du06n1aaLsy4VgE
	jQEB8TwCbz7s7IJz6jhVx8X/vLD3s2BHbfEgnvCueFgT2UxXKF6fEinqxi8+yL2OoFXihbLx9npFP
	Ns0r+Gaqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3ob-002STl-BC; Fri, 23 Apr 2021 21:58:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3oP-002SSu-1m
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 21:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pahAdOjdUL3ScA5zd/wBJkufnTMDNa/OutEb9oezVGc=; b=gTiwt73/xBdJfSDa3QUEtSXsD7
 DEVVmw4JBWr6MGZllX3ulP7p4JIsuXQ4DIjGTT31u436IbTJC8wXce1DGq1LkDeW7bsjvkRVcgbQ/
 YBkul3Wafxtkok7soRDgm67SmW2/f7rRdI/K4Sd2LVExn5Fu0r11N+OM/IhtZn/Z0i/v5Hmhq8uFN
 VXrpNe511ODVc0LhLnMv9Jo4Aq7MwAd/U+iKLRBWLkz8Z5NrQ6527x6nlp6K0pe25wts7ZFxc7dKC
 pD7CEhCbIH3ZMCnG9RofwU4FRcVpbK5nhq80v+hHru3lVLBx017mP0DpfCBOVzomYJEj/RVaO06xT
 noqv2w2Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3oM-00Eiry-Ip
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 21:58:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85EC361467;
 Fri, 23 Apr 2021 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215084;
 bh=4BwAoZYuq6EaqLBmiYSzglPsq0jkn4ZTw3NCgs2hImE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gw+Iyl49gnWv7NDa8Hlu281dehcjpVddZq8mJuY1nw+SiRFJ8krW9hxo29qLCFPxh
 /b90LVeNyS+CscnUYj7G8oBXptJd9b9/XsHCw69Yyio5gAxkf8bTd+TNoyD77z5oXE
 DT+mdnqSgX57T6OAyfpCJT/enRJCSQRHEWoOtmgQWoPoO9pG0Tq1lQDgxumxr+aaPP
 08VW5qTnLe5kRFuqaBFBd887CI2GtcIyp4skFTrOZoMnm6HqA95AOkFAqiBzbrLoHG
 VqNR2e5axSy282+FWnP0ORfQDKrTSEbCg0wfElLEysHxOZloRxjaJidvlTZsYnO7Hz
 qqks98E8yyiwQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Date: Fri, 23 Apr 2021 14:58:00 -0700
Message-Id: <20210423215800.40648-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_145806_660889_BE95E1FA 
X-CRM114-Status: GOOD (  10.97  )
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

We don't have an nvme status to report if the driver's .queue_rq()
returns an error without dispatching the requested nvme command. Use the
return value from blk_execute_rq() so the caller may know their command
was not successful.

Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85538c38aae9..b57157106cac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1000,12 +1000,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (poll)
 		nvme_execute_rq_polled(req->q, NULL, req, at_head);
 	else
-		blk_execute_rq(NULL, req, at_head);
+		ret = blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
-	else
+	else if (nvme_req(req)->status)
 		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
