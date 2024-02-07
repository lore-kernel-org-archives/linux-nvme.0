Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CBEC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONUCVK3+mbkvG0HIu1N8LLhPqGU/L5cixp2+P8iV58g=; b=bKT6MiCfNw4c4jWREq7+A/ZjtW
	oKWRXB0VGfUHMBOgAOgUqtf/4HcGWVrjp/odmgW+52VC8FTnbawc3mxH/r4BLQBJok7k2ommasteW
	Rfq+YaO+LAv0OyFnELvVV9lHzgC54G32FQxnYQsJa6W6/dxxX1QSXnZQG+3zi/YvC5b5GAJNQyP+N
	xi4oXrgjtrC5XGykZrlZ/eOvU8xwQoccMrnCQer9YneHiatLPVe4uQB/FHjXhb4y9UQYxnIaKjW6g
	js6IxIHAAsGT+bIQAKyOQt5P+aldGg5SIC2PDz5GRswRfX5xGC1byHXsWIgcIj19qux8Tk0CA6mBb
	UBwF8i6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPn-0000000BrxB-3bKJ;
	Wed, 07 Feb 2024 21:25:07 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPM-0000000Brga-1wJA
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6A3BFCE149E;
	Wed,  7 Feb 2024 21:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F7AC433A6;
	Wed,  7 Feb 2024 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341077;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7B5qa5sCj6szdr8eHcGyuT3yo+dGYVqELsiCWJbMm8kAqF9+agJoU1/HdrrP3WT0
	 vWCR9ITTQ0sHvgxS0XuRTBl8i1tHMLAby96RhsXLkEW1iSFo0QIKjwBjp/Zr6ByTCJ
	 7vTC4qgyDIb9JA/nHnq45ul79m3Gvfbk0mApKkQ9nXVlkqjUEVO/hTv1L6YgI3aKoT
	 gQ9x0lXVP6k8LVvhbLY6+Xwf3KmV/W2UFIQ/IBN4DMglP4UsH1Mgo/4POfN9Cpkepx
	 DN60yQYKzMbYuy3DaDEpQPkBlW90xCPhe8eG4yzWmspQa/9f2VTkzUH1t6J4Whhjkj
	 IetJjDxygL+QA==
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
Subject: [PATCH AUTOSEL 6.6 29/38] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:23:15 -0500
Message-ID: <20240207212337.2351-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132440_992006_82DAE832 
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


