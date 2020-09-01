Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C250C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE2620FC3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DfTE+uew";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lCL5SLaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE2620FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qutvoUvvppF588x3vWvz4ydJClKjM8yJ2CRemGTHkek=; b=DfTE+uew6t6r77NK3tmRrMUug
	dIFR3QqHrykQXQr+OFA/YPFW9DlZzVH/5wNpl1aEncvZsPDbrUKXAZm8WwNLxFN5FDkU3OeYH3k/3
	Kxz9kn7lLtYdvOjmTGHYfwFrktZQ8Gl2J/UqD33YiEpIML2NPC+LJeTBnK6guhD0VHhN4j2fTV/bw
	S69ySng5HVrW7c2/9jJVowRDdupbkr3vEEXd4rpWl3b/2oHpmyYBQRm93gNiRss65+sZmagwS9tRC
	oILxiYyWfQS2n81EHyTueOY6yiWgW+9gVL2x4uwdu4dgJYBHA7WQFmhC1pUDIHLCC1/zIFYrie2LN
	TxEnmG6yA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD7vR-0005v4-1L; Tue, 01 Sep 2020 15:10:21 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD7vO-0005uZ-SN
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 15:10:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id v12so1941038ljc.10
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BIr3FRHLWeYI5mpm2jHeXhPihRGMNnmHYOmMOMeHpR4=;
 b=lCL5SLaMFPqoPftiV2X8nocTTBdKqARvrqI17ufYPS0DtjiIyaSIs4CniiHZ/VEW8n
 WoqCHbvQzPHbcjvAM7+zD7U98QNr5oxI5U75nYwYeOtUdaj7M9sptx5fdS3otDiC5uUz
 5071XY7IwhHNlm+8JmyRZFrwvyyMI1Xxx/Jf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BIr3FRHLWeYI5mpm2jHeXhPihRGMNnmHYOmMOMeHpR4=;
 b=MJhdEiGVm+/IQq5oPGjcPzWxgZvQcNSozQYf79Tx+KkMi7rSwJBVI+G75m/mtP5yZw
 dI8zpeD+7cxxkcsTsDifOIXmECxctvrvfjZWqQuApY+NDXFijhkTqCJY98FS5NtVL8c8
 aecJgqmglhbjKpSGwCW/JnB2xY9kLhVN6MU0n9R9WBCdXG1hhTtrv5JbIm9dtDUGyOcf
 1okY/LhUGIgSYboxjOTQufrNqpJViJIlER0yOw+XvvOryDpiu7KxkdAQqzzsO7203ny6
 zatYvXBJ/0AndJ9jJlDL9AgpEhf1Hfg05CaK9stPoBWYEl6p8fZQdqQIXhrd1CY/pwzP
 nR4w==
X-Gm-Message-State: AOAM530P/LSBrFD+gvov297Ue48yWuzW9xOspyvpw5GwXe/1UWtNDDqM
 /82v29wE0Gp7N9KXKMX6Bf8MWageGeHiyQ==
X-Google-Smtp-Source: ABdhPJxXEJ+1w5A6t6WMBHQ+FdiN1CwQa3YPH7fAOivemMCVf1mbdXPGbpEf9SEx4Jzoo/nxCL0EWg==
X-Received: by 2002:a05:651c:50b:: with SMTP id
 o11mr871776ljp.411.1598973017093; 
 Tue, 01 Sep 2020 08:10:17 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id u28sm327819ljd.39.2020.09.01.08.10.16
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 08:10:16 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s205so1951787lja.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 08:10:16 -0700 (PDT)
X-Received: by 2002:a5d:5150:: with SMTP id u16mr2332024wrt.197.1598972568491; 
 Tue, 01 Sep 2020 08:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de>
 <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
 <20200820044347.GA4533@lst.de> <20200820052004.GA5305@lst.de>
 <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
 <20200820165407.GD12693@lst.de>
 <CAAFQd5D=NzgjosB51-O_cH27a8V6CPgCfaPSfHHz7nKJPbazgg@mail.gmail.com>
 <20200901110617.GA13232@lst.de>
In-Reply-To: <20200901110617.GA13232@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 1 Sep 2020 17:02:20 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CmPVSxmZJVn7HnNUn8srZbAbnfzpNMYw3KcDzn7xD2cg@mail.gmail.com>
Message-ID: <CAAFQd5CmPVSxmZJVn7HnNUn8srZbAbnfzpNMYw3KcDzn7xD2cg@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_111018_984569_FC40BF09 
X-CRM114-Status: GOOD (  25.18  )
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
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 1, 2020 at 1:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 20, 2020 at 07:33:48PM +0200, Tomasz Figa wrote:
> > > It wasn't meant to be too insulting, but I found this out when trying
> > > to figure out how to just disable it.  But it also ends up using
> > > the actual dma attr flags for it's own consistency checks, so just
> > > not setting the flag did not turn out to work that easily.
> > >
> >
> > Yes, sadly the videobuf2 ended up becoming quite counterintuitive
> > after growing for the long years and that is reflected in the design
> > of this feature as well. I think we need to do something about it.
>
> So I'm about to respin the series and wonder how we should proceed.
> I've failed to come up with a clean patch to keep the flag and make
> it a no-op.  Can you or your team give it a spin?
>

Okay, I'll take a look.

> Also I wonder if the flag should be renamed from NON_CONSISTENT
> to NON_COHERENT - the consistent thing is a weird wart from the times
> the old PCI DMA API that is mostly gone now.

It originated from the DMA_ATTR_NON_CONSISTENT flag, but agreed that
NON_COHERENT would be more consistent (pun not intended) with the rest
of the DMA API given the removal of that flag. Let me see if we can
still change it.

Best regards,
Tomasz

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
