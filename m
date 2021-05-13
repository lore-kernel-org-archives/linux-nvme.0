Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42882C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 12:00:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1276127A
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 12:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1276127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S05RFMb3+qY3tYQh3kVz0bKebNBUUFVGAmXL7FsXcLg=; b=THeMeYZ74JU+W2Y9ndz4xebv/g
	RSPQv5VOVMbkxS9hqpLDRcJKqqI3dNNMDHARNXhcfq/ccFy4QNrLGQkT8OX4eyG6KKKxfnlKJfknQ
	4VwGc1AfXCoaRGgSdKik6KNAGRcH/w2wLwPRbNaEaYJFaB4m9162gZl/6rzCTtcBgwk+9ZU6gShyX
	uieVJv+LZ9LpR3LLYpRyrssR78sHIHZsVR4TU2u96galv7m4BVf91IKN/QN9tBzmKOkhs8+9dXUQw
	b9a6zkWgec3R/oBVx+1z7fOyYKx7/08C5hkLdLMsQiEP49uVNSDs8hCXiNqRWIjNQDctkBdZsz38y
	cL+X1PDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhA0b-005TPJ-2g; Thu, 13 May 2021 12:00:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhA0W-005TOp-Rs
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 12:00:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=UUlE+XNxg2jReS5huBlLWG3UPhEU/FuKXhSNqpBJHiE=; b=MHl4uEKrIpJpnxGub6ixhdETPr
 Q6gSS94f7NEDaaR2CWSjtbPRaoBOI+KzrvPwnfuj1r+n95np0QNWj7ukMkPKozHdpXyn8l8i27lqD
 PcXH3leEBkosmTbszhgePJ7C6d3jRjugLU+L/vSnniJOCKtd/n9p5pkT/N1yHIlKGik44t6RuFiym
 9uFKGDY77p0xzOy4ix6ytyKgy5B5sP8+9+RoHYSZfuzQpoANFcnZhYyv4AuF1H08xLW5RgKAABkkI
 +t7Ubp9X7jlw/HTBaRZrEusIv6nuIAYPq5TZfaNnAy5ovmvfDg3GRpug7uCkdMRJq/zf5MaGi/AiH
 KMwH/2bA==;
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhA0U-00BDxz-6S
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 11:59:59 +0000
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1lhA0O-00018f-8F; Thu, 13 May 2021 11:59:52 +0000
From: Colin King <colin.king@canonical.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: remove redundant initialization of variable ret
Date: Thu, 13 May 2021 12:59:52 +0100
Message-Id: <20210513115952.58482-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_045958_262541_96558DA8 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read,
it is being updated later on. The assignment is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37943dc4c2c1..74bf2c7f2b80 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1088,7 +1088,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 
 static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
-	int ret = -EINVAL;
+	int ret;
 	bool changed;
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, new);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
