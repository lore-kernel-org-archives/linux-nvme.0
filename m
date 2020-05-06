Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAC3C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 06:48:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDBF206F9
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 06:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VLqlB+Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDBF206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LmlY+LLwY6qR7xTR34zZmTZnzuHm/8qIGfvKY43U0zE=; b=VLqlB+ZmiXP3mB
	rtSzr97k8QtrFVQPP0F2TggKdN0P5yMtMc1I7ehHjOzM0WJlCBf1VxfMRhysMQfjPLx4ByVa9zPVg
	rLxNnX5VFrubInPmFqXasB1KX9kX400hRW+LBckcctMMNGLmBn/i1I25Yk+ZDm6Buy53Owgu1Qlhw
	yDbL7U2YWcptowhEdY8Snkpv0ffRpXuRww8CYy0aPIlfCPh3UUQ53CXRy99jJMGz4v8MFyhgaumuv
	lU94WWqyDPOq2rIHqksfahUueZuoW9o6sLz8o6KTILDQKN1qBEHZXqZk3TPkdS2W+gBNGGjc2cgda
	rwKNO8xmh25J3P7DJvHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWDqv-0000aB-9a; Wed, 06 May 2020 06:48:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jWDqt-0000Zz-SD; Wed, 06 May 2020 06:48:19 +0000
Date: Tue, 5 May 2020 23:48:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH v4] nvme: align io queue count with allocted nvme_queue
 in nvme_probe
Message-ID: <20200506064819.GA2094@infradead.org>
References: <20200502072937.GA12656@192.168.3.9>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200502072937.GA12656@192.168.3.9>
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
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.8 with minor tweaks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
