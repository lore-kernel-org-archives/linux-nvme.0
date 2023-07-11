Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF8EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/topdIQwdOaJ70o93+/PisYqJWSPfOE39Mh7Z7JdIhs=; b=FbGa/xaX84VLVBwcoNBUoF6pkS
	WSm5Vp++oalqqsuRsHdwJ5esg3QW30iebdxGoliAm35ZtrHpBEF1/B8SWGqYQbMNc/nfRDAeBUHlG
	Wnnq8nx9y/y4xO9al530M/QnQonJ89dF4cCs9no+zLLO22M2dXX97uUAXpVrQ/ykY9rs2KttX0HSe
	oTu9vsjst63S+Mqyg7spC7oK0HrqcGwzoQ45mJALoi7hFdyFA7Q/0zVKsQa1qYdXcspEn2eDKg+4J
	juxX5XJVo9RCoJQr4Ewvyd5UuiBYMVJWMxOU3iAB8nOmcV3weuGrmkn7WNkCS7XK6wbQkyc6KdsS2
	4F/0Sslg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJC8L-00EpMA-2X;
	Tue, 11 Jul 2023 12:06:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJC8I-00EpL3-2Z
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 12:06:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1466867373; Tue, 11 Jul 2023 14:06:10 +0200 (CEST)
Date: Tue, 11 Jul 2023 14:06:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Keith Busch <kbusch@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	=?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <20230711120609.GB27050@lst.de>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com> <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info> <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com> <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com> <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_050618_982215_6B2AB404 
X-CRM114-Status: GOOD (  15.04  )
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

On Tue, Jul 11, 2023 at 11:39:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Well, that "They keep pumping out more and more devices with the same
> breakage" and the "new device" comment from Pankaj below bear the
> question: should we stop trying to play "whack a mole" with all those
> quirk entries and handle devices with duplicate ids just like Windows does?

As far as I can tell Windows completely ignores the IDs.  Which, looking
back, I'd love to be able to do as well, but they are already used
by udev for the /dev/disk/by-id/ links.   Those are usually not used
on desktop systems, as they use the file system labels and UUIDs, but
that doesn't work for non-file system uses.

And all this has been working really well with the good old enterprise
SSDs, it's just that the cheap consumer devices keep fucking it up.

If we'd take it away now we'd break existing users, which puts us between
a rock and a hard place.


