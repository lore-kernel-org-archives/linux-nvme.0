Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CFFC4BA09
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:42:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8995721D7E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T4JpBVM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8995721D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Oso/95Kyu7gI+VdGG0nh7n/3722hBAXV77K7GApkAT4=; b=T4JpBVM9P5uIn9
	uyBL/Uwiz4gQ2QxOOE1YFixzXJFK6HeSwnWFL5PBBI4BlxwZ+wABfxKVzzIR2VVljNS7eP1JWrXav
	zO3iRRaHiczmfPieuhgdAvxu1DL82lgHChUATZ2FsP3IyQS9fD+OSaq9TBkiYwKD1efaSSPOJbbPS
	Ivc/X0rNVgx7JaHS5Qw/pgl0OVpX279tAJmpS8HVNCgY4dl+XxwOIRB8bqP3YsX2R3kn/CTMFBSy/
	j2qhZ9Exz8rWDfMdx7hWqwv4Cr4yoVdB4zV8aXKtfExCMf3kRCJJKXv9WkC0MwUlwE5tnz8o+2DL+
	nzIuggJiDTKxlZ+90PnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6kmW-0000TG-KF; Wed, 26 Feb 2020 00:42:32 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6kmV-0000T8-1m; Wed, 26 Feb 2020 00:42:31 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmet-tcp: fix maxh2cdata icresp parameter
Date: Tue, 25 Feb 2020 16:42:27 -0800
Message-Id: <20200226004227.10354-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MAXH2CDATA is _not_ zero based. Also no reason limit ourselves to
1M transfers as we can do more easily. Make this an arbitrary limit
of 16M.

Reported-by: Wenhua Liu <liuw@vmware.com>
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cbff1038bdb3..07294672395d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -798,7 +798,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	icresp->hdr.pdo = 0;
 	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
 	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icresp->maxdata = cpu_to_le32(0xffff); /* FIXME: support r2t */
+	icresp->maxdata = cpu_to_le32(0x400000); /* Make this a 16M arbitrary limit */
 	icresp->cpda = 0;
 	if (queue->hdr_digest)
 		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
