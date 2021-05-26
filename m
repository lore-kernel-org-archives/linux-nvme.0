Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C5C4707F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 02:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BDF6101B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 02:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BDF6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jy8dCsnM0YOUnlTM0jCE50tZi1ovWyu9mhvc7Km50dk=; b=VUqPgb6DtB5Tag
	h4hvR27Hv+NAJwLkdKkuFlVMbwVpw8RVn5+BscBHfAvQ0ztDifmwdxGBlQ56B5oISR4IsBjZDRwW/
	afAyLt1kt+ZQxdJMyZKjYSS8rpB+ouIpD8wNf8OPHjuyBX+7FBVBOrvJjGsF/RGRujD6a/xwbgx3w
	lcwB4VwSF5J3moF2HtL2E2CYgp+jnDcIKoroo2Q3f3FBZR2s8fI/9L2/IFNIi/M5rRrEBtQq6Y2rq
	Fv7eU9OzrTFaPjl+MT7trwWeWaFs+m/Bf2R0Z/3iI94N3nqniS6O+2IrIjuPbo5/x5Co/N499HTBj
	LHesEbJyc/fQdUr4Vd0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llisg-009z0s-Ir; Wed, 26 May 2021 02:02:46 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llisd-009yyu-TS
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 02:02:45 +0000
Received: from mail-ot1-f72.google.com ([209.85.210.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <koba.ko@canonical.com>) id 1llisa-0007Q7-67
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 02:02:40 +0000
Received: by mail-ot1-f72.google.com with SMTP id
 59-20020a9d0dc10000b02902a57e382ca1so23027031ots.7
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 19:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=80Q9luL+LwQCDuf3BgkOvtEc2OIfkbeDzIrwJ3hVNYg=;
 b=qOz+bSImtLM5evgm1glcBkmtCHNViGFR4u4ckp48cu3Nxu7ava1+aCEtpeW3aCGR8i
 QA2CKf6SLa6kqk95E9vniBUsjB2yWWaa2TOFrbU8jhmQekh86LECgR71atj2ZrV8OMvc
 0gelbw3RGCQbdK43+mqtNcIybyl6HVZeZq06QVSEoCNHIrcjPUpE8YzPwaMCq3XRwuIL
 CgfeWbs838D5bOo/4PgYhBJc71yKUqymfqqv9NE5cW0NuKob7mMvToGMEq62YFTW/CS4
 F62DoPf696FmK7Uib2j6EKNI7KRyIzJqWsiqkqSS8dexmcoGCWwXjEA4MjyhFXf3rJJ5
 7/nA==
X-Gm-Message-State: AOAM5319fpQ1GZ6CyYcv5z5oKyHE6F8T0DkdFp25WhNVjM0FoRykgpNI
 Nnli8whvK6BIJtVxTtdWfp/249M6iMkupWqLycWyHDyR9QvujCpuAswJd4/P9Dt75r3sJjx7g2s
 KRCqL7naIBDIP+Hit2M73TdvdnorHnWp9Eae+v/sP9C0k95IBc4ruz0RQ9vqZ
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353837oif.17.1621994559114; 
 Tue, 25 May 2021 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVyQJj1wQcjhyCbkjhZWLHzSkdMbj1UW7fzQW9m2Wo4G/waP+Gb8xrdYJnlCIdJUeKJb5TO7XDHgGKxBL1qrs=
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353825oif.17.1621994558803; 
 Tue, 25 May 2021 19:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
In-Reply-To: <20210525074426.GA14916@lst.de>
From: Koba Ko <koba.ko@canonical.com>
Date: Wed, 26 May 2021 10:02:27 +0800
Message-ID: <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_190243_993577_130D0475 
X-CRM114-Status: GOOD (  24.19  )
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
As per Kai-Heng said, it's a regression introduced by commit
b97120b15ebd ("nvme-pci:
use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
the target nvme ssd uses HMB and the target machine would put nvme to d3cold.
During suspend, nvme driver would shutdown the nvme controller caused by
commit b97120b15ebd ("nvme-pci: use simple suspend when a HMB is enabled").
During resuming, the nvme controller can't change the power state from
d3cold to d0.
    # nvme 0000:58:00.0: can't change power state from D3cold to D0
(config space inaccessible)
Tried some machines, they only put nvme to d3hot so even if nvme is
forced to shutdown,
it could be resumed correctly.

As per commit b97120b15ebd , the TP spec would allow nvme to access
the host memory in any power state in S3.
but the Host would fail to manage. I agree with Kai-Heng's suggestion
but this TP would be broken.

>
> > For these devices, just avoid to go deeper than d3hot.
>
> What are "these devices"?

It's a Samsung ssd using HMB.

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

Thanks, I will refine this.

>
> > +             pdev->d3cold_allowed = false;
> > +             pci_d3cold_disable(pdev);
> > +             pm_runtime_resume(&pdev->dev);
>
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?
>
> What is the pm_runtime_resume doing here?
I referenced the codes of d3cold_allowed_store@d3cold_allowed_store fun,
As per Bjorn and search in multiple drivers, only pci_d3cold_disable is enough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
