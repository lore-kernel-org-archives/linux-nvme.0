Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA87C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzDjNDADsWTDpkzolauT0YiBxqKoOMzAdS8Zn4R1Zvw=; b=Q5m4afI5gEP0FJwgQfYh9GwIQC
	XhHZcv3aCdFScRgPhlI9IwL2lWI6ETZQ/I7w/KgSisZEa2l7nHuS46dGZ8SljXfa6TGgJat5Qi0FI
	M4MRUi5IEthBGBofXZPk7hvrYmtfA0p5OyAMnv29KA1ztEyXj4GIXoGAc1WxbXAkyWmzKZIeQmN7e
	8qCrkn6ltu2Lm0W/Rtgo+vHvXQO9uR2arP6dSTI8pdXXIx0xLU1dGdaKg9XLapr9DmXJ7PrjPSmu/
	WbEEUJPAKpTgx52Q3Sd7czMc5HPtG9dJXeN+VfTY9E4Kubm8BGFpZU4Z3ahP168vZ/APLbXn/U2mB
	nOrwlJZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhWYQ-0000000EEPn-3rBb;
	Tue, 05 Mar 2024 15:18:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhWYN-0000000EEOp-1eix
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 15:18:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A0FC60FFC;
	Tue,  5 Mar 2024 15:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21FAC433F1;
	Tue,  5 Mar 2024 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651882;
	bh=K/dqfpy+zUxYquqw2K5lsX8LmOK5l1yuCoq56a6ADEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feIpieJxdAwU3TrwzjrPDwCHo7Qh0dTA20m1Fjbiypd7LQQ5YT+r+9a1iGYmSfuGG
	 P+EFED06qEHi6ePX55NHQOJ/GvmOVk6m7Zh++kmhOobTw6XRUlbmKujWZvqLEs+MjT
	 p91CKsEPjeBlbwZ890kqw2+7thZu7kIhPj5U+f6TV6FKDOt6wC54OXeaM/fonVrhZ6
	 ub60VTkVGIdNt+Om7IGfOPEmBbZd1SSFbs4YBuGYo+WKcvWBcZXRyuTHwCyzpPXsOo
	 RWvEYktYsvutX2TeujWAVkG6nltw5jHYt931pKoub9HaQLD9QYg/WdBe1hjkc66BOA
	 KWwWvJYmunV3w==
Date: Tue, 5 Mar 2024 08:17:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Michael Kropaczek <michael.kropaczek@solidigm.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Message-ID: <Zec3p1bU_aTJJmF5@kbusch-mbp.dhcp.thefacebook.com>
References: <20240304182507.2601387-1-michael.kropaczek@solidigm.com>
 <20240305135100.GC2063@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305135100.GC2063@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_071803_511885_D06BDD96 
X-CRM114-Status: GOOD (  16.54  )
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

On Tue, Mar 05, 2024 at 02:51:00PM +0100, Christoph Hellwig wrote:
> > +	/*
> > +	 * On certain host architectures/HW, DRAM was keeping memory contents over reboot-cycles.
> > +	 * It was observed that certain controllers were accessing host memory after
> > +	 * resetting which led to undefined state preventing proper initialization.
> > +	 */
> 
> Block comments should never span 80 characters.  But more importantly
> I don't even think we need this comment at all, this is a clear bug
> fix and the code is self-describing.

It sounds like a firmware bug. Spec says:

  "The host memory resources are not persistent in the controller across
   a reset event."

Exiting a shutdown state requires a CC.EN transition, which is a reset
event.

It still may be good practice for the host driver to explicitly disable
host memory, but as I said last time, doing this in the shutdown path
deadlocks if the drive fails to produce a response, which is why we
removed it in the first place.

