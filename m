Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC45C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642E661284
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E661284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B99vuSf45CqxDmpOutyDBxFbdyY2V5cMyJdZbA/Ky1w=; b=JLGdP2/kA+RN4n
	OSGbdpYYZ5nFLqEA6jMNpghGSTl2PKVda+z82EO8HYZ60i+NEd78WEhkQKmUhT1vSA8rTTeVvvpWS
	rPupOil55nSCZXOQHMARLoc1WTBk0OnBOC9DhkyAmvaGFftw/ATICsqrhjnBoXqCjO10+zwdLJIkE
	HXM1N9O1TgDzWY3utMCHuCaMZP1NaPwpr3R0XOXZNMMHOuAak5YMp9nIlV0IE1wHAG8lCue4A7b4X
	nCYsMwXRSvWq5bJYddQRuHfPZONunex5GHglCGe3x1z1NM7AqMSxKLHbysBBtTNZ4lAnX0cdogdWO
	aBh/E4OGpbxEuUDtKZ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvyP-00FZsm-AC; Wed, 26 May 2021 16:01:33 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluoi-00F2ql-AE
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:47:29 +0000
Received: from mail-lj1-f200.google.com ([209.85.208.200])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lluog-0001Oj-Hg
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:47:26 +0000
Received: by mail-lj1-f200.google.com with SMTP id
 m3-20020a2ea5830000b0290109369442e2so586836ljp.18
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tKkeDIyfg5tbUDNJPi4NgjfV5qFGc/eyNl9E9obon3I=;
 b=b15pEtUCMygrL0RzUIW9MH78R3Vu+DPeTXUwNRnp5HBRuoWPj4hYRqjEwpVWr6nm47
 VFFilqkg4VfnC7VXObZ4bW7iG3xNiZDj0aTlAk+Ba/7/AeVShndb6pEDw/c/PhCUOpLH
 dAPf+M0McrpkdCkuaTK6TofEqRhsbkN1aarnum5x+3Zq3c0zPYKnkNu+eHKJXudNiL4C
 iKI0YEYh8+7u/kDVH1jGja7r9Ki26N+mtI0HBZp1ptJaLDzyDuwukY+b6l0YWuDKvkjp
 lblnNoC4Lm+PA7OPbVip2tAdnEo2wdYXApp3XM7/eOlL5ZcGpxGsqovgvcBTw4/6SfSg
 6pBA==
X-Gm-Message-State: AOAM532NRdYKjqChKW45tZFIo0dtNKSlLGVQqmo683cvW+gPdfVDv4Jf
 iMgSZf6zT+aeTs0SRTiKl+pIHSAy8cX308bvnLigNhwh/gXXAA3HUvAjqhI2q99q5b9EvXbMkMF
 P6OR6ihcKNXWLc6aGwMMnbGK0PAEp7CHzyO99TQ1SsxbTT77Mh3Bo305n2lsJ
X-Received: by 2002:a2e:b892:: with SMTP id r18mr2494557ljp.402.1622040445850; 
 Wed, 26 May 2021 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLrPOwOay/G7viPPeObhmAqhusdasfgLFHKjudG5zu7fmIP7duHluGrol4HR6UOtuCA0uo4/HyjqUPvqVsicI=
X-Received: by 2002:a2e:b892:: with SMTP id r18mr2494540ljp.402.1622040445600; 
 Wed, 26 May 2021 07:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
 <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
 <20210526125942.GA25080@lst.de>
 <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
 <20210526142809.GA32077@lst.de>
In-Reply-To: <20210526142809.GA32077@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 26 May 2021 22:47:13 +0800
Message-ID: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Koba Ko <koba.ko@canonical.com>,
 Jens Axboe <axboe@fb.com>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_074728_431391_A9D89D85 
X-CRM114-Status: GOOD (  21.27  )
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

On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > at D0, which gives us a faster s2idle resume time. And now AMD also
> > requires s2idle on their latest laptops.
>
> We'd much prefer to use it, but due to the broken platforms we can't
> unfortunately.
>
> > And it's more like NVMe controllers don't respect PCI D3hot.
>
> What do you mean with that?

Originally, we found that under s2idle, most NVMe controllers caused
substantially more power if D3hot was used.
We were told by all the major NVMe vendors that D3hot is not
supported. It may also disable APST.
And that's the reason why we have the host-managed power control for s2idle.

IIRC only Samsung NVMes respect D3hot and keeps the power consumption low.

>
> > Because the NVMe continues to work after s2idle and the symbol is
> > rather subtle, so I suspect this is not platform or vendor specific.
> > Is it possible to disable DMA for HMB NVMe on suspend?
>
> Not in shipping products.  The NVMe technical working group is working
> on a way to do that, but it will take a while until that shows up in
> products.

Hmm, then what else can we do? Because D3hot isn't support by the
vendor, does it really stop HMB?

Kai-Heng

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
