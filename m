Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B698C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 12:08:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8BA613AA
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 12:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8BA613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Z6KDs/ZmaEX2lZsbkUAzs/2yyhKpcjg9vj0ZMNVJIc=; b=SiLtdJI7GIHqQ6
	s153YpuHf4DIEdvxG2DjTLbcgNzLALTXZjIMsXC3jM1iJmCqEU7x8E76sJJ1IGA5TqdgoS05qk/NT
	LUHTfC3mhWkKKCefM/UcFxqEY/mcwz9jiYdH3yeKZAKL7+25ZeC4fCaCgcNKiFRhHavDioGWFvVQM
	+C33zav4Bz0eb5FsRV1vKJklaWx4TyE5QZc3x/MSmHzojJgm+/eYhdXKEjAIWjjMtccMKkZD998Ss
	9LotgQ9qslQUXQZqiBXAmePH8C2FHaBl/O12G2QPfAQycnPXSRA0AWitj59ZXpPGCtptvPsURnIis
	FQlep0Imxhv6dgc6SKgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmEoZ-005cMH-NG; Thu, 27 May 2021 12:08:39 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmEoW-005cJf-HB
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 12:08:37 +0000
Received: from mail-lj1-f200.google.com ([209.85.208.200])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lmEoS-0005iG-Db
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 12:08:32 +0000
Received: by mail-lj1-f200.google.com with SMTP id
 b44-20020a05651c0b2cb02900ec3242ba00so136917ljr.17
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kncaMdHs6rlLGylUk3Wdwf3tcaKjfAxUxb/GAcKWx7A=;
 b=MLrKo4M0GDcruMtwkGfRqwqro2uQCbIXtosmsL+TVauvJ0xfVvv4rUPDQQP2Im8qW4
 1EqbR9w8okq/fydPC+k1Zv7fwmBFhfh6hyZJmg5T6khGCtwxbo55GNLkm4W8vpHuny+o
 oMK/+G72BMujZxCZla13LVHRnJ79VS9cpIafgpSHu+jhp/n58nIdIyVebhp0wzgBaSmr
 nWp+YQqgzdpkUxQifAUCUXUZheurpWUX76y6PLf4xrhV9OwP541Lp7GXF1iNUA5ygv/u
 2x9QDP3MzVgBpQxxbFT8kUvw1Xqzia8xMdZ/f6H6BA5bRDGiitPJcMR6K0tYcEMCD3C9
 n/PA==
X-Gm-Message-State: AOAM532J1tDJ6Yi9ZZ9XmA8xbaraWLK9wysrbxyoXyJzQT1hJdW9llmz
 pUIndNV2gUDff10kxXIZ2yYF8sQ4IPVu+ZZ1tlHxJd8QBJtAULOPwCRxAv30J7P7J4JIrEv08yo
 H0aPTvfLwfg/mibWVFcc/AHY3zIMTdO3qNCVgunj9h+tTjyw8Ah2y6ydFTgSl
X-Received: by 2002:a05:651c:3c9:: with SMTP id
 f9mr2316714ljp.403.1622117311907; 
 Thu, 27 May 2021 05:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMy+4w+3mOLCUbgnvd7jc4HyGXspeCGlk4iS6hlGENYk15Z40+kFFkwbWsZI6VxoKOYx3o+IEQ9FOv/BtKb+E=
X-Received: by 2002:a05:651c:3c9:: with SMTP id
 f9mr2316678ljp.403.1622117311449; 
 Thu, 27 May 2021 05:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
 <20210526150633.GA1291513@bjorn-Precision-5520>
 <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
 <20210527114029.GC17266@lst.de>
In-Reply-To: <20210527114029.GC17266@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 27 May 2021 20:08:19 +0800
Message-ID: <CAAd53p5cF6i_5MiKXva+cpYBxCrVJJVT2ir=2ZiNHafUvO1oWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_050836_595973_2D8D610E 
X-CRM114-Status: GOOD (  14.21  )
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

On Thu, May 27, 2021 at 7:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 27, 2021 at 12:24:06AM +0800, Kai-Heng Feng wrote:
> > Yes, that's exactly what they said. Because Windows Modern Standby
> > always keep the NVMe at D0, so D3hot is untested by the vendors.
>
> So all the problems we've deal with latetly are that platforms cut the
> power off.  So it is not kept always at D0 which would be the right thing,
> but moved into D3cold.

It's still okay to use D3cold under s2idle if nvme_acpi_storage_d3()
check passes.

Otherwise D0 should be used. I am unsure how to proceed with HMB NVMes
if we can't setup DMA after resume...

>
> Which makes this patch to disable D3cold rather counterintuitive.

The intention of this patch is indeed very unclear.

Kai-Heng

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
