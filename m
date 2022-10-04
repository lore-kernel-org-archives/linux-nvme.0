Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11X6w7vEu0tjTIHKzhmOqBBDI/k81VfR7jkK8cS2SLs=; b=aBEzT8ch5caenC8iUUl+PkTrlK
	Ish/JBb/dd4avBAj+HTl+AnJ5wMqCK1KUtAORYq0lkqCs3BPvguCXHo/Y4DeFMa1cxRxeKNiB7C/B
	P3RMFWTzZcN8dtPajtAxFFlmj77OaG7lqhpchz3NW6on3lf8qfc87Y6M+Q3N/IEdOPQpGGg9NfmOB
	JjFqMkXHdVquFQHUh75EJIfvgldqqUbNdpeU/cxxqJtFDafOdbdv0CgwEMHJ1T1NUR8iBBf6NlPQ4
	pKiL2A0t2BPaEYITEMGyXqgJpJfHOEOavJaMpZSlSoGImGe/B/PuwEBz5MeKAeMjXYLJ1rlv70DeU
	OJqhhbmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oflnl-00AKB8-8M; Tue, 04 Oct 2022 17:33:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oflni-00AKAO-Gg
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 17:33:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7A251614F1;
	Tue,  4 Oct 2022 17:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAA0C4347C;
	Tue,  4 Oct 2022 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664904827;
	bh=PwPs9MrC9Nnp8YuXE4YUV6t4bJoGLpNTpwSGttYa7Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAixdHgrvrMRL7IegAz1OTU6UQXKZBnHxqZglxfcFTG3tW/ysYVojy0xhNtiVt2hG
	 TgLKzPoef7vjF2ubyvUoPry8SNTQJp6iiz8jA/lwQKGvRMpHzPSzBZvknZeedb45AI
	 ZBeYujjiZaIfaQVwP0hpr+JccVp7YYc4ilWnI/2S2E4aQDdXvwOb/a7bAUVuFY4Zmp
	 Px+s4UxtFKdbHcakbg2lJrHk1VElDY6Vz17OKApGn61geIcpptg/oL4sadL1ymoP6D
	 uuEOWDRi56Rq0udQDutmX9vjRdg6nd6tQFqAM34iAsDf8b5gWWUTMHoLrjqM+dnKAO
	 AiDImc9UmloWQ==
Date: Tue, 4 Oct 2022 11:33:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <YzxueNRODpry8L0/@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
 <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_103350_668471_29A1917D 
X-CRM114-Status: GOOD (  32.11  )
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

On Tue, Oct 04, 2022 at 05:50:49PM +0300, Serge Semin wrote:
> > 
> > This particular condition for hwmon is not something that prevents us from
> > making forward progress.
> 
> If you consider the hwmon functionality as optional (AFAIU you are),
> then just ignore the return value no matter the reason. 

That is not an option. This function does IO, and the controller may not be
usable on the other side of that, which means initialization must abort. We
can't just ignore errors; we just don't need to report errors that don't
prevent forward progress.

> If the problem
> caused the hwmon initialization process to fail turns to be critical
> it will be raised in some other place which is required for the NVME
> driver to work properly. Otherwise the hwmon module initialization may
> still cause the probe procedure to halt, which makes it not optional.
> That's what I meant when was saying about "the function and its
> caller semantics not implying that".
> 
> >  
> > > > The
> > > > driver can participate in memory reclaim, so failing on a low memory condition
> > > > can make matters worse.
> > > 
> > > Yes it can, so can many other places in the driver utilizing kmalloc
> > > with just GFP_KERNEL flag passed including on the same path as the
> > > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > > either finished or executed in background anyway in all cases. 
> > 
> > This path is in the first initialization before we've set up a namespace that
> > can be used as a reclaim destination.
> > 
> > > Don't
> > > really see why memory allocation failure is less worse in this case
> > > than in many others in the same driver especially seeing as I said
> > 
> > The other initialization kmalloc's are required to make forward progress toward
> > setting up a namespace. This one is not required.
> 
> Anyway what you say seems still contradicting. First you said that the
> hwmon functionality was optional, but the only error being ignored was
> the no-memory one which was very rare and turned to be not ignored in
> the most of the other places.

> Second you got to accept the second
> patch of the series, which introduced a one more kmalloc followed
> right after the first one in the same function nvme_hwmon_init(). 

My comments on this patch were intended to be applied to all similiarly added
uses.

