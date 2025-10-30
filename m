Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29619CCF9F1
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhZPCNfZB9KK21qOv4I9BzuGdM8SSsyZnesnt8CfTOU=; b=LPotcnAiORRqGXxFh6NAxXfUDu
	d26q4vNPYyLs+It2tX0eUnUmyw3YjNC+KvvYij2DQzthvjaND2BEWzZIBRlzjYdKcNNT6yvgxfnl4
	nP6SqfqF7/mVl5gYaKxur1SnrkekGrYjm0v7SrrsE52LXJU2kyL6y0zxsljOqSGyEJysmoYZBklyR
	0iFoybqilzJ/DXWxOUOaAxlXcne0qXeYrDsG47MEM1idz/pG573xJVjNDH1pKFC/gDSPRIAW66VF9
	tyu6jU/R6fvRPQjz8c1MsyiXr1e0TvpUrAg55Nq6OEvin9gBgKo0YaWCx60WWVbmj8/ZVL2YAb7Ru
	AgSHjYjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXf-00000003wEY-2xyA;
	Thu, 30 Oct 2025 10:06:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEPXd-00000003wDM-3bns
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 10:06:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FC234176E;
	Thu, 30 Oct 2025 10:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1DC4CEFD;
	Thu, 30 Oct 2025 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818761;
	bh=doY/mfIsT8gI0lwCrmexGQlzegsJ2i3cFbb9dDqKg0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n9rDgGzoysc8xjHoSAmwuG+VKalr9clgrOp8DxfJG+sU3nYQEwAvnckx9Hcx1M2wR
	 L/wXyJEPq1YJTVOlqT/aFr8B3a39fawhcSqp3TxUSEl5gcKkTQoaniOofzfkYOI4u3
	 LuAVL6V7gmw9wkhs7JsJVR02/UForRV0xWHvoGqYTB4p5cnUCrFGFqiMybyz11ZGx2
	 Ii+PG8jXT74KObmsSyMPQkjA4zXKB9nVgMBbz+nOGdsAuSheqk7mvq58ZaMZeF4eMb
	 ZdT5rhfpC3OwSIKkjE/WsipxgPuYU2YU09TUGk4r2XLHOomQmHx8K7ziR2GWKfahc6
	 GkR6F2spHHyjA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:48 +0100
Subject: [PATCH v2 4/5] nvmet-fcloop: remove unused lsdir member.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-4-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_030601_926667_FFFB736B 
X-CRM114-Status: GOOD (  11.55  )
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

Nothing is using lsdir member in struct fcloop_lsreq.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 4e429a1ea2bd..c30e9a3e014f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -254,7 +254,6 @@ struct fcloop_nport {
 struct fcloop_lsreq {
 	struct nvmefc_ls_req		*lsreq;
 	struct nvmefc_ls_rsp		ls_rsp;
-	int				lsdir;	/* H2T or T2H */
 	int				status;
 	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };

-- 
2.51.1


