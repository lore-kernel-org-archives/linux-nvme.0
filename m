Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78360C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 12:08:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F4D610A8
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 12:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34F4D610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHF97q/4AEO6bTkSh4lAvpR8gBGLOmgMNHolg7c14W0=; b=Jv0MoU2s+sq/LG
	J73LIrvL+iba996g18pm44/in48Fs1f4zMu7FKQ0mp/A/aCgB1czWCqTR55+TDv7/ntRTPxe4VDUi
	UTLSl1DwTawjMs9pkdNEyaoZ1V/mxXDEiJZSmdTRpyifv0aJ2VhyaTqx3EAKDzCwTexqAPas0ngQC
	vHwd9YhdUhRWClcI5akR999j6e+ljC4ACQDJIBJ8c8M5FV9kQzNmLw468lry9G8tsRdOwGijab3m2
	SK3tJMrRKHEtaNWoPr5mLkgTp1rDswBzVtBCGuOlN+xjNX7dcnOmF09fFmNTWs14ROZNkSQ//Es56
	lISfzcD3tvFEuxhUrVzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY5i1-00EAZA-ST; Wed, 06 Oct 2021 12:07:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY5hx-00EAYQ-U7
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 12:07:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9E7C610C7;
 Wed,  6 Oct 2021 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633522057;
 bh=s4JHdW2CM9QkQ+7C4wkq9TGi+/eaVPK0yz6xCy7NCy4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aW7sQPojCbWa17cZlw1R1pZqvbifPe1QcDk5766ipV6yJvjDz0U5CmMqys9xs4poz
 /Me7k5R+jkein8q/SMdMTI3EWx+ZQR7wz1wi0FBvY6s30pr0fJmMC/Tp0iT2YJ199c
 I2yqfk/MWBvOjLGkD/la3S1bX9RPElH2XILzR5BxohbMWqM3eO7PFIjFQ+Ams1xOmB
 jm6EPmce15x58PWqlGyRWBzjKMvpG86Sk7KCj8Qfp2sIEOWuYY//92GgIMuXp0jo5k
 6lUYKOTCBaN/RAZ/manG50GzADCXeuz2qfUw9WHcGelGOjBndsWbB4H/9cx7GrUBob
 QiqKIl6YFAiNA==
Date: Wed, 6 Oct 2021 05:07:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Levon <levon@movementarian.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/3] nvme-pci: clear shadow doorbell memory on resets
Message-ID: <20211006120734.GA417782@dhcp-10-100-145-180.wdc.com>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <YVrKyC9c20Gz4YSR@li1368-133.members.linode.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVrKyC9c20Gz4YSR@li1368-133.members.linode.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_050738_011433_76FFF823 
X-CRM114-Status: GOOD (  23.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 04, 2021 at 09:35:04AM +0000, John Levon wrote:
> On Mon, Apr 27, 2020 at 04:52:41PM -0700, Keith Busch wrote:
> 
> > The host memory doorbell and event buffers need to be initialized on
> > each reset so the driver doesn't observe stale values from the previous
> > instantiation.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/pci.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index cf386c84588b..d388fff9c358 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -228,8 +228,11 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
> >  {
> >  	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
> >  
> > -	if (dev->dbbuf_dbs)
> > +	if (dev->dbbuf_dbs) {
> > +		memset(dev->dbbuf_dbs, 0, mem_size);
> > +		memset(dev->dbbuf_eis, 0, mem_size);
> >  		return 0;
> > +	}
> >  
> >  	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
> >  					    &dev->dbbuf_dbs_dma_addr,
> 
> Hi Keith, we came across this issue recently, and we just found this above
> patch. Was there any specific reason it was never merged?

I don't recall why this wasn't merged. I can't find this series in my
tree anymore, and it also appears that the mailing list has lost the
original patch set. Do you happen to have the rest of the patch emails?
If so, could you possibly send them to me?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
