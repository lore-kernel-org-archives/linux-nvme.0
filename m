Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E12606A33C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rt+R2481;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AOG9wmnD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VIjKpLz+YFlwDyK9AsbB/CVD3zQPr5oabhk2IyzlhFc=; b=Rt+R2481xu0Vmrc8Wmls5+SNqk
	bkx5HjGm7KY7lyK32fsDh4yIJf71nkE8eZb5t19MUiWNQX2wq/ArUS27OvVuA8OAnpty0FHWlJ6/W
	BpWGTVXELORXctdUB3cj+niTlljWEAc7oDcOLn4xQLtnEiUxsR/YjKC4Jx2GeoS8j/jaPrpeuCD96
	zxDIWTRbDV0MkaBn1nn4HQKpgx4Zr5u4lJ5ZNqDfNdLTQXme2E7npmXxJcSX1xxe9ow+mmHHDt9WV
	nITi/IF1DFmWqNyzfWfavFX2jWwDeDGWZ9BcxklnELspKBoyk7sI1ZRv//j5CmfkSITc9cyuLV/8J
	t+9wCiRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO91G-00000001KY7-1B4p;
	Tue, 03 Nov 2026 07:33:22 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO91C-00000001KWj-0eOU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 07:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793691194; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VIjKpLz+YFlwDyK9AsbB/CVD3zQPr5oabhk2IyzlhFc=;
	b=AOG9wmnDYXxtJ8eEmL9HsTnxCYigHmg0FQ6G6Wu4rhfAMKus4CxNnwvIYG+O7OT42RVMGLPJo39/gQxiL6iP2Bz54QKgiqw/5n6qahBoXwpXgCVq5RpwC99hCqh82vy+mnLgQDmToVCwDAhPNbuxqrbOtikMAuImDoalcfZwHxY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE1sgua_1793691192;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE1sgua_1793691192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 15:33:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-rdma: remove dead allocated field in nvmet_rdma_rsp
Date: Tue,  3 Nov 2026 15:33:07 +0800
Message-ID: <20261103073307.2588945-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_233319_259434_84A9FCDA 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 40f0e5dc2f3c ("nvmet-rdma: use sbitmap to replace rsp free
list") replaced the ->allocated flag with the discrete tag value
NVMET_RDMA_DISCRETE_RSP_TAG, but left the field behind. Nothing
references it anymore, so drop it.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b9e39d1657d2..b645e103d6aa 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -71,7 +71,6 @@ struct nvmet_rdma_rsp {
 
 	struct nvmet_req	req;
 
-	bool			allocated;
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
-- 
2.43.7


