Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F37C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qw0neuNVOhPwvIsCgFKr/7fvBIGfm8T2zyUnoHmZuJU=; b=eBKURyhPy78thFYs9TvYM58mZI
	5aeaA6N63WdK7Q0tf3CJjln0UvrUdRm0VxP/n0fkYHzs43bcTnryBitbgJo1v/+WFJXZnyQPWK4tt
	BjOFtyhUZbPFfCl8pJ3D99QmaVWu+t8dKi377OlnHRXyhMlmJkJSHLs3nfRmRU2qLCBH3ue5Wxj3l
	X+sY2bXsuxM3t4sRz5Be+Sdj2vrvIztlvl2b9+MBwpMru9hXSeI0hryOMFYe08lNo44HrZPl8DSQM
	WCCdi9z/qGOaJnVBkK8670OrV/X+uzD8pFhvLAMODAo2TFhzTNn+d+Amh8dbgw35laQqWZPEGR7rn
	OgH7QG7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqSW-0000000C7IV-1rfw;
	Wed, 07 Feb 2024 22:32:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSD-0000000Btja-1k0h
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Qw0neuNVOhPwvIsCgFKr/7fvBIGfm8T2zyUnoHmZuJU=; b=DY4R2/qOAkEGg9+TJR9pcvni36
	GxE17FyJc4/IGuF4E+ZTFMPia0/OtGPBjVWEcgDfwO5LMsZdtJldx5Y5fyYegk/4Ljt/pVV8BTJhl
	UfLEz5dZtvs5QsgsIi+9Ol7CEe9n1ebwM4xpThKj6QcwIpSfaAXkIV9+j3NosNz+wEVwqAYq+K54x
	6R6pMbg7QpxK2dT8CC1m2G5Ul3/I8DW8gUb5/+rP7TjZTBkRbI1fT2k/dZBorX+uw9exaeEjM0CXe
	0kOBBILtLMLDY2vL9wvdG/dYtim5fvhJSTgMDm5GP1mlwpseD5ssVMKj5zwFM46byzwWKqyJoGZ0k
	JsYcMTqw==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpS2-0000000D8Io-0bkL
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:27:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B739A61AC6;
	Wed,  7 Feb 2024 21:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D00C433C7;
	Wed,  7 Feb 2024 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341243;
	bh=ovyIZPVt+cgL+kVUOYvyu7Mw0Bomuy3ojy+orvTz3Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4pwVrk9p6IbqavnMlFNKVPAE1ateAvRSN0uqzKTv3sP3D7L8Fyhj9a7Z44DyEPz0
	 /5yIZaWu1kLVVrAWSXkD6b3zwGdn30/IoWSBxsn+94ZGfEPTJJuEB+rnZqBwT3oyhy
	 u7OHovX2yTB2D46488SlPII5UrfX8uB0guuY6av2EymX3dsnOsC8Ua/MrNMWaTt/Aa
	 sgTkzkIk+5JLRhe5g5csCdygtVpE98/UFMCOoeq5xkYw5FQSG1vcI48jSotDVfRs7a
	 7iq9Kc42f98WyIIIXTwS/TKUzq4gzwglgGWcP8s7tiilBh2JdO2Ngp2Q6Qt4J5tGvG
	 rdWY+XG8zf0Fw==
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
Subject: [PATCH AUTOSEL 5.10 12/16] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:26:52 -0500
Message-ID: <20240207212700.4287-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212728_963014_697D2180 
X-CRM114-Status: GOOD (  10.71  )
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
index 46fc44ce8671..18a64a4fd8da 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -357,7 +357,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -370,6 +370,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


