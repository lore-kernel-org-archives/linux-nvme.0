Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4DD1D88B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/t5Hz36k5vHmVstN2d0QqKY+mi1kS8hdsxZQaTHKHo=; b=ZlakC1FVax3izJKowaY56mY3gX
	Cw7M/F4Y/mfxBish9dYz7OgQzvc1DWlv80/mLIWRtvq+6m8mZh06AuiXFKZ3lwdriWuP3cfpSdDEG
	CWg3ZRw2MDRlKQ/CyNt4CS8CPuLyC7W/+jR4hPR03FG+cK1umiRgI3Ax54CDAnM4L6dKjE1ZoZFcA
	wwY3dIXNazuIMZj3WzNtAWvM90cAeYNq8qyamo+5mZT5RLYr3cwlrUpNQo0J/zKUpYrduRuIb4e+d
	AIRV6EzcUmgDKr7t6PCzmkrqOroGLgLRh/aImkNsPrC7ch1FvvG+SFiTzx1wywvcdeTLJ3+URJB8h
	EqR5cRSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0lnf-000000096ZX-22w0;
	Tue, 15 Oct 2024 17:57:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0lnc-000000096Yf-2DOO
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 17:57:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3E235C4D6E;
	Tue, 15 Oct 2024 17:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68855C4CEC6;
	Tue, 15 Oct 2024 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015054;
	bh=Rb6FCDK6ozZd0ZqvfKsSI+cqqRcu05euBErMWPKrivc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge5pVHCwl/GdOhQIGVPab1p46kjqKPMfrru2pOmIulqiHY9lctCizux6yBPUx1UOt
	 IM2ngD/MmlkHQ0D+j3vVLy1kNHeA7rfBJm426mu/qXm3/Gpv7N9+wlhxA37pnbVMOG
	 wXyTDrScW9i/hWoTonfrIenSLboZJdwt0MQ9EoW5pJ7RbUFtxbxzKqD0Q49bQ50YqG
	 ebPV1twaG10jsh581ElqNvwvUMk9jpw4RSA2ppbDbfuEpJVczxDOi2KBLAV2kkcELg
	 SSRIkhHOyGIAVjf40lxC60qR2qoNGaa5iO62I9IL06p5DS1+41EJa1CAW2FeERxi5p
	 210iA91NTOknA==
Date: Tue, 15 Oct 2024 11:57:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: fix race condition between reset and
 nvme_dev_disable()
Message-ID: <Zw6tDKuibIDwCHer@kbusch-mbp.dhcp.thefacebook.com>
References: <20241015112100.824193-1-mlombard@redhat.com>
 <Zw6l_A742J3iCYLR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6l_A742J3iCYLR@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_105736_630781_3B6F4BD8 
X-CRM114-Status: GOOD (  13.74  )
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

On Tue, Oct 15, 2024 at 11:27:24AM -0600, Keith Busch wrote:
> On Tue, Oct 15, 2024 at 01:21:00PM +0200, Maurizio Lombardi wrote:
> > -static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
> > +static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
> >  {
> >  	if (!dev->ctrl.tagset) {
> >  		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
> >  				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
> > -		return;
> > +		return true;
> > +	}
> > +
> > +	/* Give up if we are racing with nvme_dev_disable() */
> > +	if (!mutex_trylock(&dev->shutdown_lock))
> > +		return false;
> > +
> > +	/* Check if nvme_dev_disable() has been executed already */
> > +	if (!dev->online_queues) {
> > +		mutex_unlock(&dev->shutdown_lock);
> > +		return false;
> >  	}
> >  
> >  	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
> >  	/* free previously allocated queues that are no longer usable */
> >  	nvme_free_queues(dev, dev->online_queues);
> > +	mutex_unlock(&dev->shutdown_lock);
> 
> I believe mutex_unlock needs to be above blk_mq_update_nr_hw_queues().
> That function needs all the queues to be frozen, so any older IO that
> times out is going to need this lock in order to reclaim it.

Oops, unlocking there doesn't solve your problem. I guess your patch
should be safe as-is since the nvme driver already waits for the freeze
prior to updating the hw queues.

