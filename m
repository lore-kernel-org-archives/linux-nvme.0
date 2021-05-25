Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5974FC2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:03:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F185661408
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F185661408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KiQJvPQR5VbP3IuNeLzLgX2PJANwK6NI82GnnCjvmS8=; b=Ot8QEtwHrPyhcj
	n2Y/H6jN6yDfm0uqi3ocpIU3RPMujPLbQzux/j+KwwMhDtTzg42hoQlu8AyqXMRP20wLvUoDfXn19
	SLyNKPb9q5kg5AO1hYsnN7Ulc3Z/3zIXq4GzGDreragApBfJttJySQFTREXl0rUkMoaO/cdHs+LbS
	6qhoAqNkGps6Kz6xZ4BxrERpd4TAAMPOxJ7Z3fkplKfRsAnlCQ9gTnh54kLzWUoT8ZBhn+RO1CZMs
	+tZY4buhSp4u1yM3oprvnsgpV9bTSdeZKAFCO5H5IeOdpqClucA59aleYfUdOT4b1BplkN0Q9NRyL
	80EQ1oPD7CFxjYxdxXQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llaSU-006gZ1-NI; Tue, 25 May 2021 17:03:10 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llaFT-006ZxU-AY
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 16:49:44 +0000
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1llaFP-0002aa-0y
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 16:49:39 +0000
Received: by mail-lf1-f70.google.com with SMTP id
 i132-20020a19868a0000b029029da805524aso109352lfd.20
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 09:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YJaCYdrDxV6hFjr7P9dKxuwmpFAJtjJ9oxxDaSIJ6Go=;
 b=FuZTQWbLhfjzSQ1PjjWIGYwDac/Z+vbEbU8QOntyME7KZ3fLChf7ZwbDYiL2eMqhBQ
 0N8MQ65nyJaVcZV+qHSVpvLcbpmjWoEIv2ID0VlzYA6irTJJdDzhtPTqy+3519R7Mi2m
 jogwSPBP6yStSE8VUxZwXfO019qYKbI8jlx17Gfj4weF/3T52fVAk30dlSo1HsTMFbph
 mScGkkQgi8anj6a6jyi54ZDMkwAiKrs6/kMvRrHgVdtraGdr6ivYhWmZyTeLrHJ+NwD2
 S8/lfaFvd89sHN7Dg8Vs7+OiSisC99kHTe9I42RCbxOQt/LvqdL4ywD4NHRRuUsidAYr
 wJ3A==
X-Gm-Message-State: AOAM531QuIdLXWkmh3DnEB9ZkQCUeUHfZ+Asz/c7a8FB73BqEOXgKO1n
 ja1V22rf9xGWzj/iYpG0zMPzGH87AAgkWj+hPb5mYkdBLth++48PMeuvOUP0UzajU9WQkQhoxVH
 KR9Ucr4s5i1hIH7YrLH9QTLxxtHEv2yscFkr3eVFKzhNr8tUZWtSyt2z5IWav
X-Received: by 2002:a05:6512:1153:: with SMTP id
 m19mr8111641lfg.290.1621961378502; 
 Tue, 25 May 2021 09:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymQiimH+CbsO7SXttRtmgzlQND/9nKiElblzw2Wx5kB4zclyWI8q+1Em3tAhbyMgEgXsZlONs6r6p26Y0E4nY=
X-Received: by 2002:a05:6512:1153:: with SMTP id
 m19mr8111630lfg.290.1621961378269; 
 Tue, 25 May 2021 09:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
In-Reply-To: <20210525074426.GA14916@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 26 May 2021 00:49:26 +0800
Message-ID: <CAAd53p7Qw1d+P_SirjOT=6YLvap+OLGAgdeW7dyMUwbqdHHfyQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Christoph Hellwig <hch@lst.de>
Cc: Koba Ko <koba.ko@canonical.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, 
 LKML <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_094943_428623_461BD1D3 
X-CRM114-Status: GOOD (  21.39  )
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

On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > After resume, host can't change power state of the closed controller
> > from D3cold to D0.
>
> Why?

IIUC it's a regression introduced by commit b97120b15ebd ("nvme-pci:
use simple suspend when a HMB is enabled"). The affected NVMe is using
HMB.

That commit intentionally put the device to D3hot instead of D0 on
suspend, as the root port of the NVMe device has _PR3, the NVMe was
put to D3cold as a result. I believe because the other OS doesn't put
the NVMe to D3cold, so turning off the power resource is untested by
the vendor.

I think the proper fix would be reverting that commit, and
teardown/setup DMA on suspend/resume for HMB NVMes.

Kai-Heng

>
> > For these devices, just avoid to go deeper than d3hot.
>
> What are "these devices"?
>
> > @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >
> >       dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> >
> > +     if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> > +         !pcie_aspm_enabled(pdev) ||
> > +         dev->nr_host_mem_descs ||
> > +         (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
>
> Before we start open coding this in even more places we really want a
> little helper function for these checks, which should be accomodated with
> the comment near the existing copy of the checks.
>
> > +             pdev->d3cold_allowed = false;
> > +             pci_d3cold_disable(pdev);
> > +             pm_runtime_resume(&pdev->dev);
>
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?
>
> What is the pm_runtime_resume doing here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
