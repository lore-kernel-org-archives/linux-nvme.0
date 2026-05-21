Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC00CD5BAC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhouoNuzjn3A7z/GOH6jqaeY43mfOgBaBThRAC7bCnE=; b=uwEgmI+JMsIdBxG2FvWdILK64W
	YI4mWMKZxhijFheHyxADyrA2RrKZsAVinscjAMQN3SqyNBPxoVHnt1GvaQwr5FPqhJQubfOYbOS16
	LnysFDS29a7pL0l7RvLDTiV6YUEJ5XD80pZdXSq8f5x5JyHKIlsxvbf/IvALUhwcNbsrAc3oEU5or
	WBB+k6vhXoB2ROhf1W2+cBfRvvgfI/Ukgz4eJkXiVyun4Ue6eyhLxENT72Bt4eG6FpLssskJSf8SL
	wScGkmFrt6LaRCpHWxGQzEbFVIigGweykKZ0kKhcbYedkLNnlynFWcXz/MBamQlIg1zRO6CEVH99T
	pjXJupKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gp-000000088LI-0Uyh;
	Thu, 21 May 2026 14:47:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gj-000000088JW-3tmK
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AF9B424C9;
	Thu, 21 May 2026 14:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D661F000E9;
	Thu, 21 May 2026 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374873;
	bh=dhouoNuzjn3A7z/GOH6jqaeY43mfOgBaBThRAC7bCnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cF1E7RxE4t0jy5888Je8cHdlBPLvXKGj3W6FrZjtEHdh0h51kuxQ+5NMB2W24HTO7
	 hgqiCrEOugQJZ7qv+wdZI97t4riOzPrU5hIXV9dafOX+SV4JT5mQ7jWvWS8NjgUYZ6
	 OJOODc9sju+VD6Zj7NjTSnYCgW38tHYGx7nBh3VFwnxFgro9z+UOORCwath8VqGKwD
	 PmWFmWnDimlPGK935toCjc0SPe4OUgWZSh263OFLJ+CpVBg6D6MDsfS1T0/5vvmM2f
	 BXleX11MSJ9Le83bjLocd7/dJwPCSfPDbftVrh5ZkXG+xa5OHqJf5FvmJGPgDqqW1R
	 va6QLoEX11FSw==
Date: Thu, 21 May 2026 08:47:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3 1/2] nvme-pci: fix dma_vecs leak on p2p memory
Message-ID: <ag8bF5SLsKbtqgBc@kbusch-mbp>
References: <20260520174953.2989852-1-kbusch@meta.com>
 <20260521082153.GA10917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521082153.GA10917@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_074756_565035_865D11FF 
X-CRM114-Status: GOOD (  18.99  )
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

On Thu, May 21, 2026 at 10:21:53AM +0200, Christoph Hellwig wrote:
> On Wed, May 20, 2026 at 10:49:52AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > We don't unmap P2P memory, so allocating the dma_vec for it was being
> > leaked on completion.
> > 
> > Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 139a10cd687f9..744b388eea956 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -966,7 +966,8 @@ static bool nvme_pci_prp_save_mapping(struct request *req,
> >  {
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >  
> > -	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev))
> > +	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev) ||
> > +	    iod->flags & IOD_DATA_P2P)
> 
> Missing braces around the & for our usual style?

Thanks, fixed up and applied.

