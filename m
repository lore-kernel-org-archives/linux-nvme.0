Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950AACE8D6B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVvPqaflgD3zq1gAMWAEEd3+uC6uZRgwMlGcX4JdXHM=; b=Se4noiybgxPnhG0YmGdJGSQXRJ
	WHl5wBruxz06/j3JzThEiLooANhhe/7Ke5zfZO1Zo2+fOGZdgvTWTo1p1IMI49+8IhFINEGKs6DHW
	gv24z4Z0G8/bRkpluWOG7LFp6AN8nPv65u3TdcRct4gzycTaFj5BWgU4FCSVk2eiuxj6OlOyx9Lq6
	2X9y5sz41zzkb2xbPnlDVu4ITJHnx5NWNsuTobe1NMPb3gajrTeADhsZN+M9zduI8/2a+o0CiX/Qb
	oNRuBkuZrv47ntZhZi7hTfo0eVNB8gPwThxnxqisUHqJeX93AXoFU9dhMdRjHtGSocPiJujWLkeKK
	CXdN7Q2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5Q2-0000000Gnos-234E;
	Mon, 17 Nov 2025 20:01:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL5Q0-0000000Gnof-3APJ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 20:01:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E15CB601B6;
	Mon, 17 Nov 2025 20:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A4C4AF0B;
	Mon, 17 Nov 2025 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763409703;
	bh=lHKjnHmwld4J7UpdFKFeqpdnk+sIlNnF2boW1e9EfYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxz27avfTpyBV3WFr9fOPyqhVvxz89VNv4Hiz8xg+q0g/Mekwy2Z+jeba4zQFsNJ4
	 XkmcRiEONR14SZwWBRhhj8ydjJCsDypBS6V4zm+PK2xoDPCcZ+gTRicF/wmJpkzLu7
	 YwCRujVaWY60OGCR+6TvWC1oIDnHLdmqf0iZFUSSk5DmQc6/W3Z/IAfi9n8ycsx4/o
	 EWCCP/PVZjf9r3DEHKpU9tG4mBcZ8p7IEWo5uzxoV5iRAhJKqgQBn8maIwEIgsW44J
	 4zm/2rHXw5z6uavy31Cimy8EhB4sI0pURkBMd55PXbOHOInjA99pZH5gv2annPwy0s
	 CItIkgbfMqiCA==
Date: Mon, 17 Nov 2025 22:01:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251117200138.GE147495@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <aRt5DPnMwzDw8_dF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRt5DPnMwzDw8_dF@kbusch-mbp>
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

On Mon, Nov 17, 2025 at 12:35:40PM -0700, Keith Busch wrote:
> On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index e5ca8301bb8b..b61ec62b0ec6 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -290,14 +290,14 @@ struct nvme_iod {
> >  	u8 flags;
> >  	u8 nr_descriptors;
> >  
> > -	unsigned int total_len;
> > +	size_t total_len;
> 
> Changing the generic phys_vec sounds fine, but the nvme driver has a 8MB
> limitation on how large an IO can be, so I don't think the driver's
> length needs to match the phys_vec type.

I'm big fan of keeping same types in all places, but can drop nvme changes,
if you think that it is right thing to do.

Thanks

