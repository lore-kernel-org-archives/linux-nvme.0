Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB50C00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCyRj2tUDchGfYfHLYZgcaiT37qYVKxbFPAKBsGFbcU=; b=l9W69HxklM+/rMnAy+IFUjVSYY
	owJAn+J+iUX4V/E+9UMooPWQ3LzEJUGjfJZR8f0fq/vVJKR3gyhD+1nSWwhjQ9HQy6m7inz5Q10Zb
	LOEVQtSy4EXf/s2I8Zzdnmdefqgal+g8snFN4tCZ7aFSozNEgXlrrDDBmyXh6bvPysRZPTW6CpcbY
	C1QeDvyQbYLF2ZUHuYWqreo2MRcF+cwKeHu9Na1wBO5hzhiEqHhVacQ62gI5tlOdtQ/LY++uXYnND
	7QgaujdnBiQpQ2urVC4QlS1Wtk51OpAjD541DAsvN/ghOWzvGSguVo4xP798uesekkzWsrJ0+tdrb
	p4DCmgSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIt94-00F5Em-Mf; Tue, 02 Aug 2022 14:45:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIt91-00F5Cu-IS
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 14:45:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 815D2B81F28;
	Tue,  2 Aug 2022 14:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB004C433D7;
	Tue,  2 Aug 2022 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659451512;
	bh=sWhetUzvJ7YJdojbCTb81eR9JM6DksockUBm57duEmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSyPOdthJ08BaY/4TI3yThp+R86/20F1P0djZ74phYTkdlvvBIiAaElyZIFPX/3/T
	 OXQ8d4/tOs7or03Bbzzr08mo3LXaN3Qfui19YCyOU1E9YyL8ZxVT8za+E4C8tY7wKb
	 +Op8kWWRQQ5un9PGkqzKhM2yPSE8PY4pgewreYI1vCZ2BJhDkC8H7ulBl7scVOOkCz
	 ZpEJqMTLNnDs4LlYWgMVhO6QshD+8Gy49r90NVCwD7ISWemiCHVkS28+n6+S3r19Ra
	 a/bR7STE3+MCmTTc4lG+ks4TxdCMg1V9ZVJzNVAcBuGspNfNxtQmgz1olKhzA11Mxp
	 ZZQRaUArs9XDw==
Date: Tue, 2 Aug 2022 08:45:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCHv2 0/5] nvme-pci: iod optimisations
Message-ID: <Yuk4deNAaroYh5rS@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20220729163601epcas5p1c869a72416f1ec91c2f78c8a906bebe3@epcas5p1.samsung.com>
 <20220729162851.1574210-1-kbusch@fb.com>
 <20220802053449.GA22436@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802053449.GA22436@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_074515_795974_3E370B70 
X-CRM114-Status: GOOD (  14.52  )
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

On Tue, Aug 02, 2022 at 11:04:49AM +0530, Kanchan Joshi wrote:
> On Fri, Jul 29, 2022 at 09:28:46AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The series adjusts the struct nvme_iod fields for optimal sizing. The
> > end result on 64-bit arch removes 24 bytes, from 152 down to 128. We
> > typically allocate many thousands of these, and the cache aligned size
> > is a nice bonus.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> But would you like to reduce 8 more bytes by killing meta_dma field?
> This one:

Hm, yes, the iod's command is a local copy, so it is safe to do that. I suppose
we could use the same idea to remove 'first_dma' as well: it's a copy of either
dptr.prp2 or dptr.sgl.addr.

