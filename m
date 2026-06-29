Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F420C43602
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rcqy+7LSdZuBOTRJm2wAdFrGTa+wiIe9ylP5OjVBprc=; b=kbRJT4ydib4rb9K+aGze/HX0Mg
	hbnCZ+PlD41n9n/QLlSzfvjczo1iqo9x5sUxNxM5sS51pSGoVpeuslWDkbiXN9qNcSS8e60mnvSm4
	xPge2ZXWcxleLFCuRXA+gAuag6Y26GUz0NwpgC6iPCjqWazPWiGFqm331/+cONrYHoeTjbjrQR5Uy
	Nj7RQMiaEKfdfRQEkuxrmg9LgqJoVtviWw00BUZsHHMfHBaLTaJGHKM41YrAWnSW7/kPEGyukkSkX
	EMdbpT5woQXWVBLthB3Tz8dZg4kEZGMBciZF5inSf5Cuoh41VZ+DJam42Kq+PErG2GQ1QKgFU+xP9
	oo1wWfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAyg-0000000EXJo-0SUF;
	Mon, 29 Jun 2026 12:20:42 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAyd-0000000EXJA-16zw
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:20:40 +0000
Received: from ubuntu-server (ppp-88-217-66-27.dynamic.mnet-online.de [88.217.66.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 04B0B20201;
	Mon, 29 Jun 2026 14:20:34 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:20:27 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <akJiSTxXC84z4KiT@ubuntu-server>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
 <ajlRnLI8OdaUVOZp@kbusch-mbp>
 <ajphNQIpfIRYZg_H@ubuntu-server>
 <ajp5vFaVB4wOHjpf@kbusch-mbp>
 <20260624074045.GB12649@lst.de>
 <aj69FEOLH82dLErr@ubuntu-server>
 <aj77qInSZ3jJfNRU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj77qInSZ3jJfNRU@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_052039_462751_230C206C 
X-CRM114-Status: GOOD (  18.66  )
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

On Fri, Jun 26, 2026 at 04:22:32PM -0600, Keith Busch wrote:
> On Fri, Jun 26, 2026 at 07:55:32PM +0200, David Epping wrote:
> > Thank you both for your feedback, I get the point. I'll definitely look
> > into using SRIOV or SPDK to migrate the system to an unmodified upstream
> > NVMe driver mid-term.
> 
> SRIOV could definitely get you there with existing capable hardware and
> software as long as you don't need to exceed the VF count, but it is a
> bit heavy for what you're describing.
> 
> My SIOV suggestion is more fine grained for similar use cases, however
> there's no nvme standard or kernel support for the feature, so anything
> using the concepts would be a custom solution; NVMe would need some
> mechanism to associate an IO queue to a PASID, then attach namespace
> access to that queue. After that it's just a matter of implementing the
> "mediated" device.
> 
> If you're interested, this is a recent proposal to generically setup
> SIOV, but it needs some work:
> 
>   https://lore.kernel.org/linux-pci/20260604150153.3619662-1-dimitri.daskalakis1@gmail.com/
> 

Keith, thank you for the follow up and catching my mistake. I noticed the
missing R and just assumed its a typo... Sorry.
I will absolutely look into SIOV to understand the concept!

