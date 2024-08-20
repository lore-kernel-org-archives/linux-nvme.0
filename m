Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495FC52D6F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnOrzKMcyDUoMSvS/S7wX/qCak1X+CvKtxdgt9KzAEE=; b=qs+MPumyDOeh2ls8nUyPlUofwW
	yn+SY4R4e/8qONXTO0v1f2kLIIVj9xyIbaY4LezIHgkR0kboX9z+Rp6qVwu1pcYV70JSxSP0D46Nr
	44cqQgLquwterx3NkCAoDnL36lMKNXmcQtvRU1Jk/buRh5GLIrUzilPG06FGqMhBNLwmgzAyAjCJ9
	dU3Lqk+KALTYlAB1Ep6ChrZWg/60vJ7hy/fBfb0byKe70b0CT8O9fcvaw1IEwGUWS89kWTLmDLi00
	Qo63SW6d6XbGPmggc9cYrl+KtWTlV4HykYLqhZLb+5fDFm3+zj+51w6SCZnQIOP02EsJ5qxVqnpNv
	uJda3FDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgiI8-00000008MeW-18Oj;
	Wed, 21 Aug 2024 10:10:12 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgi1H-00000008JQS-4BQh;
	Wed, 21 Aug 2024 09:52:49 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so4062307f8f.1;
        Wed, 21 Aug 2024 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724233966; x=1724838766; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NnOrzKMcyDUoMSvS/S7wX/qCak1X+CvKtxdgt9KzAEE=;
        b=FlkMAwXLcjyC2yvE2iHRXAEliQk0/96O9lgVxo3Vg3KjEgmvRRM5ohXJO4yf553z3L
         CVkyaltEq41fJRucLq+1j6N0iwQdMoozYHKsL81nIISOp34Pt5NzrSvqWxA+n3Bk4zBW
         tDbRI1m/ZW7YKlbIkMD0emUTIXgj0JTzpqDoK0r3822cED+yGIKJZe2KPoH5VOyBcZQM
         i0dS9YfQdrf7KG3f+QXPzDIi3fyXnD9X9TNBKOu0uChOmv18qZ4Vp+9sh9zr5XYg0xKI
         4FCm/o0ro6rD0yNorEe3s0s43uHXxpAEVLood6Srd/XUDZVKioDH49rBlh3O2+jLATV7
         2Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233966; x=1724838766;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnOrzKMcyDUoMSvS/S7wX/qCak1X+CvKtxdgt9KzAEE=;
        b=BRpxpKHvCp5TZf4lx/HiAmbMTETdBh4qCZ4TTu6BAIMooRLjTSaVovAnFGJlbFky8W
         Xr71HSkc1DS9W2J/Uz4SVuPi49dkgyt3Op3v+Sy4RI3Uzz8GdL2S77JJsn6KsyBO24t3
         iXl0O2tfWKdpF2grxP+JxvVWZlkyjpx5YPUk0XtUU13Y0SZw1CjKk1DXodUk8dJPfP8g
         zOEU+HRlYvynIpznYk80eS0Mkc0GaQAZrJ3OqPPOKbQz522w4NFUPiLHdSkBrT7Xky3T
         i3/+fy5ftCbNnDV+SrpJIlsrBrN6QqrpzUmk9yVc+YbUhPw9t6eIHSDW4qW/6Zoa0ORC
         p1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0RdtIzCFqaNsoIV86bWDK4fCMfbtv8s+BMt/Ta8EIz6JVptXEZgZnBLNANOZ9NMu+IN3vedhsDw4=@lists.infradead.org, AJvYcCXdCKtUuXY2tc9dsQndxQFIqus/Uq4DtCidLKSliSex1LwfdYHGgfXUPBAR/fV6ZO+pfBYMdH+tGf/L4w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwovTu7rtPTqCSjxMud2xpYDq0aiuCeNfg+r5V/Jf3/wr5iaKGG
	d0034GJqUTQug1VeochZyX3igmUmGPF043HrEW6V8QvZX/TA2H5H
X-Google-Smtp-Source: AGHT+IF+o52couZdaHJEJsihSkCGmNimy0lgypKHwcww3KpUeXlqaH0DcS+QnsEyqQhvoHcsbtMK6A==
X-Received: by 2002:a5d:4e91:0:b0:371:8d9d:d824 with SMTP id ffacd0b85a97d-372fd4d0932mr1175077f8f.0.1724233965429;
        Wed, 21 Aug 2024 02:52:45 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.145.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2e2sm15236412f8f.16.2024.08.21.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:52:44 -0700 (PDT)
Message-ID: <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
X-Google-Original-Message-ID: <ZsT6q4_ULOc5aPv8@Ansuel-XPS.>
Date: Tue, 20 Aug 2024 22:20:59 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813200734.GA1659224-robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_025248_064224_9A2CB070 
X-CRM114-Status: GOOD (  26.87  )
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

On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > Add property for defining partitions node in mmc-card node to define
> > partitions in DT by the use of the block2mtd module to use block
> > devices as MTD.
> 
> You justified patch 1 saying eMMC already supported this, but then here 
> you add support.
> 
> Both are a NAK for me as both already have a way to describe partitions 
> with GPT.
>

I think this got a bit confused and hope we can find a way to add
support for this.

What is "already supported" is assigning an OF node so driver can
reference it. This patch was just adding the nodes in the schema to say
that partitions can be defined.

I think what is not clear is that block devices might be used as raw
devices without a partition table defined in the device. In such case
it's the kernel that define a fixed partition table.

One example is [1] where the partition table is provided by cmdline.
Similar to cmdlinepart MTD parser.

The use of block2mtd is just to make use of the MTD parser system.

Considering
- eMMC is soldered to the device (no dynamic scan)
- cmdline might be not tunable and hardcoding it might also be
  problematic (as some cmdline needs to be used)
- concept of fixed partition for block device is already a thing and
  used a lot (android AFAIK)

I think it should be acceptable to introduce in DT support for defining
fixed partition for block devices and some kind of parser system similar
to MTD. What do you think? Would this be more acceptable? Idea is to
just have a DT schema that makes use of the values that can be set in
[1].

Hope we can find a solution to this, I'm totally OK for dropping NVMe as
I understand it's PCIe stuff and very dynamic but OEM are making lots of
use of eMMC and are starting to use these strange way (block2mtd) as we
currently don't give a proper and easy solution for the task.

[1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)

-- 
	Ansuel

