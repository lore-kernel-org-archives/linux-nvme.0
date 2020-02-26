Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA8C4BA06
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:43:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7D521D7E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLzHYYD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D521D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uS4QMXZFabQ3uECq5abAU6NIUCtTmaZgD9XYPuzJMIY=; b=bLzHYYD/WyP51b
	neEQTS2vm93/PQ8dsSJ8v+SGawmuvHa9Ss0hW+NWCqX2HxG6I60R1Vn9D7AyYcFvkgEdphXIR2dac
	p0RBTmGFyqPYc5ZdhgyC3cu/ErhTNFO8elAY6+Oul3wKXuOZq6HYhWSGMH7NQgiD1+Ee2v4D4FDwA
	Ul3FC+xlKRMrax70BKaVKGRe0XlDGCjGs1Tx4h0bfutVc+tfqg97Ur1hRqbp4OTsz95pzgeIYckYF
	llSuO0bZB/EuyqRO1BQJuTtCIdK4OtUb+iIMjeVI5beexldgbIAz4PJyLdMYnCT4EPoVtw59EET63
	G+WGHnKoctV+dt1pZp+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6knR-0000jy-KX; Wed, 26 Feb 2020 00:43:29 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6knN-0000gP-6B; Wed, 26 Feb 2020 00:43:25 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme-tcp: break from io_work loop if recv failed
Date: Tue, 25 Feb 2020 16:43:24 -0800
Message-Id: <20200226004324.10694-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226004324.10694-1-sagi@grimberg.me>
References: <20200226004324.10694-1-sagi@grimberg.me>
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

If we failed to receive data from the socket, don't try
to further process it, we will for sure be handling a queue
error at this point. While no issue was seen with the
current behavior thus far, its safer to cease socket processing
if we detected an error.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 221a5a59aa06..814ea2317f4e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1074,6 +1074,9 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
+		else if (unlikely(result < 0))
+			break;
+
 
 		if (!pending)
 			return;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
