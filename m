Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A4CC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4NsIYtyGrM3LjYL6DVbpaqC31o7H4rwayYn/82x/otE=; b=zPaZIwWbzSuOiZiQwyaexVYl+O
	s2GLVjOv8WSR4rxZfUNxsIxPqlE+uzh3R+HkUVJxaQK+D7xijSmyYcWV47UPR6a/vOQUxHBehSXzm
	2UrL/ZOuDyD/BtJCvMUzQFN9qet5RG0MUUBxyk2CQ+HiK2+8D81t64BIJWuxnd908SNTLWaMIAIxn
	m3N5cU6SBVaSzG3ePGmWO/U+KkORwZ91A7JS1TcBxA++Ac6YBR+6Pzqar8F1XL5F/o/zjYyZchhPy
	HPUPnbhjO7cjra6WU3ri0SH2iYJn1jUJY3RMN0ZNyMTU4IQRR6EbxXNq+0Jf9CH9STHliK5BgnFVu
	hwB2aLAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNu-0000000Bqcd-3y8Q;
	Wed, 07 Feb 2024 21:23:10 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNq-0000000BqXu-1aFn
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:23:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B6443CE1B1B;
	Wed,  7 Feb 2024 21:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A3C43390;
	Wed,  7 Feb 2024 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340984;
	bh=4xerkgodNjm+WwzFAZ5Ls578pEsR9iJgsdOpSlK56zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6j5fbetExqQ48rkcQMFi4no3o/jdKELIJ1gyhFt2/y/ZvbpawkiH/+ny2wVkyW9B
	 YVgGaDdGfmz/RAQcHWs/SMWFRK111t8p8+ICXOZU7PCqHacHPEvkoz6XsjvRycd7Z/
	 fSIMCX+s4khSNcohJQjyBcCc38YCq47+JGOgRMbwkzi4ya4eJgXNZWhWGgp270zfMy
	 qJXvmo8qRrXkqe4OdUQJe1JI6UhVpszHY6nieDfL56KgogpGsM8fQ/5FY6WXTiMTEA
	 MaxxFxDUhvvqg+YLIRg/k69QkgcxOBB5vnUAiaHvFvLeo/Rt+PwwXAZFPq9uq+DkO/
	 F2c35NLxS6GEg==
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
Subject: [PATCH AUTOSEL 6.7 33/44] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:21:00 -0500
Message-ID: <20240207212142.1399-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132306_679832_40A755E1 
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
index bd59990b5250..8cd1ef293769 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -360,7 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -373,6 +373,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


