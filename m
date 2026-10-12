Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19862CA9EC5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJkYG1PF/wRZtcnLQD4tSTi4HXCWksgCTc7BhPtqd9g=; b=meY3kC+KIQt28uSXImhUlyK7Q6
	hgliDustpgmmg/REx9uKgQbBwEgJZeeLk/ZhIhsHB9luqzPNzmOVjW9bJFAel8f2YFQdAL2MxJV6M
	0g+JrLAPJtl48pJ46ChSxVzTiujuH5y/+U2vxgNNlLp9k9oxt5HkP8G8lJSv10DSHWAARQVb60CRf
	/VlkcET5meKJkG+azUVQnK4EHHWXbLzqneA44CNvDW+2prrXP9Yi0BsQY8Uk0yM8UrAfkK77ZmOUf
	DrW2YG1I/UgDybaknx1K4WUWdD9oLx/0io+LOHun5Vr7WnB8ehH5ZbyogyG8j3fD0Syalna1C/es9
	m4NlOyKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGH0Z-0000000Agad-3ORQ;
	Mon, 12 Oct 2026 14:28:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGH0Z-0000000AgaS-25Pf
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:28:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D611841959;
	Mon, 12 Oct 2026 14:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B361F0089B;
	Mon, 12 Oct 2026 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815284;
	bh=jJkYG1PF/wRZtcnLQD4tSTi4HXCWksgCTc7BhPtqd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMf6Ze/1bhc0nbfftS6JAU2tp3+zT5Dv1XEt5AjMVEHsWQIwOtG1GqJY0XccSF5lL
	 929hXp/lLWitwAKomo8ZfuiSnqY0AjpWZDVHH7dSr/EzDQJbSkkt2iQEc1I7La4AxD
	 YdarSXunGk5KxIGvtMjHVAJH2j3LirSM8dTXt6GQDzzXXs6zr61Gal6cC8D9G1uK0Q
	 c0kMbrOmGZmpgMy6QX8DLE//WxUptTAgt5yIzwP5hi2dUiKM5t0/iBptjp/jYLlIex
	 j5UHdSznIqRwkBrgSun+AIlSj+uTABJEOHA7cXn/IERzrgQ84ySL7rTglMCsI4/rEm
	 /0ti4WotsrNwA==
Date: Mon, 12 Oct 2026 08:28:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
Message-ID: <aszuckZVkc2-kXM3@kbusch-mbp>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
 <askIoNon8UVyNJiJ@kbusch-mbp>
 <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
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

On Mon, Oct 12, 2026 at 12:17:38PM +0530, Naman Jain wrote:
> > The disable_irq_nosync still does non-posted transactions for msi and
> > msi-x. NVMe has a shortcut for msi, but there's currently nothing for
> > msi-x. For that case, I have a prep patch I consulted with Thomas, and
> > the result is below. I'm delayed sending it out while catching up from
> > travel, but I think this will be even more efficient.
> > 
> 
> Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, I
> should be using disable_irq_nowait() in above and see better performance.

Yes, exactly. It should save hundreds of CPU cycles on every switch from
irq to polling.

> Please correct me if I am wrong. I'll monitor your patch in LKML for future
> versions.

I need a user for the new API. NVMe is the only one I have in mind
right now, so this new irq disable would have to be tied to the series
that does the adaptive polling.

