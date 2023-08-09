Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DE1EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T5ShNjU4/LsPKNU4jIXODVPTZQZoZ7/nM2hMhlTavlY=; b=2Qv8j+vcSMwKeqLduT/aC4JwcC
	HSUMFwsgGHe9p+Vb1v1U2AO9cCX9gXn+wyC1IxkQk9UE1CvNHTpDBVnEBbhHfi+XoEvNwkBJG6WPD
	7bqMGw2K9I21Qu0GxpS1u03tSXzKycK8qmxRVCvorQyPxzSFVg+WWsTdpZULXjQDr/uxamBbCf3y9
	6B4B/RLU/8Ztu7xFjO6yprCa/X4QaaYed/+M/Rv34n+xYAtU7msjGBeWAEzmVxWvyj13R/Ht1LfQS
	arc51e0K1G3LnWtnFt7urJBl9iRvo3PHi8GLb5NA5zRgwyBiCkRcyQaSwWHs50feRDGezmCgjGYnV
	p9yyEfrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgVo-004Yiy-22;
	Wed, 09 Aug 2023 10:33:56 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgVm-004Ygw-0i
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:33:55 +0000
Received: from lanta.blr.asicdesigners.com (lanta.blr.asicdesigners.com [10.193.186.249])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 379AXT5t013584;
	Wed, 9 Aug 2023 03:33:30 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com,
        Rakshana Sridhar <rakshanas@chelsio.com>
Subject: [PATCH v2 RESEND] nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()
Date: Wed,  9 Aug 2023 15:56:45 +0530
Message-Id: <20230809102645.47190-1-varun@chelsio.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_033354_270769_9C1D8120 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

iov_len is the valid data length, so pass iov_len instead of sg->length to
bvec_set_page().

Fixes: 5bfaba275ae6 ("nvmet-tcp: don't map pages which can't come from HIGHMEM")
Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

v2: removed alignment change

 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..cd92d7ddf5ed 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,7 +348,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		bvec_set_page(iov, sg_page(sg), sg->length,
+		bvec_set_page(iov, sg_page(sg), iov_len,
 				sg->offset + sg_offset);
 
 		length -= iov_len;
-- 
2.27.0


