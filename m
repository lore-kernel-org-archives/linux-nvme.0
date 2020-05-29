Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62BEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:37:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B052072D
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuPtnWiM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1KsUxj2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B052072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qCVhuAGPCsLahvAsJBmyG2QcFtgWDfrXyzd3Glx+6oE=; b=OuPtnWiM9KA4HR
	3FJ7FqmfyD7dr6mt2YOiwGP3q4FyVDV255PKrbsjawki2RD7LSOgAusuawBshnDJec7FIaBguOXDL
	syjVrKHy2VP2dWQQ3+3FJvrS47Gy6yz2Cm78kkjsInNKX4qEZcJMbpTHD/J85+27cXvXlM+TfvYJT
	XmM9qGP8oFjo5Gjgrx042QAuWFGSZf1h6hlmnSI7FrQhDnrUXbya4CeOjwkZ0k6PZfB8mmaIuGTwP
	22hmXis5jSeJ/d+N88W6EvPs2qCwuEh79ZPHIp9k+VffU5SkcWjJZ9RxhGeEjEHYpUD+giBvhT7a5
	h1+NnrmiR5Yz6GoyGhlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeg8r-0003da-QW; Fri, 29 May 2020 14:37:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeg8p-0003cB-3s
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 14:37:48 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0B5420776;
 Fri, 29 May 2020 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590763066;
 bh=6c+sUZE1lDgrvZXEOBr3V7VAXwat7DZ3zJaGULnLPcE=;
 h=From:To:Cc:Subject:Date:From;
 b=1KsUxj2VkajVhiX6EZh32wl0WVR9k5QvZcUtpdrxxyy2y5jKuCjT+z9Gvx3tMzthd
 Do90xTY9q+kEGF4X/7aSmYDTUTj9sh5G0lVf7yiavDZ1Ad0s663x5aBuQxMvMSZRDn
 s1BBFS82DLJDTZvR0w7E+6qx9j8qlIDGWPh62eHE=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCHv3 0/2] blk-mq: force completion
Date: Fri, 29 May 2020 07:37:42 -0700
Message-Id: <20200529143744.3545429-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_073747_176618_C60C30B1 
X-CRM114-Status: UNSURE (   7.22  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, alan.adamson@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've renamed the newly exported function from
__blk_mq_complete_request() to blk_mq_force_complete_rq() and added
kerneldoc for its intended usage.

Reviews and Acks from previous versions are not included for PATCH 1/2
since the name changed.

Keith Busch (2):
  blk-mq: export blk_mq_force_complete_rq
  nvme: force complete cancelled requests

 block/blk-mq.c           | 15 +++++++++++++--
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
