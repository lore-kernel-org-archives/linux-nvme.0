Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8282D3A67C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+58JmWoCYZuNru4s9bDP5aysSA6OxktP2w4NT9v2aZE=; b=ff1PQCioKgY5kkQzH98gKzeF1J
	7aatDQI/hBK/3J5ajLU5MFdEEJFK6MEWAHsv1rGfe8Ewm1s4oxeZ/Xc/UEyqDnho5v1YxDhGBqfDU
	aUAffulW2nDBiubJ0h77FMzaUo/Ofjd7MrXZMrxY3K3Ab9W3FY6FWPsCGJOPnsj1M75bnx1wuugvf
	DLiBkCZ1lYXr6T+4X/uh+qRzX1e9GXMD1ws/CK51u1sauqR5Z467XYk27duA4pw2hznTGbReRrxDw
	Dlq4nMORMf0cmX8xoS9sCj78aU4NernnF4/xN57wgOkapn86IrFwB0vGzW0QYy80dwLIJwggyyVQW
	Y3MWduVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8g-0000000FVcO-3fKG;
	Tue, 29 Oct 2024 18:40:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r8d-0000000FVaH-1XRw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 18:40:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 87033A431FD;
	Tue, 29 Oct 2024 18:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8EDC4CEEC;
	Tue, 29 Oct 2024 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227217;
	bh=VDZ0GWvuIDKmyjXw4HNBrgCTRGRRu8R8QLoqZy/Abbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hVTiQCo54748IXplr9fghSmm3UtWEbpWWa7I/JNYnKmqYvJZ9+WXdXG8Q+sQGMGpb
	 S3Ai73vp5dxIdtgGjH6XA4sj2R+S0IbwKZWdvO/+NPRXrnikgtbgBO4+gdIBRj5HnG
	 hQfkoyO/XB/rCrzCDvXZ0vZsLqdRRGxfZR6k/huHptj9AFNrtroLSmGMzjgjZeTKys
	 rsB3eH1YBImyunPOMxVQ7L7reg9FQtRSzZkKLih3JbrTrqb9gVyolXfTp2KJhl4W6U
	 JX7CnvnzHrM3KEVZj8496xjpmEIbrjxJlqNtZ3USCwd0t4PgJPiv4T4Nq7pZibSe7Z
	 xtZwc7b3sm5JQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 29 Oct 2024 19:40:11 +0100
Subject: [PATCH v2 1/2] nvme-fc: go straight to connecting state when
 initializing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-nvme-fc-handle-com-lost-v2-1-5b0d137e2a0a@kernel.org>
References: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
In-Reply-To: <20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_114019_503655_AC362F01 
X-CRM114-Status: GOOD (  11.89  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c421387033bf8361a9cf8a867486..d45ab530ff9b7bd03bc311474278fc840f8786d5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3579,8 +3579,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;

-- 
2.47.0


