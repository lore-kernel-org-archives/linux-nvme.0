Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BBC4332B
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 11:26:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBB761A46
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 11:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBB761A46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=81fImn1rW6uQyuMaQp5itGyxbi+QyZlb+8ek6VcHHgQ=; b=hC2SQJw06MvWw3X00nMpVqcZ6
	sJz14dPDJjYH49KmPObXm/2EcrIEp8QYfh3uUOWwQhyhMtdokFbyqFUDaTzuLOwx0+1ClNGI3cnBs
	ix23OKgce1zd9/5bE2LqfKu1S0Tnjxp5VBCYLM7hLy2lWs+aMYKFASAG+83URNjHY8FGQWW/QdenN
	of3kUiJpDPBnDKroS6s0zJZctY8hYjVZb46fW78XVkTScv9T9Duw2gR6Nig9ihm47ClPX6TMZNTlF
	jrqLe+KAwQSMx9CU0Lyd/ujvUo3DXOBB9gNbhWki43XVv9EmFzDk/F4dlWifa4Xq9VffgZXoM4EEi
	rDSZTVZ8Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPO7c-001Ibk-Ay; Thu, 25 Mar 2021 11:25:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPO7X-001Iax-VF
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 11:25:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BBE861A34;
 Thu, 25 Mar 2021 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671546;
 bh=/9ujew30/khoYdl8uTOuMTpa+/+vYu2kig65Xjphl34=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KQMnqjAla4wqTSPGmJDh0Q8bjpSel62gFLJWqVj3T8ZUuErUEWYrrkJKXp2SCu77L
 0vDPCjiv5h3rO8/tbqZWeE5tsoL9fH/nstmy2omkjLcOA1OY1v/yOlyeql3CsK3jkS
 54mne8paNCM8DiS+96AVGlM9pi723NlaHveYMl+AfK/LBWllg+M0w4CBTrx+7xoiGe
 k0gipQX8vnH4xpOTMtxIwTgA8DGYoyhfoRjPX9QwLUwSgTpfolvQZ9NYYNPkn5T/nw
 YiFRBNFVxHZlBFKybhdzn8P/554aAfPpEqTGdvhtQxLYhvYdK2iVRY4iMg2XwABaa3
 TZtBdVW8b0NsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Elad Grupi <elad.grupi@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 36/44] nvmet-tcp: fix kmap leak when data digest
 in use
Date: Thu, 25 Mar 2021 07:24:51 -0400
Message-Id: <20210325112459.1926846-36-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112459.1926846-1-sashal@kernel.org>
References: <20210325112459.1926846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_112548_262610_F507F69F 
X-CRM114-Status: GOOD (  11.91  )
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

From: Elad Grupi <elad.grupi@dell.com>

[ Upstream commit bac04454ef9fada009f0572576837548b190bf94 ]

When data digest is enabled we should unmap pdu iovec before handling
the data digest pdu.

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8b0485ada315..d658c6e8263a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1098,11 +1098,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
+	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
 	}
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
