Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FC7C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A78VhxPJyB+LkADGfQuQSz0pi6yfAcwi1eR7ydqDjhs=; b=uLk5kRNE6YgyV6ps+DglrTNoc6
	YUnwGFJ1ifQgWQ3Dti/S1OaAZCIY/2/yCjrfziV25m+wfnPwxg9fw73N90dH0B/8+Vt+L3DOIN85h
	ycRnqqn6dcKI6H8p19/LFe1U2Bti7oKrn+pb4TF8p66QUNsgrJifjw9Ml0nmGMOfv7mm4kLpHluRU
	UmlczsipdJuYJsQZ5N4EehsQ4gpM7xniDCEQu6x1GDIuNLdza3kb5F018UKkK7U7CjwFGfSUBqQ/Q
	K9Pqqo2bcB5kYKKg57ljYqkN9KOaGKVmWrX9mUwNFiiZHfIEPPPISHWru9OQfVs7/Y6QT941NUqRR
	qAu5oUIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkAf6-00000007qpd-3o1z;
	Tue, 12 Mar 2024 22:31:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkAes-00000007qjT-2hGB
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 22:31:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AFB668C4E; Tue, 12 Mar 2024 23:31:32 +0100 (CET)
Date: Tue, 12 Mar 2024 23:31:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] block: move discard checks into the ioctl handler
Message-ID: <20240312223131.GA8115@lst.de>
References: <20240312144532.1044427-1-hch@lst.de> <20240312144532.1044427-2-hch@lst.de> <ZfDTZpuumZSn6oPp@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfDTZpuumZSn6oPp@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_153142_946756_C5744551 
X-CRM114-Status: GOOD (  14.58  )
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

On Tue, Mar 12, 2024 at 04:12:54PM -0600, Keith Busch wrote:
> > +	if (!nr_sects)
> >  		return -EINVAL;
> > +	if ((sector | nr_sects) & bs_mask)
> >  		return -EINVAL;
> > -
> >  	if (start + len > bdev_nr_bytes(bdev))
> >  		return -EINVAL;
> 
> Maybe you want to shift lower bytes out of consideration, but it is
> different, right? For example, if I call this ioctl with start=5 and
> len=555, it would return EINVAL, but your change would let it succeed
> the same as if start=0, len=512.

We did the same before, just down in __blkdev_issue_discard instead of
in the ioctl handler.

