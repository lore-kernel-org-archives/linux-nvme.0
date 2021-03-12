Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFCC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 19:56:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B5164F80
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 19:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B5164F80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=azpv/tQLbimDGniSUxixmwZ7uPl3BWu1AVO4WV8tMjs=; b=je6M/2LtwSUuf6qQkzTHBskUat
	/6Gf2cEF4o6nSxdbeM9JULd/83eoH4nbTTyZIrtlm26k8O9mKQkKxN/l5spRZoACbBrAGuqOKEOnO
	iiP/3IC0kcgHoAPaoNhFmwBTFfsohxj4rsK2uok88ck0Z93lEnxUtpl9Uz3BgPR+JgrHZH1BYwYhA
	5mF7opbIzUY2hRI9nLD8+9h6/W25jffMV0Yum2fYpZ20x/dTwKDGb7Vaiab0znS5RnE+wabB2TsfW
	LkKJNhBD0YP8yzimqlOYrOICdSKpP+9B2/MrL6RbK73nne7TflenlVnnr4NFGWgAhUz/hBOqIAmc/
	/Ixeet+g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKnt4-00CItw-MY; Fri, 12 Mar 2021 19:55:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKnt0-00CItm-QW
 for linux-nvme@desiato.infradead.org; Fri, 12 Mar 2021 19:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=XJy8tniuny0qL1g4BdNJcH/8gXaSR+aiU4UZ2LShjng=; b=mOIWaZFxJNZ/do8X+r5w41Q4e6
 S9RwQ2+HsEHkuyR16OzsMVQtMJsxoWRlY5oOoZFzzDwhEFPYul5yD7UOUU7Xaubi2KBq+BbEfOJUw
 J+Cqp/Csg+MrEqTf6M8RQv3JOre7Zg3aoCAX96ooIyITbQwpgknVPqw+ezuvzBTW0W7FrBVrATs02
 5LNnPKVqDTmRrBA7wx1lddGLk0Si8rqNvPnFFicZoqb6n91HKrEkB4LcInZF3xwVoDVlszcz9lpUC
 YXNlpWLWSq36Bg/CckKIyTl0q4A+05l+vGvW2CBdx2UfNUgXh1GDGiMOMbdskIAcOPzgYHC5Y1JjW
 ixPNy5lA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lKnsn-00BbI7-DI; Fri, 12 Mar 2021 19:55:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: kbusch@kernel.org, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns
Date: Fri, 12 Mar 2021 20:55:36 +0100
Message-Id: <20210312195536.1432823-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

ns can be NULL at this point, and my move of the check from
the original patch by Chaitanya broke this.

Fixes: 0ec84df4953b ("nvme-core: check ctrl css before setting up zns")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82ad5eef9d0c30..a5653892d77392 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4099,7 +4099,7 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (!nvme_multi_css(ctrl)) {
 			dev_warn(ctrl->device,
 				"command set not reported for nsid: %d\n",
-				ns->head->ns_id);
+				nsid);
 			break;
 		}
 		nvme_alloc_ns(ctrl, nsid, &ids);
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
