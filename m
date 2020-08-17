Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A2C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABE320738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3b8vqd9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i7we8asP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABE320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EzR3z+nvJGBF7iEljJ3iHbdukwGJaf7CtwjdZhB9XJ4=; b=M3b8vqd9w9dB747udyBmgddHd
	d05NGlJJNJXtxcuV19VSCZJGdDgkLvulf+pmz7qr1ulC4O7OrrWhQsV1TWtOUORDz7WXXAMTy7Rr2
	v9qqANd1w510/KFXyTN6OKLMf4O0FSmlqQqBQQ/6/j8tWpimHb4ek0PZxdr+EOl4E5hfcxmcNaRwW
	pw+VpnRos+6uBRZxbrHwpj0VBRpsn+2a05RLCVSbAOpHprzh8osUk0DABV/fVa0/g1dQqneNtPZIl
	gM3z3Ef6tIR/3bR1XQT+QNMnCVdCiTexOACFHYzfZWqJ72POhn3tNut/HODUilqI0alZR39Tc1snw
	BsClqXK1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aMO-0007fo-Bt; Mon, 17 Aug 2020 08:19:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLE-00078L-P3
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 08:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6WO+sATAwlkMCMMiQzOORXW1MalyZS/SxNbGOlNvp6k=; b=i7we8asPu4op+p6shhZI7QUzDH
 V2RAO1Bfq0KaU0JHwg7xybl6SSnY4vId7TXcQpM7G0amdTFW3n9hehsAXNy32cWuD2fIfxe+EaaIH
 4XiPHdGpS3jpr9Gcd6zP5cSfUYS1IMrKXOg0MFhoO/eRaamESUV08ukPcapipBmQJBRY2goB91rcz
 7KFBK/q2vwvoyVJ6bXi+J9iE6GWcaTdel84iI5qp4P1xz0KJyHWlLVmdsvVX2glQnRTWNbaJrF8Zb
 dq+NgVEJzK4f2Ph3OJ8LAbzVRAwzixL0hOSkAu2u6cdKEWSBwuSMedCIusPBM9qBjZ0JiK7ReXDkx
 Ru3MrgoQ==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLD-00046q-28; Mon, 17 Aug 2020 08:18:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: just check the status code type in
 nvme_is_path_error
Date: Mon, 17 Aug 2020 10:15:43 +0200
Message-Id: <20200817081544.837699-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817081544.837699-1-hch@lst.de>
References: <20200817081544.837699-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Check the SCT sub-field for a path related status instead of enumerating
invididual status code.  As of NVMe 1.4 this adds "Internal Path Error"
and "Controller Pathing Error" to the list, but it also future proofs for
additional status codes added to the category.

Suggested-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/nvme.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dfcdeb318f3ab6..11ee0176fc45f4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -537,16 +537,7 @@ static inline bool nvme_is_ana_error(u16 status)
 
 static inline bool nvme_is_path_error(u16 status)
 {
-	switch (status & 0x7ff) {
-	case NVME_SC_HOST_PATH_ERROR:
-	case NVME_SC_HOST_ABORTED_CMD:
-	case NVME_SC_ANA_TRANSITION:
-	case NVME_SC_ANA_INACCESSIBLE:
-	case NVME_SC_ANA_PERSISTENT_LOSS:
-		return true;
-	default:
-		return false;
-	}
+	return (status & 0x700) == 0x300;
 }
 
 /*
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
