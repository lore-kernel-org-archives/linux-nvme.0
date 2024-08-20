Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3882AC52D7C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbJQfh8oH+/6H+RAIJN5JcyecchC2478JTd/lzRXn+8=; b=TqRrW27R9XzH5+01gyN/iSR9lq
	a4ltUB/BHe5Pw2pXKe4El0TtzqvG17ZIziY4PrHpDj7inXq22yTl+Q503j+rhFehObNeR9VJIJ/xC
	5XMz4fLI3ooteGWvxc0oMn6hwGYmJdaHp5xqBZrnN/ykkapGWWfPdAC/f+1HSlplBP+iBspvmBIMK
	++7EP0pkCf24AQ3XIA7JSFoKo0QFWeRN1WtXxpiV70tY0LGBAtLIybLwC/4PPXam+9ouPoH1wgBv7
	wjaBiQkySdebjm87XmwPAm0GIcpbIFaVPYjYoAh049+5CyL5lEZE/LqGxjHjSe8dbCWG2sjtPWAIx
	H8V9MdZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgpmC-0000000A1Cm-250a;
	Wed, 21 Aug 2024 18:09:44 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgplq-0000000A17T-3bSA;
	Wed, 21 Aug 2024 18:09:24 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371936541caso3423492f8f.0;
        Wed, 21 Aug 2024 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263760; x=1724868560; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RbJQfh8oH+/6H+RAIJN5JcyecchC2478JTd/lzRXn+8=;
        b=Yrbd9AWl9afy3Csz2zMRm76NS/iaYQ1wf7T7ixfyX9sv+pmzBwkjsnNY1fC/Dq38tX
         Gc2QfKNpBCFkqvt4LNGlOTNbosXETz00HLdBdJFMwqGDom3SpU0ly91PSWGxh9Ogz2W4
         0TXPekbfh+x5N9ePFAe9/dg4o/qJUySKBTnTT8IiekEOBaHkZR+IsqYwOxeGPCFO8ygG
         +bsTARyoSRyiyA0FK6MtBKbhQ9TctnEWCzKDEnlkVEYPhHGHPNOzgkfOt9jitPzBux4K
         SGbUYq9xteEU8DNarLgo2jBM4snU99l4Fak2gh2Kulk/tqg1bb/YJZVWKAkCIZy244W3
         XwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263760; x=1724868560;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbJQfh8oH+/6H+RAIJN5JcyecchC2478JTd/lzRXn+8=;
        b=jRjwYbCCjDYRDseKFlmMyiK2nwzNdstEsWta5Mv7N9V3JYUddjhlEmO8QOUjs+rrQp
         2jFLYUgFVG1LDNouNmKjdA94GTooXuQcZizeqOHWw7oeQl/ozoIDKMWiPJxqnjUXzbua
         vCqFUTi7NI756z3/nUjOnRspz6scgJcrBNKYoZ9unmzgmd7N2ba9StaCupCKaTa1kEwg
         y/2TPVEZa8h6cCQIJSoObAzLY2AIzzQNU2atfedfi/3+Clbm44P+K1DmvA4I2NudHGeY
         ++VZspiLdAprpT+6fohAenYDpvl7nGroHINqFJp3pz3x29Sexb2yiQrHUEQrmpV36abB
         3GTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNObhmg+7qW30v//ZD+PptnzxIW3xumhBCc8puS8Qr7w0kGZK7oKP7t9+uaxLMpzWvzffdEUuDtm+ww==@lists.infradead.org, AJvYcCVk49uBoxrYk+dVJ9Z77+7DTSk6tf2MsafMj52Ygs1wuRCBjhUoqCtdCykNdsDQJhIFVbQPT9OpMq0=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9WQQsxAuiUZd1R8ctLmiaGbVM462yysHZqX1P65n+q80X/pjo
	tqJKVurWp6Kkgt8axYHMTWWl7aswFtyb7agTR4W8d8AzOL9UQFM3
X-Google-Smtp-Source: AGHT+IHlmPMhYFA/1JwECTX9lRz4YGienXe2XSehw/xBGz/6Mtvd7mIdvA1vsaht0gA/54QHizdnxQ==
X-Received: by 2002:a05:6000:c52:b0:36d:2941:d531 with SMTP id ffacd0b85a97d-372fd7013a0mr1846525f8f.44.1724263759586;
        Wed, 21 Aug 2024 11:09:19 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it. [87.1.209.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm16293072f8f.91.2024.08.21.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:09:19 -0700 (PDT)
Message-ID: <66c62d4f.df0a0220.3305f1.f86c@mx.google.com>
X-Google-Original-Message-ID: <ZsUTX0MBt07_EKPA@Ansuel-XPS.>
Date: Wed, 21 Aug 2024 00:06:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org>
 <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
 <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_110922_924597_CB6D5D54 
X-CRM114-Status: GOOD (  50.58  )
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

On Wed, Aug 21, 2024 at 03:14:29PM +0200, Ulf Hansson wrote:
> On Wed, 21 Aug 2024 at 11:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > > > Add property for defining partitions node in mmc-card node to define
> > > > partitions in DT by the use of the block2mtd module to use block
> > > > devices as MTD.
> > >
> > > You justified patch 1 saying eMMC already supported this, but then here
> > > you add support.
> > >
> > > Both are a NAK for me as both already have a way to describe partitions
> > > with GPT.
> > >
> >
> > I think this got a bit confused and hope we can find a way to add
> > support for this.
> >
> > What is "already supported" is assigning an OF node so driver can
> > reference it. This patch was just adding the nodes in the schema to say
> > that partitions can be defined.
> >
> > I think what is not clear is that block devices might be used as raw
> > devices without a partition table defined in the device. In such case
> > it's the kernel that define a fixed partition table.
> >
> > One example is [1] where the partition table is provided by cmdline.
> > Similar to cmdlinepart MTD parser.
> >
> > The use of block2mtd is just to make use of the MTD parser system.
> >
> > Considering
> > - eMMC is soldered to the device (no dynamic scan)
> > - cmdline might be not tunable and hardcoding it might also be
> >   problematic (as some cmdline needs to be used)
> > - concept of fixed partition for block device is already a thing and
> >   used a lot (android AFAIK)
> 
> Sorry for sidestepping your discussion, but I just wanted to add a few comments.
> 
> It's not clear to me why we need something different than what we
> already have today.

It's really adding a missing feature. We have cmdline but we don't have
DT. And in emebedded many times cmdline can't be changed.

> 
> If it's a partuuid/uuid/label or a fixed block-partition from the
> command line, we still need to know what partition we shall use for
> what. So why is this problem different from how we manage filesystem
> mounts, for example?

In the context of eMMC there isn't any partition table and the cmdline
is hardcoded by the bootloader. The cmdline might provide the root
partition to use but doesn't declare the partition table (with cmdline)

And the bootloader with the hardcoded cmdline might provide a different
root partition in dual-boot-partition implementation on switching the
boot partition. (this is used a lot with bootloader using a env variable
and a different cmdline passed based on the variable to signal what
partition to use for root)

> 
> >
> > I think it should be acceptable to introduce in DT support for defining
> > fixed partition for block devices and some kind of parser system similar
> > to MTD. What do you think? Would this be more acceptable? Idea is to
> > just have a DT schema that makes use of the values that can be set in
> > [1].
> 
> In DT we can describe that there is an eMMC card soldered to the
> board, because it's a description of the HW. But describing what
> stored inside the eMMC-flash doesn't belong in DT.
> 

Why? This conflicts with how it's done on MTD. Also consider the fact
that eMMC might contain calibration partition used for NVMEM.

Describing fixed partition on a soldered eMMC that the bootloader
expects at a fixed offset and won't ever change (or it will result in a
brick) sounds like describing the HW to me. (it's the same principle of
MTD just applied to block devices)

(I know it sound strange as block devices are expected to have a
partition table in MBR or GPT but reality is that it's not always the
case)

> >
> > Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> > I understand it's PCIe stuff and very dynamic but OEM are making lots of
> > use of eMMC and are starting to use these strange way (block2mtd) as we
> > currently don't give a proper and easy solution for the task.
> 
> I certainly appreciate that you are trying to solve the fragmentation
> issue around this, but it looks like we need a different approach than
> using DT to describe partitions.
> 

Well it's either DT that can be tweaked and is part of the image or
cmdline that have tons of limitation due to bootloader having fun
hardcoding it or also actually requiring the bootloader cmdline and
adding overlay on it. Honestly as I said adding DT support is really
compleating the feature of the cmdline implementation.

> >
> > [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst
> >
> 
> Kind regards
> Uffe

-- 
	Ansuel

