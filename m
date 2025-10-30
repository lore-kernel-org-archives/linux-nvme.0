Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B2BCCF9F1
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Ot4EhNG4xYFbiOhMElW7NvbRuTDTQoNwoY7E5oWoH0=; b=3/kSlowmt3VMlmX6u+uluW/kyy
	QXZgOyx5z/rt1JI0NwK2QqMYho9VxirQd+GYAqupadKKbbFVeTJOpk4F75vi4UKSFCNOqX1WmB6qN
	yZGZFTJcUQOUwvHvZiwYx/d/C/W2NI7nVJmgD6aLpfT2W8rhYt835glxKwZUKmX2BoNkqMkOv03m1
	QUE+/vvcLruuGqER5KqyJb8yHW/NRk2C4wFdWXb2UwLpMujeDowgOnQpjt5SptmJ8QJWfNndK+I8f
	+OKIsVK+Rn3Wybauo6Rpw5KuAofq6Ez26C01zFKMI+19SK/OnHQdWKhaeYdAwIAh2dpDRugDFkth0
	w/Lce2pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXa-00000003wB5-1S0Y;
	Thu, 30 Oct 2025 10:05:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXY-00000003w9s-0o5K
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:05:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D4F3144F41;
	Thu, 30 Oct 2025 10:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56797C4CEFD;
	Thu, 30 Oct 2025 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818755;
	bh=pD88QTQwhCsd1dD9Fb+TDQoClhSOHeNyLN7H0zQpYAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uNgKP3CL1kYsUxeqYTrEnq8RP3483/KZhRisETibvx1WZM1//MV+Q6vTCRpDsjsw3
	 A7LfthB4qyHNZ3WQrux/XIqPxSqz32rNzgt+yukr9r3/rWMiVA39XitblrgFtHaULm
	 wXnjTAxb4/kX7kW0/7H4T/ogGMIAfmnKKp9CrRRNxiVlrWhQJR3SsMHPhvYbFG9IkB
	 VJt5MRaTMlcPfKRZJKfPsLEJv4E8TnhT+bihoBJfF94CwQMap316KxEhWbo6+I2rSJ
	 vdhJ39nKBVQa2lqmnVFDv3a5ipuDXZtMtjl/psErTlzgp5r0ZqT7eqrY3hiF5JcNTN
	 XrE9QuOxMYqhA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:46 +0100
Subject: [PATCH v2 2/5] nvme-fc: check all request and response have been
 processed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-2-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_030556_261936_12EDF6CA 
X-CRM114-Status: GOOD (  11.00  )
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

When the rport is removed there shouldn't be any in flight request or
responses.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3ff70e6e8131..b613fc5966a7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -520,6 +520,8 @@ nvme_fc_free_rport(struct kref *ref)
 
 	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
 	WARN_ON(!list_empty(&rport->ctrl_list));
+	WARN_ON(!list_empty(&rport->ls_req_list));
+	WARN_ON(!list_empty(&rport->ls_rcv_list));
 
 	/* remove from lport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);

-- 
2.51.1


