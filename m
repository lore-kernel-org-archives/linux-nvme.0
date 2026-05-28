Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E013ECD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9T2cjIzZrCgAbBk/8HQTKOkMW08zXo9cpLSyBb/lJOI=; b=zxk5qpw/k1UCYFe5yfclLVf6Ze
	HRF4F2hMXPmEu9ELHcyOtdLBwhQxVP5gdJaI17IvaiWFUofB6LtpcV3H1/uLtE8iiMG9TqxyrDtIZ
	MxUhpKdWsPKxwB0UT/pba55RkI8a9Zi03BgQWQSzgEyEm1gplK37lZLMApGVpWKRy+4U8Hibd52zC
	1bup3GYsXQ1g5vi7xVSlkf9HUkia5s1jP56eDSrib1rsgz+gm2mAU/38Fbx2rqruXlQUBjDPpOjBT
	7r9d79SgTja5AFVnAr61a2vR2rLGZB1rKGFqE0E1fiZytbhXEVt1wNPj+lOyw/9Ylu5MZfHUGSNq6
	4xvtif4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR1X-000000051mV-22Tj;
	Thu, 28 May 2026 03:03:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSR1W-000000051mO-11Rp
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:03:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 07C6C60572;
	Thu, 28 May 2026 03:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A0E1F000E9;
	Thu, 28 May 2026 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937384;
	bh=9T2cjIzZrCgAbBk/8HQTKOkMW08zXo9cpLSyBb/lJOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g/aO2YGlMnhJ41Jkkjr9dT5Yon+FgEs28WKb5Rdz7Y+jsrRANOGyRgPKfsAWg6cBU
	 KsZy6BpBL2PBSU4vzGcXiey6Z3fkHwxn09KIfDuIM9HrNV2SUVbTuCZ33tc34GeBDu
	 em70WeQaHTOfucTrna3V0ulgICrnoD/uwj0fraQ7Hc06DuhEbQq7dW2iqZiY2kVlJd
	 0B2Tywwtd/WH8tmuz8ot1BzbQLuP8QLdXZoRHMNPpCGRbdZPlJ/Ryoc25ixX3s7Og9
	 tlOpb8PRO7l1RxmVwuFbvZUbT2pMwH0cSQO/bxL04BBPIot1PdbNNkecPJjATT65Zk
	 11s7LVBEKpGrg==
Date: Wed, 27 May 2026 21:03:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: guzebing <guzebing1612@gmail.com>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [RFC PATCH 0/1] nvme-pci: detect I/O queue depth changes after
 reset
Message-ID: <ahewZiV3n6qG1Jhm@kbusch-mbp>
References: <20260527075320.3178600-1-guzebing1612@gmail.com>
 <20260527131951.GA11071@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527131951.GA11071@lst.de>
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

On Wed, May 27, 2026 at 03:19:51PM +0200, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 03:53:19PM +0800, guzebing wrote:
> > This RFC instead takes the smaller approach of detecting the reset-time
> > CAP.MQES change and making it visible.  If the live I/O queue depth
> > shrinks, reset recovery is failed before recreating I/O queues.  If it
> > grows, the driver warns and continues with the existing queue resources.
> 
> Unlike the other version this at least sounds doable without creating
> a complete mess.  So if we can live with this version that'd make me
> much happier.

Abandoning the device here sounds pretty harsh when blk-mq already
supports user space decreasing the q-depth on a live queue. Why can't
the driver do the same thing?

