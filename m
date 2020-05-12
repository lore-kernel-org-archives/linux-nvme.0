Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8188CC2D0F7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:17:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582B7206B7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqQ6UT6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+JOX/7tTnA01dsgc9qqveYmqObR8V5jJMMt9lb1b6ig=; b=AqQ6UT6LWpzwMY
	ipQh5W2hOqhVg9o6nUZMzZgoRZqX9b7rbD+ZH7y5lLN+KKRp4g0DeKpN8SvEquJRvcEoCR91cPXRE
	1t3seMx4ZtOW6IjrdkefWmwvRQMbzC64Inpp4bLG1JBZWBxxILBXCvNSXl5QzVx9DUGEweEYPaj65
	1KXQJ3Ptdd9q5PuWb5FlcYSm7NCMjQCTthAVBczOcxFaKS3OHaY+n1B6SXUDR04O2OIufZSwuQmSb
	EfEzswobK2u4uL4dN4dmfXN99ab03qyEsoH35Vf3zelXHm04l9n0UhuKT/BswgQy49wCbCAyyD7wq
	a6Om5vDiWzOTEEiPJeEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYXbL-0002cH-4l; Tue, 12 May 2020 16:17:51 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jYXbJ-0002bx-8n; Tue, 12 May 2020 16:17:49 +0000
Date: Tue, 12 May 2020 09:17:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH] nvme: make sure write/poll_queues less or equal then cpu
 count
Message-ID: <20200512161749.GA16555@infradead.org>
References: <20200509062203.GA19802@192.168.3.9>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509062203.GA19802@192.168.3.9>
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
Cc: hch@infradead.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.8 with a small tweak to avoid the forward declaration.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
