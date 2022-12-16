Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5010DC001B2
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//AYjWNd7M/fRvBeWYx7VGVGzPWWWJjJodt0rC6Rb8c=; b=DjGQM3yPOk0GJ5KUobmR8Ne6XI
	PxQ44zNhRWk3nFEgxq8w5JJWXBKejOhMrwrbDDkvaByye+4GKp0fOIsBOIEhFlTbMfvcZWhm6SHFx
	on3rl0F+8ECTi8ebecvb1+PKjW3XMNGl3WBNwzgMPNZWKOR/n41Etx4tF0YDnjixHKjc5sxc2raCF
	vlrjiBJuysG1je48WudCtlVCkLvb8JvcYZlOnd9JHdWNbBPlsIFg54b0XSkbksguvp5TRFlz7gL99
	Cf184BSSJcwnAVoMPd91dMDwGF+IJ3pUWNURX+qHrWzQBat2aDx4SMeXDa5D5bDZDfviezS3bKmGs
	StuqXuUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6G4r-0004Jp-95; Fri, 16 Dec 2022 19:09:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6G4k-0004Gq-Ti
	for linux-nvme@lists.infradead.org; Fri, 16 Dec 2022 19:08:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3435F62179;
	Fri, 16 Dec 2022 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36666C433EF;
	Fri, 16 Dec 2022 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671217732;
	bh=0WXGIb/8Y1+aNBgwXqWMEVjNXs/1R0BJ3t9P0zvL1a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgShStxiufaoUmZ3+hAntkdXoJmKAVje2jormyTTLp30ApdE73cyDNkJf6Zxe76BP
	 0GQfWHrfniREXDyZBts+gb03wPm2cLbmYYR50Xam9oh7T6k5Usy7I3hQ+KIU1fom0p
	 mTjBvgfdZXBBXxAelLQu/HVe76koQMwwlZNdkM53d88lmVtroSZuOQZZy6DFD/laEw
	 dGH9HSpk10ciyp0W5EQZLUCvu59cb+z4dqqr9uJntEpp4BBiHuD9zNVOtObwFXZsNw
	 WRS9y/6iKgd/iGZiYQqv8IBIln8y28vGLN1OSrm+XvTe8MYxyuQpqi5VkFc3XfryN9
	 DyI+sSvupwEZw==
Date: Fri, 16 Dec 2022 12:08:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "J. Hart" <jfhart085@gmail.com>, linux-nvme@lists.infradead.org,
	axboe@fb.com, sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y5zCQVp+3zvN/DI0@kbusch-mbp.dhcp.thefacebook.com>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <20221215082344.GB3816@lst.de>
 <d4c4eea9-e573-df0c-cca5-536bcff6c0a9@gmail.com>
 <20221215090941.GA5062@lst.de>
 <3c22a234-f042-4859-a3ab-f911874696b1@gmail.com>
 <Y5tambspBYRHU5B4@kbusch-mbp.dhcp.thefacebook.com>
 <581e0725-93cb-b796-e2c6-455737cc8ea1@gmail.com>
 <20221216063953.GA24390@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216063953.GA24390@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_110855_042463_56815D9C 
X-CRM114-Status: GOOD (  22.93  )
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

On Fri, Dec 16, 2022 at 07:39:53AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 07:30:55AM +0900, J. Hart wrote:
> > I've tried the obvious ones and that didn't help either.  I guess I'll have 
> > to give up on it and return it as defective.  I'll go back to normal 
> > operation and to try and find a controller/device combination that works 
> > with the linux driver if there are any.
> 
> So on the hand I agree with Keith that the device seems really broken.
> On the other hand the fact that source file system on another device
> sees corruption even with the iommu enabled is something that looks
> scrary.  Even if ultimatively caused by the device somehow, that seems
> like the kernel is part of the corruption.  And I have absolutely no
> idea how.  A KASAN run on the device might be helpful, but I'm also
> reluctant to ask a reported to run more reproducers and something that
> corrupts his data.

Oh, I assumed the source was a different partition on the same flakey
looking device. If not, yeah, that's pretty concerning.

How do you know enabling Intel IOMMU in the kernel config does anything
here? I didn't see anything confirming the kernel was actually using it.
I know this CPU model has VT-d capabilities, but I believe the platform
may disable it in BIOS.

