Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E99C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+6a8bh06T2ZW6o4DavndJxaYKifsOO9pkOr/PbnoDg=; b=q26WlGbYXkk/+8e4Q6BAsjajyK
	O6SQKrNHC1aAD9wyeeC0nJVVFDNwtOwxdJt+PE+Gq6bWL+2lOWpcL9EULGu+k4AD4Ul+9uu3LV78o
	nL85Bhw7IyoabUDbVftEEOOgOXHcuoSjTqxlJhKtlgX5tkndzS7r9W5hov/Q363ozw5zxGcumvrSf
	3Ncjup4jhMSYxfy4ZlGxSMlOmiRyaqozfjwEctqExLwtWgcaO054m0faLh/WgFsdlGN/y6hJRwpLV
	Y4tf88bumaiUsLSMiNRAKXdaEwryfiq93zGD0WPSwV+LNMzr8TlT/tQF05mvsEhaDpAGMM6M9wzFb
	GQ9i8AkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRa-0000000BtFq-1Pc6;
	Wed, 07 Feb 2024 21:26:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRN-0000000Bt6X-2CRH
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 71B27CE1B18;
	Wed,  7 Feb 2024 21:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54769C433F1;
	Wed,  7 Feb 2024 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341202;
	bh=zy0ANpmuI8RzlXDoNndPcX+tAIMjD+XJSRfIIm7dqtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0NxyJCWll3krfD6XL5RUClVYwOSRGrejIi1zM1r9e7GxQ/pDcFUw3hrESJJPVm+E
	 OAnWPzky7v4KM48YVTQ3jlipbCCEFGbv48m/0zGtyvfSN28ff22ag/6IRYhTXu4SB6
	 T2CRcluixvbSO5iXCp32vD1OXo29LzIhwyZ/mUAkKlM5RbsYJ4pVgZu2WpWVLB5L5A
	 K4Vu2Blx1aCMY8MNbZZJQB7eufFT1VkuM97E6nWWuXsXN8PJzzIDpsskmZbYTmp63w
	 gSfFmfZRNv8HJ0PuvUIDJdUvqNobQPeKpeZqPhqF4pi141Ba+IfM/1fRMg0P9MVcyq
	 p3HWFWdYLQMgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 16/23] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:25:57 -0500
Message-ID: <20240207212611.3793-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132645_995259_A02C48C6 
X-CRM114-Status: GOOD (  10.76  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit c691e6d7e13dab81ac8c7489c83b5dea972522a5 ]

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 00a2a591f5c1..80df50ed7e3a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -359,7 +359,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,6 +372,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


