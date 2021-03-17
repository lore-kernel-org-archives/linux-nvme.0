Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BAC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:02:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139AA64F8F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139AA64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9cveeTy6hPUIVJFzIce/bF67AYIdoz29IX4d/JxWJeA=; b=O5QytU9jOQLedYd4ox/BprKIH
	1wTGRL3GHItoZOUeszk99NYliJMtDApNfUGJcrIRA06tnzmM4HmHhFAPl9aqGNeESZW6nM7yfhgmZ
	EDb5JmjlR4Lm8gkuarI3R3ab5cx/e/RB8S/EIEHG7RbWeJ+y4CihblIQKxtskkP7oSbay4dvl2aPZ
	knZjmPpC5h/IrZ0ZVKwDoO9ElE3Okk9BOi0Cn8OkWTduBWvtaDCmmA0USg/w0oWQRBT5jpdW4shEF
	+5OkWZJZVs2gB/o8zlpCHEawt0n7QvBdGNzXGeaqKvnE8GlBw+oI8ZbAnBzufzLDqsOHc36V3Tv+8
	pU4kGELUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKZZ-0028kg-SE; Wed, 17 Mar 2021 01:02:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKVS-0027Fh-St
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:57:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 964DF64FAB;
 Wed, 17 Mar 2021 00:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942669;
 bh=zXDvDrsI7DZqLvWUzsmNVMneCGiNA5TIvblrEDA+K/k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dT2aK8CosXSVaVSskmCptDDLhSKYoH+fG+4OB0oQ+aBrJ+CHMT05b2CuBui0Ii5p1
 4RBKT+rj1waWdNnfRbb6TUWrgaPLMg+ycdpj5ZF9vBLU33g7ztZ/OYD3mZ2lywMnMF
 qJOaTX8YG0M+zDKARtrO+GDMultMPUsff1DU68pprOvh9Togz82bYureBC6IgS9UAk
 NRmrFJPn5WPoX9+uWnqTvhuG9R+wiDWSvvFoifwzDjtaKe65pn/hg8bfom+P7WQR75
 vmtihmSeH7/PvTAppfRsnlxAruDQxlqOhOiNEKbqpoHtgd3RgOfn4iajQKx6Y8mtU9
 KDqYxrFIAkI5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 45/54] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
Date: Tue, 16 Mar 2021 20:56:44 -0400
Message-Id: <20210317005654.724862-45-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005654.724862-1-sashal@kernel.org>
References: <20210317005654.724862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005751_789968_2E0CACAD 
X-CRM114-Status: UNSURE (   9.01  )
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 3c7aafbc8d3d4d90430dfa126847a796c3e4ecfc ]

nvme_fc_terminate_exchange() is being called when exchanges are
being deleted, and as such we should be setting the NVME_REQ_CANCELLED
flag to have identical behaviour on all transports.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5ead217ac2bc..a107032da3c2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2443,6 +2443,7 @@ nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
 
+	op->nreq.flags |= NVME_REQ_CANCELLED;
 	__nvme_fc_abort_op(ctrl, op);
 	return true;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
