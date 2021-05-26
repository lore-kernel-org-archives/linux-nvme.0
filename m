Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575FFC47089
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:31:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB2B613D2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB2B613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wd0pPJ4djlNp5ipKDuWBSU+ai9areUYaoXbeyg+GXtE=; b=ZWNirIUYG9sFQK
	kAPpErehfPgmkAcL/Mw2iwpxnjMH9SHsKjEjKpAf+0m8HkYXsz9PHHu14QssX+ia1fr+1pJ6TRDVH
	g0bvEojZ+ae51oVTbiQgB5w20S9dD0zjOqLxd2wFM+BQxcipnBiTST2Ofud9JRQL2blGY4ljsrzJK
	ziGbQHgN/XmJYOWYTwOhqFxNBgooffGMnZRQSqUMb54VVGRdVh01gIEOQwiSL5iXz0rlnKy2ukTMr
	OotXA+J98IXChMSS3cq8M02H1lTbPJEehF/kOs8qBrKzSCsCNdtflMBHfQht/+1T13ttGLwklxpHH
	v4wbiWiCrJugZPYmARJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvUa-00FNvS-Mu; Wed, 26 May 2021 15:30:45 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluQJ-00EpjP-L1
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:22:17 +0000
Received: from mail-lj1-f197.google.com ([209.85.208.197])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lluQH-00082k-96
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:22:13 +0000
Received: by mail-lj1-f197.google.com with SMTP id
 c4-20020a05651c0144b02900d41930170eso555387ljd.9
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 07:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KRO+7j/5yLVMVQTeKppilXzCeyP1PjLQ0t5VspLhv9A=;
 b=AcRK8Y4AvEGpq4+KdJw+f++9uRImhNj5PlUp/DucPcadPN+LJHlNghF6XlTLCRu7lF
 uW9yVrABuUnR5fUc2gPe1uFUllWP0O+yyEsh+VDlO+BbQ3AwlBMcufnM0MdCQzZS6pjV
 E4tR+7AK9/Uk33FbsGGZBYY1TTARFFuMNm4Y+iKfqhxfmSEo15eEI5SatENzN9wtsY5X
 L7Yrzepp66Mg+ayqJ00iDhiPxq7xGkd/7Ey/j5zyDaDicEI4uyFU76RSzRRK/H9aZ94w
 XCYFUWCgdDJoJnkRGrrfqv6xxp9AWJxMIoUWh2N7sRleeIM5RLqXd6CStXn6YOrlkgCd
 pTHQ==
X-Gm-Message-State: AOAM533TGJ3rjpickd++1wc+BZqjYQKcDwnry2iBjCX43lvM6/qakvjG
 dVl1Wdd0S9euSNv6lQ67mpwIdOsg+arjFMlhm5mAGFimVDaaGNctlKG/w6kkNi8oym/nXmvmk0q
 DPemPyZ3Vhg/JAAwFhoI4GSWjmpHIDeapa2p5D/KepwuXAAtgN4vZYeTqJ/yX
X-Received: by 2002:a05:6512:3488:: with SMTP id
 v8mr2271797lfr.622.1622038932738; 
 Wed, 26 May 2021 07:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Ncbz7tk+afIZiBiaVQaJ7SPjwGt7E11q4JRhgLfAPg8wtMkeKE7zuYtCMaSiZwT2FQxkbslAA1z6L4dgG5o=
X-Received: by 2002:a05:6512:3488:: with SMTP id
 v8mr2271787lfr.622.1622038932348; 
 Wed, 26 May 2021 07:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
 <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
 <20210526125942.GA25080@lst.de>
In-Reply-To: <20210526125942.GA25080@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 26 May 2021 22:21:59 +0800
Message-ID: <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210526_072215_744071_FDE976D5 
X-CRM114-Status: GOOD (  27.81  )
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

On Wed, May 26, 2021 at 8:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 26, 2021 at 08:11:41PM +0800, Kai-Heng Feng wrote:
> > On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > > > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > > > After resume, host can't change power state of the closed controller
> > > > > > from D3cold to D0.
> > > > >
> > > > > Why?
> > > > As per Kai-Heng said, it's a regression introduced by commit
> > > > b97120b15ebd ("nvme-pci:
> > > > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
> > >
> > > That really doesn't add up. The mentioned commit restores the driver
> > > behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> > > 5.3. Is that NVMe device broken in pre-5.3 kernels, too?
> >
> > Quite likely. The system in question is a late 2020 Ice Lake laptop,
> > so it was released after 5.3 kernel.
>
> This is just a mess.  We had to disable the sensible power state based
> suspend on these systems because Intel broke it by just cutting the power
> off.  And now the shutdown based one doesn't work either because it can't
> handle d3cold.  Someone we need to stop Intel and the integrators from
> doing stupid things, and I'm not sure how.

To be fair, resuming the NVMe from D3hot is much slower than keep it
at D0, which gives us a faster s2idle resume time. And now AMD also
requires s2idle on their latest laptops.

And it's more like NVMe controllers don't respect PCI D3hot.

>
> But degrading all systems even more is just a bad idea, so I fear we'll
> need a quirk again.  Can you figure out by switching the cards if this
> is the fault of the platform or the nvme device?

Here's the original bug report:
https://bugs.launchpad.net/bugs/1912057

Because the NVMe continues to work after s2idle and the symbol is
rather subtle, so I suspect this is not platform or vendor specific.
Is it possible to disable DMA for HMB NVMe on suspend?

Kai-Heng

>
> >
> > Kai-Heng
> ---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
