Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D07CCCF9EB
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UI8FEu327fYkzC/1amFOt6Ype8y6tmhx5vL97brh4z8=; b=aWZ5jLF1eemwmcF1ggfMkw+HjG
	cNhCej3vbUcpKmfz22SbgZ9lDQLMx0e70qXru2UscjEzG+JLtcVRGSuUSHZZlJsUjNB6wsYyiaswR
	pYkETZNOLyYJls7TD/yk/Gs1+4hJFw2IzsT4H5Nx9mKoFn396O0keAF56h4lrCRXi6rAzLdD+WVnB
	Myyme0JgvnFIaBdIn88vmvDpYXBAWqEVHSYkUmUjdQvls/f697uAnvrdCRWJIMhs5ontUoX8RpHFh
	5MjPuE28yjDTreY3FTGhOFlVZrpbA3UDv1WRVVlhpPOhhuiit64JlhdQSZyUW2WeX8ixhL32wLg29
	tQD+LiyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlan-0000000GAcB-27mm;
	Tue, 28 Oct 2025 15:26:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlam-0000000GAbg-182S
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E80162030;
	Tue, 28 Oct 2025 15:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B88EC4CEF7;
	Tue, 28 Oct 2025 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665195;
	bh=Ak6jGISt8Tnwrl6aQtFstbUZY6A+aNV03E07Eu6cuf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHCpIrRADrOHpz/kLnfTOZNXd5IKsPMlV2ysYBdKG6lH2z56BQECWKKKwsmbD6cA8
	 JY2fJRLbSSmYWl9XeP1Dwo/wQlrLL3/ifOUUn5rsiXFd0vGJh3FRVZxFoSMvL+A8aY
	 32fJ0npjLfR8UXFIyuTBEL4cG7H3xX1c/oCU4Ajn5MtkHbi1a4X1LvnNPT9hU2amvM
	 6s5d6R6jP70mu/7dmhGQiMb0259RH5vAjjHJReigsQfB+5GpsEEKR/z0dnXw7mmoUV
	 pzTb5xgtMouxunlc85k9p+T1H638Vc8zw+CXj2TSIhLk0N/bLL8cz1+D4sFhqKnGtJ
	 Y7pfLOtnl08Eg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:21 +0100
Subject: [PATCH 2/5] nvme-fc: check all request and response have been
 processed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-2-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2c0ea843ae57..dcb7fc2ca0b7 100644
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
2.51.0


