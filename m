Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926D7C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONUCVK3+mbkvG0HIu1N8LLhPqGU/L5cixp2+P8iV58g=; b=NR8hwc21CvutLUfTKr5Lh3Cwav
	ceU5ygXf+AdfrYc47I88/ahs4KKe6YqqPymyfh8K8O20VgX7uiG4PfXrF7FQonrvIyWGP1JjP1RN4
	bY/gMO3bMYK8/vPR5BlZVMPM4I5oe/dIa4fdsVw2MGoFCAhYvmu7Ym3BG4pw/sBxhMjbGOSbfkjQD
	T1j00Kp+wlRUAcjfDEesGyKpUwsCscyssa+Q4b1I2Xhrd9PB4ol52w2NfUf2BwAeJBz1XX0uJtPB7
	Pu/NUW5+C5K2sJI6ll89sxZ0PpPXuIRPTnKMlfJXlw3Thwv1/XouxN8WIRxm+pchwnvBBiJtZIX3S
	A1yInBMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqS6-0000000C6x4-34lb;
	Wed, 07 Feb 2024 22:31:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQZ-0000000BsWu-1Shj
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ONUCVK3+mbkvG0HIu1N8LLhPqGU/L5cixp2+P8iV58g=; b=d7S0LIZah5deolW9Y5GXX4RjXv
	k1bHzNTYQDtDjUocomzxosWL4GOoJUne8ogXUqR7ofiZyvyNVM24bzPSaXItFW3voM9dPwWi8CXgp
	CQC5UZ/r+eKxxiTBCiRfJ7gPc2surETLQw4bM3OyvCC1rZWGYmJAGPERe6ROvHkyXet7bxR/TnH78
	PdqTlTJvvF4ifGAlvKgfNuBZG7k2Lay1My3Gi6rHoWREW82+zEdF2MXOdX2iurI7ytOVoXQrBBcQ0
	89ei3zhcW/a/Y5LXn69XA5r3jGrvNtt63r+ghXLCDaDpGOr35PF4XlqlYgg1hQT2BvlTRfxz27FEd
	pTPhezxw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQU-0000000G8G1-1JIA
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:25:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E031961AAF;
	Wed,  7 Feb 2024 21:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381E5C433A6;
	Wed,  7 Feb 2024 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341149;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrFlKDznJBcBO5p+vOlYqGSeJe+7m+5AfP1lg/y4CT+lL7l1Rn5E+ji3BrQf5yeUF
	 JoN11+s2538Onuh91+ceT8FXoKn4fNXrIl20Uap4SdsTnx4vKcV0Un9QGM99MdhgFJ
	 wN0sbrfmoCBELYPblUFXdYBBNtNqWa1+CJa1uZo+M6KBAPufhvnNWFjyn7d8MLdQHR
	 fZ/uUKjX2e+PNTlkuBdKdWFBwsl/SopiFZM2L5zp0TzhJAm2O/43Sj5qGoeIKJS8nK
	 DlOqxah76MNsPj6jxW3Jr3Ecb1cnL+ieys/yfOQE4A8jW54f3KMLVG2HWEt0sGUSb1
	 aJL0+Z2yXPaJg==
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
Subject: [PATCH AUTOSEL 6.1 21/29] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:24:46 -0500
Message-ID: <20240207212505.3169-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212552_229433_FA5B0123 
X-CRM114-Status: GOOD (  10.00  )
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
index 1ab6601fdd5c..0075d9636b06 100644
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


