Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1733C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXKAz8BUzEljkv9OVy0xEtlUFkO6+vKoySNbNgIstWs=; b=ICvYbGfomAMDXL3S8tAO1sEbtS
	XvJQvLls4HUW+hUjJpgn1KWbXdcBGW1Voto+clPX0NZGNHu3KyuSnALtt56aqL6T61gqPIcMxgq1q
	rEfgVgyrM3bawdobQnTrSJZWQ7ci2PpP6wGlpqCU9Ix5y4E3oEhfUXJRnOGWIJ2Sbej1uf4HOX7RG
	1el8UeYYhu3UiJw3BahZ+1dAmoGmpd00KwDQ1GqhS9PDrW0d8FwFKTZl+zrKfagNagJ4SNdnq7ILd
	lMJpKL0Hx1qAp7UHHc8A2Si58SRB1XxADHRr9Io/RAMWIYWF/WTsrg/fthW6MsOsL8Tfrv3bp15Vk
	4vTt726A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cFx-004fuM-6R; Fri, 23 Dec 2022 07:14:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cFt-004frv-Qy
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 07:14:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 157B56732D; Fri, 23 Dec 2022 08:14:02 +0100 (CET)
Date: Fri, 23 Dec 2022 08:14:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221223071401.GA4588@lst.de>
References: <20221221101050.759606-1-hch@lst.de> <20221221101050.759606-6-hch@lst.de> <Y6N913AdRwkbyuAD@kbusch-mbp.dhcp.thefacebook.com> <20221222085737.GA13174@lst.de> <Y6R54M2/wQWK5Htf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6R54M2/wQWK5Htf@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_231410_209832_BF7B65AF 
X-CRM114-Status: GOOD (  17.15  )
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

On Thu, Dec 22, 2022 at 08:38:08AM -0700, Keith Busch wrote:
> On Thu, Dec 22, 2022 at 09:57:37AM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 21, 2022 at 02:42:47PM -0700, Keith Busch wrote:
> > > Just noticed we need to mask out the CSE value for IO commands in case
> > > some crazy controller sets it. If the driver were to see that value as
> > > non-zero, it will freeze the IO queue the ioctl requires to to submit
> > > its own IO request.
> > 
> > I'd rather reject passthrough of I/O commands with that effect
> > entirely, does that sound reasonable?
> 
> Sounds good to me.

I ended up to actually implement your suggestion of clearing it.
This does not block command execution, and we already warn about
unusual effects.

