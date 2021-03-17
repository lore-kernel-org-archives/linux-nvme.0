Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAF1C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:57:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7852364F9F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7852364F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Hk010yCtpTR090sPvQx/HUvDmHMy9/F7gzwRTTI/4k=; b=PXyrSo7bUcKaGq19q2bAUzNim
	hKxlzs/0U98hH7cR2/wnYB7ibgaN6/xiK6niW/EFasX198/v5PnGSP1D5CPoMP9D8LC1KaUuenwUM
	hBU0OmBQ0x4EK7+SgO1CrbUq72OaP/oVQG5pYsrZdQPuNYcpRxaTzRDYFf7ykHwHmfRdXEG3+5XzL
	HWQfD4cEhHoDuX0shMXV0psCt/fHVyrggWfQbMuuusT2vZqITdfYQNgrP8gUSXn3KkBLnIxTs2TFB
	Kz0swv7kRSdZrg5D8iKJFJzDc20c9wszc9xYv2jOs4iVNAtAtu8R3uzP1ODsShyJgu2HkRBxWnJh6
	e5ITN3uuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKUp-0026vw-Uj; Wed, 17 Mar 2021 00:57:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKUL-0026fL-3v
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:56:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C54A064FB1;
 Wed, 17 Mar 2021 00:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942599;
 bh=i7nnm8jlMD5cyaAei6bZYW7HxQe2ObppYJZxeKOl+kM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IDeR6VjZBKwrpaMFuTfX6D2DX8UEaVHhC8ic1kDXBB+xigl2XahLnAFKaJatOpJbP
 FxKLB1yBP2NixkDZ6s9Xjut42qy3jXoyi+LQGVrEqOq8Q72ADAFEF7F4YvDopfEywD
 9/uxie6PUZtVdZPJ8AMPcGyNVPo7gjVQJRjrKZQOey+HNScsoN+/n0xZfRt78R4m11
 3Yn5bAt2DulRg/F3c2NH6eHGBWjR+Yvz2jSTBjyiZS+7EMFSeAfx1c1EHAbNWkWeVD
 Ku1vxleebhOjvGxOiWcIv0oe+fi2sRISa8JMRiiKl/ijbxr6zc0NqBHe/Kcc6wqMVi
 uOb7Nmu1a5Ikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 51/61] nvme-fc: set NVME_REQ_CANCELLED in
 nvme_fc_terminate_exchange()
Date: Tue, 16 Mar 2021 20:55:25 -0400
Message-Id: <20210317005536.724046-51-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005641_614575_4AA57FF6 
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
index 5f36cfa8136c..cd2d28139d97 100644
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
