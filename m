Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C1CEE0206
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jp1yiK0c2dmZY96LWtQq0IfTcW49sEz+671XVriYzqs=; b=roWeJszyMfz2snkQYRARaU4aWc
	Jo6a5b7gxAsd+XExGvBLE/SZpdQD7R3pi+dSH17lSD1weNjE1qjzIjrJCCXRHMwSF5gYXZryjX/HR
	ZPSAoAAIs0kKny3lHmQM5nw5OBJ9CamSSEsJEY0ZcKjomIRLPzZ8E5gYxty2tHTUyTdnX595fQUJ0
	+1OuvkK+DhPOM97zfhHqWGxKUCt9NRSS6AKErIfQ6Elvt92dJPVKg/n/8GPnZR15Tuxszr/iDHLmY
	5c50FH3mLp4wTQHVrH21U1Ihk+tbg8S3UZYYcl8D7rwgm1rf6XXT2IQ1WqcCy+y7/8HlNFU08Ogxi
	YkRqY7Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQpt-0000000ASIY-1JNb;
	Wed, 11 Sep 2024 17:08:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQpq-0000000ASHm-1xPi
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 17:08:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 63D2D5C073A;
	Wed, 11 Sep 2024 17:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12065C4CEC0;
	Wed, 11 Sep 2024 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726074533;
	bh=JVIh/s4FG9utWyVDfpxXtb9ClNpZP1t8v9T5/D0JTMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5svkaqdBfBRtQUlgREKi3MzW6bpX7NMM3Lta1D6yy4YgZ3jFZ79l0h4XmOp8rtB0
	 P3qzsBRsQ2NZAj+SlDXQ9NAP0yFzPV15kZK/Yvbf6MRBcg/DBrUZCWo84lVzr0Z9lW
	 dF1m6Y/ki2jtEEJh+rvnBBfyQcSG8i2GYrcEqEj278NTb6jHSbdEmipNOravR+6BCf
	 QVnu4hl0LAvuvkVRoknUP49lQWG5fmKW/c4gCjoCkuwioMBzbClK5ITUSYNm+1506R
	 EjfLA+l/dXafyFq9AUy76rCVT0FXe5WIkQYReKadjYubkjM2o+cPwum0oQ/gihVdh8
	 bLzv6LIx/Qi7Q==
Date: Wed, 11 Sep 2024 11:08:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <ZuHOoua40N7id0aL@kbusch-mbp.dhcp.thefacebook.com>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
 <Zt9bLa4TJT6L75aG@kbusch-mbp>
 <191db450152.e0b28690987786.6989198174827147639@collabora.com>
 <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com>
 <ZuCHk6hDxF65v8T2@kbusch-mbp>
 <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_100854_567667_8752B500 
X-CRM114-Status: GOOD (  11.20  )
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

On Wed, Sep 11, 2024 at 05:56:37PM +0100, Robert Beckett wrote:
> 
> given this ~9 year old temporary fix is still in the kernel for the
> Apple device, could we just add another device specific override? I
> could maybe convert it to a quirk that is set for them both (and any
> future devices)

Sure, that's an option. Do you want to send a patch? Alternatively you
can reply with the PCI VID:DID of your problematic device and I'll write
one for testing and consideration.

And just fyi, there are potential performance implications for doing
this. It's less noticable on higher latency devices, which sounds like
what you have anyway, so may not matter much for you. Just getting that
out there to avoid any surprises.

