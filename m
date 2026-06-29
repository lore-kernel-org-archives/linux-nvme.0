Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB19C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=leU+FCE7AUl8wKIz5Hc31oqJLOeN0AHaX3MOwjeElw4=; b=kFreeXy+l5LauWGXn23B5wSy9P
	EV4UKQB9UiHOn7/ELzZtM7Rx1yfPGyKVfLdrErk8DL4yHyrS0CjaNGjfRu1uaZdK3hETZvK/hBmed
	RJhzlSE1EALDkGAiq0O8DCWlOpUbUvc0GWr4TucaCcKuK0iLZp7tyeIrJONYqu6StGu1Nh+HshY3F
	s05OSIfrE7NCqNQfSyXKmcKZFN+9FV4TL9ZFwO8PVqU8FhVdhMs+jQxdYSiFQR5m72AN+TUQlFJP/
	uZ/J+eLalcwJhWeSjJLHXWLl7xr0onR038B/8QzcFWt7+n3i4ndrc1x5RPUwY4mxabYGBQ8uFKRCm
	1Xw7W4NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weB6E-0000000EYeM-459Q;
	Mon, 29 Jun 2026 12:28:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weB6B-0000000EYdA-3XRg
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:28:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45E2B68C4E; Mon, 29 Jun 2026 14:28:23 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:28:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <20260629122823.GE21344@lst.de>
References: <ajlDjpjK_clMrnwx@ubuntu-server> <ajlIPlEv_zBfTMVG@kbusch-mbp> <ajlNFpz5977PzLvb@ubuntu-server> <ajlRnLI8OdaUVOZp@kbusch-mbp> <ajphNQIpfIRYZg_H@ubuntu-server> <ajp5vFaVB4wOHjpf@kbusch-mbp> <20260624074045.GB12649@lst.de> <aj69FEOLH82dLErr@ubuntu-server> <aj77qInSZ3jJfNRU@kbusch-mbp> <akJiSTxXC84z4KiT@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akJiSTxXC84z4KiT@ubuntu-server>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_052828_035246_DE721F27 
X-CRM114-Status: GOOD (  12.48  )
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

On Mon, Jun 29, 2026 at 02:20:27PM +0200, David Epping wrote:
> Keith, thank you for the follow up and catching my mistake. I noticed the
> missing R and just assumed its a typo... Sorry.
> I will absolutely look into SIOV to understand the concept!

Note that SIOV would indeed be very interesting for these use cases,
but it requires spec work and hardware support.  The NVMe technical
working group is looking into a proposal for it at the moment.

