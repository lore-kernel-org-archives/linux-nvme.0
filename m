Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793AED767CF
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 14:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNVBYGiHCXieUiDNBWh5uakT8XJGQed4Ig92Y/dhp4Y=; b=qkgfkOgq4sbHZ+yWR/s0lvXrPh
	vBxMXuC/BYEgvws1zyBuFR0V1qHUghPvIFE8tX8Ue+cKAm1U6zJJ4OcTV6rwPbuStLNg3eZHjuQM8
	Or+sHiiee206ROgjAn262FSzYRbcl+o54/GUbdt+r29FZRLOlPShe7Nvjs1CZHMegwqwFBNtScK+V
	rn2a1HwqfAY7fuvlQVnZZSVd8mpRCbhyMboOnHbfGSIE6fg6VzcAiGyuzn3QQtiDDx1y2hWsg3I05
	9U/53unxtLthF1EMqExZZ4zcm6ISHQ130eCy1oVrtQx6WdPxAWLWyOPfs95NDyTG8dy43QaQQwsA6
	P6PbehFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Vom-00000003kwO-1Bxm;
	Thu, 31 Oct 2024 14:06:32 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Voi-00000003kw1-1G5V
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 14:06:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EA22DA4328A;
	Thu, 31 Oct 2024 14:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5CC4FF52;
	Thu, 31 Oct 2024 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383587;
	bh=Muuu1WqyPpcP/xIjgoC6z8E8xeJtiugg598fNvNyN/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yajt8S6AC7lJXMJrgMLEU3WjiH6d4vU7KU0GM5nIxrxzkAw/O57yMJU7wWVVXTkNR
	 rY7sX5J9AIFrLXPtjGtoazojQ9YMoRazK6YBgLm/ELf+L+vJloJIS1QHBNTvOQnyzK
	 /l78HsUM4nNyzQrlqs8HL8HhaIy5TS1lfMc4hSDpq69PpZOzCBGlWoXYC+1wImnmbN
	 1YmgKCBdtkdZ+PXXHKzy4NmGvZwLiLJ9w0WFhqCqoV1tjb6rO1Inv5xcZOPlxoYUIG
	 SxWpP4CQAvW8UfWHyswYpaL0doLT2p3x8cHDslxjtZ6pL2ZtNVyfw6FDnII5RTIBDO
	 OiNIopie+Riww==
Date: Thu, 31 Oct 2024 08:06:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <hans@owltronix.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyOO4PojaVIdmlOA@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de>
 <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
 <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_070628_421335_4CD530B9 
X-CRM114-Status: GOOD (  17.28  )
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

On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> On Wed, Oct 30, 2024 at 11:33 PM Keith Busch <kbusch@kernel.org> wrote:
> > That is very much apples-to-oranges. The B+ isn't on the same device
> > being evaluated for WAF, where this has all that mixed in. I think the
> > results are pretty good, all things considered.
> 
> No. The meta data IO is just 0.1% of all writes, so that we use a
> separate device for that in the benchmark really does not matter.

It's very little spatially, but they overwrite differently than other
data, creating many small holes in large erase blocks.
 
> Since we can achieve a WAF of ~1 for RocksDB on flash, why should we
> be content with another 67% of unwanted device side writes on top of
> that?
> 
> It's of course impossible to compare your benchmark figures and mine
> directly since we are using different devices, but hey, we definitely
> have an opportunity here to make significant gains for FDP if we just
> provide the right kernel interfaces.
> 
> Why shouldn't we expose the hardware in a way that enables the users
> to make the most out of it?

Because the people using this want this interface. Stalling for the last
6 months hasn't produced anything better, appealing to non-existent
vaporware to block something ready-to-go that satisfies a need right
now is just wasting everyone's time.

Again, I absolutely disagree that this locks anyone in to anything.
That's an overly dramatic excuse.

