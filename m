Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A5C5DF89
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HG+w1DQEAVcs6RiLkfNA1By0YIoXNNBrKRdrWn3H1rg=; b=LszO1/1Ey7AJprx+oYnat3AHka
	VpemnBCS52LwZbabnKprHeg6XosOzZlJl8nizt8xi1VNXkjVDah/NtoHRwwQO6gADunWu+lWzdBdf
	8PYdrqqcTfXfrG6F8YVutTEVTttpzj3kwsGOtRcQbtwPdfdw6tIuhg31tcyHSbXGSqrFXddcamzOg
	hv+dkFyTwrXA8DzNCSqIMnEuzjHBSpoUaocJqBJFrCgHvgEfVkHeYRy5FICTntg14VQ3+2Hip5lnr
	opyVK+ckpMBhGPavMoGLMSOOZbdzqrH3exN2VfghnLe2/2I0PRtCoxA+V/Gx9cvgg8mJuOU0sEpOr
	Hanv5kxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQ4o-0000000DX9G-3rme;
	Fri, 21 Aug 2026 14:18:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQ4n-0000000DX8r-2oH1
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:18:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18AFB43280;
	Fri, 21 Aug 2026 14:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8609C1F00A3A;
	Fri, 21 Aug 2026 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321913;
	bh=HG+w1DQEAVcs6RiLkfNA1By0YIoXNNBrKRdrWn3H1rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLR7P3NE9e38Czh6gi34d1veREoMQmlBIPdtdouKQYQUx+WqafNraXXAIU7/BxNej
	 aKlnffpXnGnPFVhF5QR7o86ftpU2bO6uICVQH37f/uYNbWvz9EhEhNvIcjlVb3IIHf
	 syXEN7iesUYvFvrf2y/5zD5FwGIV3nkowLSJX5Pf4k+53efy+7G+JnxiwgTWf+JIth
	 wYS5a2ZTUQ+jjiyGb59uFd6+7VE7ZSId42+xCGVvezCHXjBv9ryzDS0c2Kuz0xrevt
	 A+mopIUl3nq3kFaLhRausf6RkYn5ea9Gez59iOpt8sqnPHE8uG5OTCvOBGbZUzl1mO
	 MTTeooBUlVA2w==
Date: Fri, 21 Aug 2026 08:18:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoheN_L3iJNU3Ji6@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohQ9NcuMtSqWvvd@ryzen>
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

On Fri, Aug 21, 2026 at 03:21:56PM +0200, Niklas Cassel wrote:
> On Thu, Aug 20, 2026 at 09:23:10AM -0600, Keith Busch wrote:
> > On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> > > 
> > > I am not following.
> > > 
> > > The options is freed in two different places, depending on if the
> > > ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> > > successful or not.
> > 
> > Oh, not that path. You mentioned previously that ctrl->ops is
> > dereferenced in other places. I thought this means we can successfully
> > add the controller, which means the attributes are visible, but then
> > fail something else later that causes the opts to free. Since the
> > attribute was visible, something can open it before the device exporting
> > is torn down, and access it after the opts were freed.
> 
> Sashiko flagged another NULL pointer defererence from the sysfs attributes:
> 
> "While the sysfs attributes are still fully accessible, an unprivileged user
> could concurrently read an attribute like hostnqn, causing a NULL pointer
> dereference.":
> https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com
> 
> This comment was on Rihyeon Kim's patch proposal.
> 
> I assume that this is because the fc.c driver (both before and after
> Rihyeon patch) force set ctrl->ops = NULL before nvme_free_ctrl() was
> called, so a user reading the sysfs attributes at the same time as the
> controller was tearing down, could most likely crash the kernel.
> (Note that neither rdma.c,tcp.c,loop.c does this, so this problem does
> not exist for them.)
> 
> sysfs_remove_link() is called before ctrl->ops->free_ctrl(ctrl);

When ops->create_ctrl() fails, the opts are freed from
nvmf_create_ctrl(). We can still fail ops->create_ctrl() after a
successful nvme_add_ctrl(), so the handle will be visible to user space
for a moment.

I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
to be the final reference, but it might not be if the character device
was created and someone opened it. If so then:

  out_put_ctrl:
     nvme_put_ctrl()   -> refcount 1, NOT zero

So now when nvme_free_ctrl is called sometime after nvmf_create_ctrl()
freed the opts, the ctrl is pointing to freed memory.

