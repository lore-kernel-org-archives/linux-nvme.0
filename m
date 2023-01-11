Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BF0C46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 05:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJxxb2ZWVhEuXmw/t+4O9GPtVyDXiFR31EUQyydnZwU=; b=IEwO9mEi+jjEONdJOZ8U58X4o0
	Wb9uhTinhC4aTRsQSzrLnmkEIpOj3f4wcfCd5VbBwShaR838powGWoac1Ko63sDLjWh0u7B9A6fIR
	lqN8JHvaf39CoVEjndCUvqykoYZ7kO4TBFiCKkyHDBttEscJwoI5mD7fONMdrKaXK874jyW0jYbgg
	/OudMH1sESmiR/L0WgfMwZko0yr4rFdgtFyXiF6Qb8eGUfFpC9VWiRoux/ief5uQpbb6QIJKe16K5
	4pUlWreyn0OVFOnO/r48u2pIQyB+mpCiZNb0853QGyTq0+i1OJDF25g/+sE6A44pyLdZJgMke34oK
	f28PqIlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFTVi-009fss-DR; Wed, 11 Jan 2023 05:18:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFTVY-009frI-Il; Wed, 11 Jan 2023 05:18:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AB6568BEB; Wed, 11 Jan 2023 06:18:36 +0100 (CET)
Date: Wed, 11 Jan 2023 06:18:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-apple: Do not try to shut down the controller
 twice
Message-ID: <20230111051836.GA16576@lst.de>
References: <20230111043614.27087-1-marcan@marcan.st> <20230111043614.27087-2-marcan@marcan.st> <20230111045402.GB15520@lst.de> <fc2e03ea-5404-e768-0cab-e95adcde6da7@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2e03ea-5404-e768-0cab-e95adcde6da7@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_211840_789356_9D71DE23 
X-CRM114-Status: GOOD (  26.91  )
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

On Wed, Jan 11, 2023 at 02:10:42PM +0900, Hector Martin wrote:
> OK, so the first question is who is responsible for resetting the
> controller after a shutdown? The spec requires a reset in order to bring
> it back up from that state. Indeed the PCIe code does an explicit
> disable right now (though, judging by the comment, it probably wasn't
> done with the intent of resetting after a shutdown, it just happens to
> work for that too :))

We need to do the reset before banging the registers to make sure
the controller is in a sane state before starting to set it up.

> Right now, apple_nvme_reset_work() tries to check for the condition of
> an enabled controller (under the assumption that it's coming from a live
> controller, not considering shutdown/sleep) and issue an
> apple_nvme_disable(). However, this doesn't work when resuming because
> at that point the firmware coprocessor is shut down, so the device isn't
> usable (can't even get a disable command to complete properly). Perhaps
> a better conditional here would be to check for
> apple_rtkit_is_running(), since apple_nvme_disable() can't work otherwise.

So on a resume the controller should have previously been shutdown
properly, and this shouldn't be an issue.  Does the apple implementation
leave some weird state after a shut down?  In that case the resume
callback might want to do an explicit controller disable before doing
the reset.

> Alternatively, we could just revert to the prior behavior of always
> issuing a disable after a shutdown. We need to disable at some point to
> come back anyway, so it might as well be done early (before we shut down
> firmware, so it works).

So the disable before shutdown doesn't really make sense from the
NVMe POV - the shutdown is to cleanly bring the device into a state
where it can quickly recover.  While a disable is an abprupt shutdown,
which can have effects on recover time, and might also use way more
P/E cycles than nessecary.  So if you always want to do a disable,
it should be after shutdown, and in doubt in the resume / setup path
instead of the remove / suspend one.

