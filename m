Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C5C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YhMuwxHqfosW3sDO+A+XNbEnO/HpuOv59r7ZSdjm4Q8=; b=ihDJ+xf6Ie5ig2aIOv4lp7dDp5
	LQfUxDPD2H3cm1VlIVbphximbPQcHa6xzX6OeXR8DNJhS/2LbzkpT3fxx+NPcx2yPglyjvOVBEE8B
	ZGugYXl7I/LLQFwcjcYqlLc3Dtfiu3EwLXrMfqHmp8Pz0RllQw2iaEHD2W1kKiaQ2BasIeYS8ETVm
	4nralAsFEI+7V7G4vfJgOLqD4zd6h1mNOEMm6z68KInKtdPQqIObQ0TVo/kBXvgGtwrt96cKXFbB0
	RMFPpH7Vj3a9RspsQKAZiv8Hq0N0JAYgqfgnSAzdPkIH3teuJtc1h1ay4RrQgQ3SNIDnJVbV4qB6y
	9GQzyBng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1cCm-00Go4r-Fa; Wed, 15 Jun 2022 23:13:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1cCj-00Go2M-NS
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 23:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655334814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhMuwxHqfosW3sDO+A+XNbEnO/HpuOv59r7ZSdjm4Q8=;
	b=fBN6s6pP4m2CDcTPhVVmCItNEMHPURBaS4uFFa9AGuYZ84vhMobdhVjH9WCcv2f52X4w6l
	pAU5jGx6vdzEtQcCpaCRjO4k4QZIXlXYHlcbO/lwC0KgXySgKc9ugJkCxXN2uyfxP/6/K7
	HdGdGIiBfigOKCd1xMaS7n1hv5F7xGg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-gyBUCM1FPcK81zBf_6ImeA-1; Wed, 15 Jun 2022 19:13:33 -0400
X-MC-Unique: gyBUCM1FPcK81zBf_6ImeA-1
Received: by mail-pl1-f199.google.com with SMTP id n8-20020a170902d2c800b001663868e2c2so7216386plc.21
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 16:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhMuwxHqfosW3sDO+A+XNbEnO/HpuOv59r7ZSdjm4Q8=;
        b=IyPDV3D8tuZ+BvG5LkGk7j4ejegY8oLmVzMzURHMQkWI5xzHMCVmBYw25Y8EQm0Np/
         Rw7imNrHyf2SRyegt6HQTAWEJSFLgEtdt2yeIqUFqnDNFJJzmlyoJ843DilCgLu53qdD
         jtoAvfP9Q7GV/ULXpeMcGz5oVMS0JUsw1saBHyPB8LqFCbqc01XTl5UvU6lswCXDOe/1
         1W5R77+IhbVUJYDBwkEINsobzHyMdCDej/h88LDtOlv5Qkq8WQ2tEREG+l1YAc0WHdA3
         /57XgUM/93G6VbeESu+nfXidLhpVeBWoKwJyO/704djSH9unO5wtdjIjjiGitrwg7U4Z
         1Kxw==
X-Gm-Message-State: AJIora/FTCtVQsjT10TMmfqh1HyKwXSEdA1MUSqtEkl2vFMtBge0jA6+
	yVItB7qwT5inhGAC1QgPF8F4U3zKrNF71d7/y5dzvSRvnuu+vgLbhDZoWM5MNYIK0WHAB1M5Iol
	ynhUDHhmqiC9eKrd7ZHEyi5NQM2SWSpRmclP5m7XINeE=
X-Received: by 2002:a05:6a00:2291:b0:51b:e4c5:627 with SMTP id f17-20020a056a00229100b0051be4c50627mr1837923pfe.20.1655334812016;
        Wed, 15 Jun 2022 16:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sg+mVCN3WuVePBvyzN+o71gqddvsTeRC94xefuc698SvRbjp423NUsbHPJxu4Wg5t3ZOUyX2uinaLerv8Pyyg=
X-Received: by 2002:a05:6a00:2291:b0:51b:e4c5:627 with SMTP id
 f17-20020a056a00229100b0051be4c50627mr1837892pfe.20.1655334811679; Wed, 15
 Jun 2022 16:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615194727.GA1022614@bhelgaas> <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
In-Reply-To: <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 16 Jun 2022 07:13:19 +0800
Message-ID: <CAHj4cs88gLYMMefQVrH_+kSsrZhV+VJa5yapEaYXc1Cjnd2w_Q@mail.gmail.com>
Subject: Re: blktests failures with v5.19-rc1
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "mstowe@redhat.com" <mstowe@redhat.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_161341_881641_909C46FE 
X-CRM114-Status: GOOD (  34.33  )
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

On Thu, Jun 16, 2022 at 6:01 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/15/22 12:47, Bjorn Helgaas wrote:
> > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> >> On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> >>> Shinichiro,
> >>>
> >>> On 6/13/22 19:23, Keith Busch wrote:
> >>>> On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> >>>>> (CC+: linux-pci)
> >>>>> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> >>>>>> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> >>>>>>>
> >>>>>>> And I am not even sure this is real. I don't know yet why
> >>>>>>> this is showing up only now, but this should fix it:
> >>>>>>
> >>>>>> Hi Keith
> >>>>>>
> >>>>>> Confirmed the WARNING issue was fixed with the change, here is
> >>>>>> the log:
> >>>>>
> >>>>> Thanks. I also confirmed that Keith's change to add
> >>>>> __ATTR_IGNORE_LOCKDEP to dev_attr_dev_rescan avoids the fix, on
> >>>>> v5.19-rc2.
> >>>>>
> >>>>> I took a closer look into this issue and found The deadlock
> >>>>> WARN can be recreated with following two commands:
> >>>>>
> >>>>> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> >>>>> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> >>>>>
> >>>>> And it can be recreated with PCI devices other than NVME
> >>>>> controller, such as SCSI controller or VGA controller. Then
> >>>>> this is not a storage sub-system issue.
> >>>>>
> >>>>> I checked function call stacks of the two commands above. As
> >>>>> shown below, it looks like ABBA deadlock possibility is
> >>>>> detected and warned.
> >>>>
> >>>> Yeah, I was mistaken on this report, so my proposal to suppress
> >>>> the warning is definitely not right. If I run both 'echo'
> >>>> commands in parallel, I see it deadlock frequently. I'm not
> >>>> familiar enough with this code to any good ideas on how to fix,
> >>>> but I agree this is a generic pci issue.
> >>>
> >>> I think it is worth adding a testcase to blktests to make sure
> >>> these future releases will test this.
> >>
> >> Yeah, this WARN is confusing for us then it would be valuable to
> >> test by blktests not to repeat it. One point I wonder is: which test
> >> group the test case will it fall in? The nvme group could be the
> >> group to add, probably.
> >>
>
> since this issue been discovered with nvme rescan and revmoe,
> it should be added to the nvme category.

We already have nvme/032 which tests nvme rescan/reset/remove and the
issue was reported by running this one, do we still need one more?

>
> >> Another point I wonder is other kernel test suite than blktests.
> >> Don't we have more appropriate test suite to check PCI device
> >> rescan/remove race ? Such a test sounds more like a PCI bus
> >> sub-system test than block/storage test.
>
> I don't think so we could have caught it long time back,
> but we clearly did not.
>
> >
> > I'm not aware of such a test, but it would be nice to have one.
> >
> > Can you share your qemu config so I can reproduce this locally?
> >
> > Thanks for finding and reporting this!
> >
> > Bjorn
>
> -ck
>
>


-- 
Best Regards,
  Yi Zhang


