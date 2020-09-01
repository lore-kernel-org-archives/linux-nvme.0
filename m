Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D11C433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:16:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB73220767
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 17:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="skrwp0i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB73220767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vijbp73Jh5Gb0G7cVnHTti+keCg7wueDYxLY8NGfkFM=; b=skrwp0i/QRiin6/Y/Yj+brt6A
	mmVbkVkmvcU8IH73Tl37UQcGK1bKCTKkGDBlgz0UnAkx8bfDyeuSi8lSXqabumF66f816BJLczWLW
	Cqjbe0AtF6n9LTRoas0u5tYhPk6uOQB8sUCdeBgPri8hmaFA7q8gE+SjdADCUti8OpKPATmDS21Gr
	I4JF13K5VkY1UgPHByqygS6LE5RfmMlThA+j5Em8I9add+cmFe9BYPFLysY/tgb1wtp10gS2rYd8d
	1uchtELDRRg3o3K3qBdN5tM27bNLSFwHiJl0o/BrDgjPOTnQUc9ihhC/H7fkfnZo9wQTxFEcnuF0+
	8kZMDdz6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9tc-0003aU-2u; Tue, 01 Sep 2020 17:16:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9tW-0003Yf-S5; Tue, 01 Sep 2020 17:16:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 48CDB68B05; Tue,  1 Sep 2020 19:16:27 +0200 (CEST)
Date: Tue, 1 Sep 2020 19:16:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Message-ID: <20200901171627.GA8255@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-23-hch@lst.de>
 <20200901152209.GA14288@alpha.franken.de>
 <20200901171241.GA20685@alpha.franken.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200901171241.GA20685@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_131631_133376_438C0DE6 
X-CRM114-Status: GOOD (  22.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 07:12:41PM +0200, Thomas Bogendoerfer wrote:
> On Tue, Sep 01, 2020 at 05:22:09PM +0200, Thomas Bogendoerfer wrote:
> > On Wed, Aug 19, 2020 at 08:55:49AM +0200, Christoph Hellwig wrote:
> > > Use the proper modern API to transfer cache ownership for incoherent DMA.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  drivers/net/ethernet/seeq/sgiseeq.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
> > > index 39599bbb5d45b6..f91dae16d69a19 100644
> > > --- a/drivers/net/ethernet/seeq/sgiseeq.c
> > > +++ b/drivers/net/ethernet/seeq/sgiseeq.c
> > > @@ -112,14 +112,18 @@ struct sgiseeq_private {
> > >  
> > >  static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
> > >  {
> > > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > > -		       DMA_FROM_DEVICE);
> > > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > > +
> > > +	dma_sync_single_for_cpu(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> > >  }
> > >  
> > >  static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
> > >  {
> > > -	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
> > > -		       DMA_TO_DEVICE);
> > > +	struct sgiseeq_private *sp = netdev_priv(dev);
> > > +
> > > +	dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
> > > +			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
> > >  }
> > 
> > this breaks ethernet on IP22 completely, but I haven't figured out why, yet.
> 
> the problem is that dma_sync_single_for_cpu() doesn't flush anything
> for IP22, because it only flushes for CPUs which do speculation. So
> either MIPS arch_sync_dma_for_cpu() should always flush or sgiseeq
> needs to use a different sync funktion, when it wants to re-read descriptors
> from memory.

Well, if IP22 doesn't speculate (which I'm pretty sure is the case),
dma_sync_single_for_cpu should indeeed be a no-op.  But then there
also shouldn't be anything in the cache, as the previous
dma_sync_single_for_device should have invalidated it.  So it seems like
we are missing one (or more) ownership transfers to the device.  I'll
try to look at the the ownership management in a little more detail
tomorrow.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
