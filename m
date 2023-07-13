Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04072C001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCvvUNYvnCDYxbtzBXcI0/VOI4w7KStCcFmdCMjQhJ4=; b=EZT84YLWPPybAN020W7ZGO0ihU
	c6RUd/pHOiVQaVVcjUdz523L/43b0BsWH81e4u1UKv9wxB8B39V2L0exvaIWvq22Yzh9RgzE6bSIm
	u803NiQP/745nI+vJ8luNuBoaJSGsQARMXxXZz8fb+UVBD+zXinMo166hTdipwd3eQGYENitrDccH
	PIJsooyx3Fr/ejAamCE2do6EGLB9hFK7fF2HDzZUe0DcRl/PoTcAAWTYBl9Z8GX5CpjqIv6Auwb0t
	m3uKOCuQy8OzHr/AFEInOOsE0Ys8iLfMUEjZRaJ20huUBqRkk6ICdffprMi/z1SOaeVrky61mZSCV
	ul7L+hSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJuk9-0037oK-0T;
	Thu, 13 Jul 2023 11:44:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJuk7-0037mu-09
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 11:44:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E91E668AA6; Thu, 13 Jul 2023 13:44:12 +0200 (CEST)
Date: Thu, 13 Jul 2023 13:44:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	=?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <20230713114412.GA23427@lst.de>
References: <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com> <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com> <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de> <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com> <20230712164546.GA31434@lst.de> <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com> <20230712165721.GA31965@lst.de> <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_044419_232867_5FB2747F 
X-CRM114-Status: GOOD (  11.04  )
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

On Wed, Jul 12, 2023 at 10:34:05AM -0700, Linus Torvalds wrote:
> That's a *FACT*.
> 
> You then say "Some devices have UUID's, so all devices must have UUIDs".

Please stop putting words in my mouth.  Maybe instead of shouting it
would help to actually read the text?

You said we've never seen devices with reliably IDs, which simply isn't
true.  And that doesn't mean I'm saying all devices have reliably IDs,
which somehow you're not trying to make me say.

