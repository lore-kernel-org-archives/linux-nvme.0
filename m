Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D214C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 18:15:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93062311F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 18:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93062311F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wfnVSwh7/MbzktHDnMbRtN4Fd357HD/Wq8OsDtLT3eM=; b=l7PDdzgA+VdQUxxGKgAk0qVf7
	C0DAgVN/7FemyaXg9kVlEB9tQ8pfyQXLtNnTs0GDDNwkFY/Kqrp4fSikbUP6GI5csvVopQ7fpfVoi
	fKU/pSre4qSg0KtvNuzDAaFGUbvo8Qx65Omnh3rVydSSJmU8hz4ahv8luKdMMoI4leUe5aMpjkDUP
	I5GUAjAlcS0kvHV1gNmG03fl7woerDF9PHYYVJtfqqGqxwOtqth7ODBO6FXMP/bSsaj5GQaTjpxwN
	360ScWVdVuORjqzq8gRldE477Tqt7ItjYgzKi3zq16Wq191PKpB+CTaE1Btv3GnMEzVDqXhmU78/G
	SxKKpyXCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l079V-0001zJ-QC; Thu, 14 Jan 2021 18:15:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l079T-0001yY-Aa
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 18:15:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D60B623A34;
 Thu, 14 Jan 2021 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610648118;
 bh=hAUBgiDtExkiehoc5111RbcuGGdeOOxUj5RyXtGHXGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HemYMtqS4hHt6OB6t7976tNhzEZBE0ja+tZL4LEkkFeU1YqV/ZEtOiOkP+2EHaQRF
 TgDPU7xAyswYvrLdG3fAiDPp5DwkVXmV3sPJbIvSkCU++t2JwDfFoMgg16MfxUrA0A
 iWv9UlXRASh+7pBUsw6s3KWRAi6NgZjU3rVAKStj/Q/n3LHcul7p7ojrtkMMZJgqPb
 pHvySSyNfZHZuaG4vEjmTDszNUWQesw2sotnloNbIJpTT+0EOB1OEhVVnfBUUjGBvv
 uq0l6Kf5fxNl8/KS7abP9QP/TLrHRoo+r5dXbEE68HAoNOcN8wPeeQBqXnVcYb61/A
 Cx08IcD6AI78w==
Date: Thu, 14 Jan 2021 10:15:15 -0800
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] nvme: allow use of cmb on v1.4 controllers
Message-ID: <20210114181515.GA1511450@dhcp-10-100-145-180.wdc.com>
References: <20210114132441.193782-1-its@irrelevant.dk>
 <20210114180600.GA1511435@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114180600.GA1511435@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_131519_426153_0AA049EF 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Jens Axboe <axboe@fb.com>, Klaus Jensen <k.jensen@samsung.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 10:06:00AM -0800, Keith Busch wrote:
> On Thu, Jan 14, 2021 at 02:24:41PM +0100, Klaus Jensen wrote:
> > @@ -1795,6 +1796,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
> >  	if (dev->cmb_size)
> >  		return;
> >  
> > +	vs = readl(dev->bar + NVME_REG_VS);
> > +
> > +	if (vs >= NVME_VS(1, 4, 0)) {
> > +		if (!NVME_CAP_CMBS(dev->ctrl.cap))
> > +			return;
> > +
> > +		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
> > +	}
> > +
> >  	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
> >  	if (!dev->cmbsz)
> >  		return;
> > @@ -1805,6 +1815,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
> >  	bar = NVME_CMB_BIR(dev->cmbloc);
> >  	bar_size = pci_resource_len(pdev, bar);
> >  
> > +	if (vs >= NVME_VS(1, 4, 0)) {
> > +		cmbmsc = pci_resource_start(pdev, bar);
> 
> Shouldn't this have a '+ offset' in case the CMB doesn't start at the
> beginning of the bar?

One other thing, I believe pci_bus_address() is required instead of
pci_resource_start().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
