Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63077C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/aZXwjc7L8+aKhbaNItjRkj9yC9J2s0DtIlZyKl59TY=; b=HRSGjtXgv2pe+vXOYGLXgbMFw2
	b9ROIDR+tIQHrydAn5vYw9WbKB0JOQp8qgRQkc29k+EiQU9+RlR3ygfE6vZGhL27gni0uCCL8c8bQ
	dG6wl6Qr5PkgirKP8kzEvNkkdn+c871CS2HVDsQalEzOVekHGFSC0BgW9v8lR+4oICx4abH4tGIfb
	1MNBly/s6dqVjyuQoJPLwmstcZlhhvY73E096lorKqsW09kVjo4E8J6SEwlU7SEvTOuEnFNUaQOA3
	BkJgFxt7cmjvJtQydHtFfpCVo/5pJmjrOJJDvZHYj2oE/n7+/dMngXrxZOg+nY9VR2rQPMJhOZmqo
	k4c9GewQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5jV-007akh-7b; Thu, 28 Apr 2022 15:07:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk5jH-007aeD-1W
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 15:06:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C4C5368AFE; Thu, 28 Apr 2022 17:06:45 +0200 (CEST)
Date: Thu, 28 Apr 2022 17:06:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <20220428150644.GA22685@lst.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_080651_284976_030AAA3A 
X-CRM114-Status: GOOD (  17.06  )
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

On Thu, Apr 28, 2022 at 04:44:47PM +0200, Thomas Weißschuh wrote:
> Is the current code supposed to reach HMPRE? It does not for me.
> 
> The code tries to allocate memory for HMPRE in chunks.
> The best allocation would be to allocate one chunk for all of HMPRE.
> If this fails we half the chunk size on each iteration and try again.
> 
> On my hardware we start with a chunk_size of 4MiB and just allocate
> 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.

And that is because the hardware only has a limited set of descriptors.

Is there any real problem you are fixing with this?  Do you actually
see a performance difference on a relevant workload?

