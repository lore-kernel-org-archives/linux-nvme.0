Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0910CEACDD
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ASFzS7ZYkxeige83SFjEiH5Pw6zk75UY0VTIdQW1bg0=; b=B0xFQD7LYPTruNKUJolzLhQyYI
	RuagDqoWDjAb42ovd7uEwFXqaviPYxYGBlwm1TqLj2BurVYt8aPmyIoXVPAJnGcSoSawPR8OV+4Ru
	8W7WDFf36ulgt/riv+BObs2CRyuwerGlbKkR4H0AN+qZFNVeFytb2SwFREMt4S+iBcIcSdiKT1O6U
	CNzQ67hD+pxNLsJBbsE+qu+rG+3h/7ZcoPD6yD/7q/C14HP2VEbhGg3nHhXpajHh57/oxAGDPxQXZ
	HpJAJG5wbp2cIu8CE0QRC5UO6XJDul/XGnds1+52tj0afoRCW8PrhAs7mP20U+VCq9NnlTZZDojzz
	z/wM+brA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svewv-00000003La7-1o5Y;
	Tue, 01 Oct 2024 15:38:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svewN-00000003LPR-1GUD
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 15:37:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3E26E5C0F7B;
	Tue,  1 Oct 2024 15:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82091C4CEC6;
	Tue,  1 Oct 2024 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727797050;
	bh=XBFt+lN55keQTEfhyTVFuCqjDhRK8NSUj6BMZjb+tK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK/fIkxoSH6VW5Ach0U0AessLuQMkVM+e4T0r06/srnyrFf18bGE/J462pJGtZ1oI
	 zxVR3bGCh0ni06pQJGGd6hX3QFXC78YNLlEWnxvVm9soyrVJKToLrbKEb7uZbUAHDh
	 scSrTd72Nr3z/FuQIwG1AoHOomzqyrUN9krPGnVUq6j0LLaB8ZQo5NCxAQQPaqotx3
	 2Sx9fo3meBhyKj6PkYBfZcjF2vESQS3+i339YNhUtJBMTZw8fNJ3cZUgvoMfHUaeqG
	 hN34RQeJpQ4SKurejJL/zhcToGJswA4YP8eBfPUI9/YzXPgmykpOFC2d4zEl4R5zjG
	 3QAzf1SrSwOew==
Date: Tue, 1 Oct 2024 09:37:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
 <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
 <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
 <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
 <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_083731_405106_3025290F 
X-CRM114-Status: GOOD (  25.23  )
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

On Tue, Oct 01, 2024 at 09:27:08AM +0200, Javier González wrote:
> On 30.09.2024 13:57, Martin K. Petersen wrote:
> > 
> > Kanchan,
> > 
> > > I spent a good deal of time on this today. I was thinking to connect
> > > block read_verify/write_generate knobs to influence things at nvme level
> > > (those PRCHK flags). But that will not be enough. Because with those
> > > knobs block-layer will not attach meta-buffer, which is still needed.
> > > 
> > > The data was written under the condition when nvme driver set the
> > > pi_type to 0 (even though at device level it was non-zero) during
> > > integrity registration.
> > > 
> > > Thinking whether it will make sense to have a knob at the block-layer
> > > level to do something like that i.e., override the set
> > > integrity-profile with nop.
> > 
> > SCSI went to great lengths to ensure that invalid protection information
> > would never be written during normal operation, regardless of whether
> > the host sent PI or not. And thus the only time one would anticipate a
> > PI error was if the data had actually been corrupted.
> > 
> 
> Is this something we should work on bringin to the NVMe TWG?

Maybe. It looks like they did the spec this way one purpose with the
ability to toggle guard tags per IO.

Just some more background on this because it may sound odd to use a data
protection namespace format that the kernel didn't support:

In this use case, writes to the device primarily come from the
passthrough interface, which could always use the guard tags for
end-to-end protection. The kernel block IO was the only path that had
the limitation.

Besides the passthrough interface, though, the setup uses kernel block
layer to write the partition tables. Upgrading from 6.8 -> 6.9 won't be
able to read the partition table on these devices. I'm still not sure
the best way to handle this, though.

