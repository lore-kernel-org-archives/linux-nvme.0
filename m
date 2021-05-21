Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92774C47078
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 14:48:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F32361244
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 14:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F32361244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Cyy+TguSq8syUNW+l2+Xcnb5tru6ncSVoDLBUDxB9sY=; b=EKS2mLnSA3Zk0douE54iGty1Fi
	PeJUT+yIms0PysG27F4Uaa1Tap3ARajwF+U0tPAJVUqsKeTXQVcSV7EgXaxIB8OyciRqmNgNHj86r
	07DpwwChDY2Mv81zGjwmS2nWYEP6HSfB+89MuJ8TqoL/jQ0w7huySDWXVT0wxV6/pGlWAvWaUVJrK
	YTYTPp4/aR2hrJwm87pwbCAJ/973mQRqKVqfeS8PFkAYP3CJlNZGU6ubzmf3xi70rUGNRTsLcVF/f
	Vo1Y1sGrYp5IxdvONFzvrd8FQt+cRy2IW67uIc7bQ/2zVbjO6lv97Se7Jn5fuozmBYKoFKmkczx0c
	68GUwR2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk6RS-005oxH-4B; Fri, 21 May 2021 14:47:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk6RE-005ovk-OL
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 14:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=7USNjf2Ns//LZri0H+DuisbSg6YWoeNKnKynPBXMbp0=; b=MRzvt6ESAfPMtBgMwpD1HM8f2U
 9vEWYkzPfxwcM8Ap66JGl3KuO2F39xV7qPkLdTW8BobY5Hh005w6ZMCVwTqnuYsN8o4ITWfiflwO6
 txKd0D58oGOzimB6TDpFJDFgcrlckyiDovh2VzicsBv5+xk7smII9dbSWWAfZSCrFhFoXq+GqoUQA
 cLMv1mktHykfrIiIWLyTWua1cirg8RYApMipu1mZ+3v7M9mzwu65BmZ5PXnAhHjja9GV2eyVSTNVE
 BnNSVCxONzlfRlGk2i1c0D9dbsAlDbq/kDhMzNT4PJ2vKFAs+0kjihWiHJgzoKtgAoecOn7ZqxpYy
 gNEV46Nw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk6RC-00HCgQ-9w
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 14:47:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 88E05AC11;
 Fri, 21 May 2021 14:47:38 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Date: Fri, 21 May 2021 16:47:34 +0200
Message-Id: <20210521144734.90044-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_074742_505338_65D11B30 
X-CRM114-Status: UNSURE (   9.90  )
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

NVMe 1.4 states that MNAN might be zero, in which case we should
evaluate NN to get the number of supported namespaces.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e7441ccaa8db..32457c77c9ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2905,6 +2905,8 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
+	if (!ctrl->max_namespaces)
+		ctrl->max_namespaces = le32_to_cpu(id->nn);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
 	if (id->rtd3e) {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
