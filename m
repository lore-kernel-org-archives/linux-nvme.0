Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A60FD6EBF2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=38enqG43pmTPAYYhvMH3zQbkjqSAJO9ZNOr376C7APg=; b=0NVxIqzhEXYmtB/UR3tTOWzzAQ
	TPyHGknaayItucWwg5Mnm1tlZxBjmPYRmPK0wyanND+8t3Es8gbkLo2CWNWUmwGWraNJ/s1FjSJuW
	w8n/AceKUqhe+1fS49kFJlL0d+Tdk5ykQ+1bwlVINc+/1OCiuGTFT4S0drCxravx/dGVVi9nkBuwl
	cuupvhfgrsyyajReYDc9RApfbLBCJa6FDlH0pmM7kUwMy7uaN3YqCQTTWXlZ4QKNPPfsmlSUTFYV0
	lwjJtSqA5ef1yEelAtgydwclDsVXAuG2wfhQyYJcfz+C29wsKdGRaSFw4W8rIDUqNyCQ4QT5N9b64
	cmMPyaTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIh-0000000HKdi-3oM9;
	Fri, 29 Nov 2024 09:28:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIe-0000000HKc0-1hnB
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 09:28:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 06BD2A4007D;
	Fri, 29 Nov 2024 09:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2E9C4CED7;
	Fri, 29 Nov 2024 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872511;
	bh=tbD5dcEI7VBjbUSCchkwqpnKynf6J6/WxQxL5qjAEfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YjVQ4pLY298afkz41+jXgDBpuwB+S7Kkkdlhj+nslRycC0WBuiSHHzr9hxYW/Djts
	 OnTUlC14M7hSolyGk595IKGskjdtnL8Dy2QFhGJr+WjLpPU7JAa/6D0oOAfZAlRJdr
	 5HJnrVvVTgZOzVGVYm69PhJBdpj97sL8d/payYO1PHrc3LxJB+7sVI508FdjTzqiD0
	 0QQlwx/uaCxvDvOHj/be/HWo2AbRmK7ge2Y86bkx/CMNV9blSpvMVAZAa0XfkJ0YJL
	 3D/tp+68hVriPMHC4FVO6DzaywCdhvvyxNlP3gd5ArBhF3Dyg1S/TgJcBaz/hVJCNk
	 kRsscMJLKl0/A==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:23 +0100
Subject: [PATCH v3 1/3] nvme-fc: go straight to connecting state when
 initializing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-1-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_012832_516211_56E15208 
X-CRM114-Status: GOOD (  12.40  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


