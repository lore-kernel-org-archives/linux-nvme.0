Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8979FC27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLXku6z8QAeGbZ3Nm21f3Bl0Iwtsp6RIb+Pn4puJwIA=; b=r6oZIa0DUdlHP2Q3SKDv84QsFK
	ZrGOcHpZA9XFSQ8hIvaUatHQ/7e9gAPUPbcapTDq2WSjXlL8UflSHJaYTC15fk2lEZ3QOJb2WEMUC
	TDUgSTqH2P/xPQ8CxpYy5/VxqcY+3usxV1M463iSP5CCdcgVxxinAUhZMz36056Gbdy5Ul3Jb5Dke
	kA3XQ14gVUuEZB/XH51PyFbXM2BYmp8Je0JOMIBH1HEodVXtldZ+VrLgtJxPtszLT54MaSLIX364F
	rsboEQRZ1djSBMM9QnKQ19WgwBPkQHYckqfF6VV7H8Kp0ROEDUmWnZLpyLhepoVEb1gVlYrVMfikN
	ZPdGBQpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHAC1-0000000AQpP-3ne8;
	Tue, 11 Jun 2024 22:42:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHABz-0000000AQp1-1CZn
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 22:42:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5953ACE1EAD;
	Tue, 11 Jun 2024 22:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53DAC2BD10;
	Tue, 11 Jun 2024 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718145732;
	bh=J/PtuM//jTUpq8kjPKvF1m8x0SCGtXAq1/oKUHXQS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n31nSjSR0vyCzISPXok7loBVXdsPk+KfWjzVQLmq5szc0e5ufZmmNtXeeeboH/JdI
	 9lUFimLBwAhKrq5nFTbHHxkBsZjdmdIcDc3Rbddc8l4IUBrbIO1gpfFma076Vowv1j
	 OZqUeYuTmU0QYlcrFN5YXpY5HiY6xuF1m4QR8vrJvX7AMPXG+/lvcqSrjGVmd82+O1
	 ljfm5UG87Skpqi3rmU/fc9scPEYule4zEm73bz9ll2GE+dlfOH8Xk3DPY2LuntXd9T
	 bizdXU3hXGIfOPEEc+QTJ2OnhwoDQJ7WQPpEVSc5Wl8HFqf03wKu++I2bYKE6q5Bnp
	 PPB473NM4UthA==
Date: Tue, 11 Jun 2024 16:42:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <ZmjSwfD1IqX-ADtL@kbusch-mbp.dhcp.thefacebook.com>
References: <20240528150233.55562-1-joshi.k@samsung.com>
 <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
 <20240608051740.GA24010@lst.de>
 <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
 <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
 <20240610115541.GB19495@lst.de>
 <ZmcTHMWb-T78Crfn@kbusch-mbp.dhcp.thefacebook.com>
 <20240611054726.GA2680@lst.de>
 <Zmhf9-CaUe4gD9Kl@kbusch-mbp.dhcp.thefacebook.com>
 <yq15xuf1fnm.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq15xuf1fnm.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_154215_760862_B5E21A47 
X-CRM114-Status: GOOD (  24.21  )
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

On Tue, Jun 11, 2024 at 03:43:11PM -0400, Martin K. Petersen wrote:
d
> 
> Hi Keith!
> 
> > One thing FDP got right was mandating the Endurance Log: the drive
> > must provide a feedback mechanism for the host to know if what they're
> > doing is helpful or harmful.
> 
> Good luck teaching firefox what to do with that information!
> 
> > If you're just blindly throwing random fcntl hints, then you're not
> > the target audience for the feature; you're expected to iterate and
> > tweak your usage.
> 
> And that's exactly my point. What the various attempts at data
> management in the specs have in common is that they are unsuitable for a
> general purpose operating system and its applications.
> 
> We can all come up with a restrictive model which works beautifully for
> one particular application. No problem. But that's not what standards
> are supposed to be about! We used to produce specifications which worked
> for every type of application and device.

FDP isn't a user distro level feature. This is expert level, and is not
reachable by default; you really need admin know-how to make a namespace
that recognizes these semantics. The machines that can reach *this*
feature are most certainly headless servers, so consumer use cases
aren't considered yet! All in good time (maybe).

And as I don asbestos underwear and dare say, Linux enables enterprise
storage capabilities for filesystems not reachable for the average user
(DAX), so we (Linux) are not exactly fencing off difficult to use
features. FDP doesn't even require new kernel interface changes to wire
it up to filesystems, so there's no additional maintenance burden here.
From a pure block and NVMe maintenance point of view, this is nothing.

I do have gripes with the *kernel* interfaces, though. Mainly that it's
per inode which makes this useless with raw block IO. We started FDP
with the passthrough interface, and that proved usage produces
meaningful gains, so hooking this into existing data separation provided
by fnctl feels like a natural progression despite its limitations.

I think enabling such experimentation can only help make these
interfaces become better and enlighten future protocol changes.
 
> It was a beautiful thing when we went away from cylinders, heads, and
> sectors as tools to do performance management on storage. An abstracted
> model for managing blocks that has worked for everything from USB flash
> drives, over spinning rust, to million dollar storage arrays. With one
> protocol. For decades. And still going. Because the abstraction worked,
> and it removed the burden of having to care about device implementation
> artifacts from applications and operating systems alike.
> 
> We need a similar model for data management. Something which works well
> enough on the device media management side but which transcends one
> particular application or device implementation. I really don't believe
> any of the currently defined data management schemes are timeless the
> same way as LBAs have proven to be...

No disagreement here!

NVMe 1.0 defined Read/Write CDW13 DSM field with what I think are almost
the desired semantics. 12 years later, no one implemented it, but mark
my words: we'll circle back to something similiar in 12 more years.

