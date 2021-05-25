Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F49C47086
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:15:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF98A611C2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF98A611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=ylJAMeJ4JpK3jFg2B5gCFHFPYnYyzF2zdrH9StEKWCE=; b=XKoTjl0f820gJT
	Xddevj6gYKoNSmlfmuLiDfi7J66sRZcTUmxYXJ37/O3eC7mV9JD/+Gbq1Tz759QVTKInFL7KkCC87
	RY6spdwjc8M715Fbdekk2MKhkiLhY+Y7PZ0YCXXH/MDHCtNzj4xxexF6NI3mwDzrKoEowTpnxHvfh
	/7ACdFUEdSy/2ewYoEAQ0uiODtUAfuJD0S9VJ1Inb6tG8gkQkY3/CghyE8dyEkr+TTCZsAMUdqf6l
	gSaEtBBygRkdLBAhvOGmvLvtoA2xyi9KWfC4TQcWREo3Oq1MUJKO3Ofgwa7Snok9sCD0FEkyvmIBr
	ijHd/qkvcjlF1zn0BMxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldS1-0081kf-QO; Tue, 25 May 2021 20:14:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldRs-0081h5-Ab
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 20:14:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 794A4611C2;
 Tue, 25 May 2021 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621973683;
 bh=4eLLwykJYynzNm459FPtdgPrTAnn33wst0rMYCkOU6s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=HTWN/rIH0T/pNnwNyFsmSHoaGAH/eZSEHCY9TvoNATshqQLMhl0teiRI0WWBpwZqo
 /bmKOorVeE+rogPlzyTi3mzuo1i6tZoD3VOhBOyQ2J5k7/TnqAzex1xGRoLZIrlEDQ
 uvMBuOn0uxShN4BuhRj2xehSEwzm7+9vVc4B6GUk0i4/E6dy5/u7wH86Py7rjVabY9
 mQbeF//j/sHo/wNPcxsvChia0YhPvYUTTY0B4lToMNvXal5v8IrhCaisqCjZU/oGWc
 MFF2zsQSHIQMAOSiSYXJCyp58er5N+OV9f7l6h4Q6i7heSLHa97+XlKvfUAy1phPdK
 XlyyWGG/xw6Xw==
Date: Tue, 25 May 2021 15:14:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Koba Ko <koba.ko@canonical.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210525201442.GA1223038@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210525074426.GA14916@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_131444_451925_BFEC835E 
X-CRM114-Status: GOOD (  15.27  )
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

On Tue, May 25, 2021 at 09:44:26AM +0200, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:

> > @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> >  
> > +	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> > +	    !pcie_aspm_enabled(pdev) ||
> > +	    dev->nr_host_mem_descs ||
> > +	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
> 
> Before we start open coding this in even more places we really want a
> little helper function for these checks, which should be accomodated with
> the comment near the existing copy of the checks.
> 
> > +		pdev->d3cold_allowed = false;
> > +		pci_d3cold_disable(pdev);
> > +		pm_runtime_resume(&pdev->dev);
> 
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?

Ugh, this looks pretty hard to maintain.

I don't see why setting d3cold_allowed=false is useful.

pci_d3cold_disable() already sets dev->no_d3cold=true, and the only place
we look at d3cold_allowed is pci_dev_check_d3cold():

  if (dev->no_d3cold || !dev->d3cold_allowed || ...)

so we won't even look at d3cold_allowed when no_d3cold is set.

I don't know why we need both no_d3cold and d3cold_allowed in the
first place.  448bd857d48e ("PCI/PM: add PCIe runtime D3cold support")
added them, but without explanation for that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
