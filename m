Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD0C3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=; b=snU6snccMfgwRaL00Ukv1yvveB
	lF2a/2AMs1RisIvwa+NMw4IwSRqDsC9MTzjK8wHyBwbK0pZ0r7dvcN+OXE+Wc2CwaxgTQ2SObPKsV
	twt5qa9ajt/3IBbUn6Qt5O71JL6R3UT+MP/uDziDVFW4FMgDwEb8URX5SYAXs0eudRcPZvYAK07a/
	u/j2sy7Tqb6I6NoQWvrChyvqYe/zW2MusHhYXshnC1IHDTOWJPPpnsw2kse5FVTQZThPenGGhVEPL
	JbJX+qlJeM8yDb3aZfdMPcNK7BsEfeQHhAJFxRGgFronwBEVTaAqjNHo4MF7a+5toWKqUcjuJZZ+K
	I+z0muPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdT1H-000000006uP-23IM;
	Mon, 12 Aug 2024 11:15:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdS0C-0000000HZ8E-3i8Q;
	Mon, 12 Aug 2024 10:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=; b=lKEw0/HrfQ3jEWRI0pomgb5kTW
	Zumd3C29abhH12TeqRKbFPTrjI8bOtYatjwAvGKl+rO0OiJvC+ifLXSD/Qy1y1gd4eM4t69QB8HA7
	VYwA5vYXAgQz0D9YkPKlGOcw3NoGRjMTIANtaIqBh8qqd7LhTDGcxb5GPmVuEheG114hry9RbkpwS
	ezS2gGQXkqWXphfpkCiCdkc6yrBdc3AoEa3beRiUTF2YNEHUnfL/Bl+Yfol3/OadEmPbq4yh39Qyk
	ziK6FcNbw24mHkMIqQksQQxskvsu3MkLFM6OsGXfXF5a+vM4TH/mLnyQcC9m/z74EMpHJfteiqqkD
	ny+J5B+Q==;
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdS08-00000007WB7-1xKX;
	Mon, 12 Aug 2024 10:10:11 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2f149845fbaso43592781fa.3;
        Mon, 12 Aug 2024 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723457405; x=1724062205; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=;
        b=bNYlADMCERSvRL+dSnEssQRw+mJhNSkWhQsHgkj7zPzNbj/eOpqB2l6e48jaE6eDHi
         9JwLh5sWL4fAOyRTvLsjIzGyp0uxeSgZeSinFPfT9ZKJLTEENbAU/ywOlT44oqS98Ubv
         2OhIY5y9t1VWBlvafjEBCRMXDrRHWLJpQNR5OOl9dN17WuMurMHWZTjJTxiYllbqpP37
         cYl+FzKItFcgJqhbTPIiwQBKai3cf7QIGlUiydMjupdPKxaPWH0hipp5XLGaC3YKY2gA
         DblzJX0RGfdX6NTHApFCxCjCfGLPfzyVF0jRnPkiQpqCBhqgvWxk8TS0rqbUvYLZ/0D4
         +Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457405; x=1724062205;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=;
        b=JR6yWCLZlNhXfMuUDUmMaihZbSAhx3tlOkgr1PXb3WmTzVrUgPGayxUCB35fBNJCIV
         dg1pfsUp8x9iqRwBFWrfQ0pU4bLMaNTcheeCNeTTqlYqckTQpKUfpuY34kXr3UYUmZNo
         b9hU5CsQO2/FOc+JYLDq1EoBlpOcfn0Gd4EoxT70+PfkcNupl2205ro9HObh/VSb3LU6
         Nabmo9l5+NuUg3T0GWnCVZ7nhKHbyii0uDgoX+s+13AiQAj7hgfHbF/LMUoI0z5OEkre
         iOcVM3DcjyHAzi8jgfhZNYBPYwoxaETaMQwS3V5USw1i2UuD7eY70H23+0UtC5fhL8U3
         HX4g==
X-Forwarded-Encrypted: i=1; AJvYcCWReENOLg8shS958DO2MJ5TkJY8iouhg2AwnqHSi1ztdXl7D7ISxAjayvjbKCyghL4UavciQlzO5YYoHM1l5GKv5QCADMoYA8IROJP9TQOvTJ2Ca7S48WyM8k5bvqoFXegefe/XIYJZIYYIks55
X-Gm-Message-State: AOJu0Yxaza7qm4s5artAEt+b9/6EPNUw8UqsP1lLi/3GA0bBdtl0UG8Q
	LHsvvFV7NciNcnfRUW0QzFfUkjAwD3TAU5w4LV+Iu1NS4HXRlS3K
X-Google-Smtp-Source: AGHT+IF7gXVzTH4CvkvVbJhZb4UZN3i53JvW8K9dJlvL2BXg7c8PPh33br3AXeB8LmLX5nWpLcfQ6g==
X-Received: by 2002:a2e:602:0:b0:2ef:2c20:e064 with SMTP id 38308e7fff4ca-2f1a6d0c988mr58328141fa.12.1723457404706;
        Mon, 12 Aug 2024 03:10:04 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a698sm184004695e9.21.2024.08.12.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:10:04 -0700 (PDT)
Message-ID: <66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
X-Google-Original-Message-ID: <Zrnfe21jJLJ310O_@Ansuel-XPS.>
Date: Mon, 12 Aug 2024 12:10:03 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240812104954.1e8d55f7@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812104954.1e8d55f7@xps-13>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_111009_916314_47E524FA 
X-CRM114-Status: GOOD (  36.62  )
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

On Mon, Aug 12, 2024 at 10:49:54AM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:
> 
> > This small series handle 2 problems.
> > 
> > It does try to ""standardize"" the usage of block2mtd module with
> > MTD OF nodes.
> > 
> > It is very easy to add support for MTD parser by just adding an
> > OF node to the mtd created for block2mtd.
> > 
> > This apply only if the root block is used for block2mtd to allow
> > scenario where the full eMMC or an NVME is used for MTD and it doesn't
> > have any partition table.
> > 
> > To also support NVME, similar to how it's done with eMMC, we introduce
> > a subnode to the NVME controller that needs to have the "nvme-card"
> > compatible where a dev can define fixed-paritions for MTD parser usage.
> > 
> > This series also add support for the Airoha partition table where
> > the last partition is always ART and is placed at the end of the flash.
> > 
> > This require dynamic calculation of the offset as some dedicated
> > driver for bad block management might be used that reserve some space
> > at the end of the flash for block accounting.
> 
> Who is reserving this space? And this is not reflected anywhere in the
> partition table?
>

To be more precise Mediatek use a custom way to handle bad blocks called
BMT where they reserve and store data at the end of the nand. This is
loaded before the flash driver controller so when MTD is init, the size
is already reduced. The reserved space can change and it really depends
on the tuned values hence it may change.

> > New aarch64 Airoha SoC make use of this partition table and use block2mtd
> > for eMMC to treat them as MTD with custom bad block management and block
> > tracking.
> 
> I am sorry, I am not used to such use cases, and I really fail getting
> why you would like to use mtd with an eMMC. Can you explain a little
> bit more what is not available in the block world that you really need
> from mtd?

Since vendor needs more space and doesn't want to adapt to block world,
they are starting to use eMMC or block devices in general unpartitioned
and raw and using block2mtd to simulate it. They don't care about the
performance penalities as it's something read at boot time and only new
firmware or some config files are written.

Is it more clear now?

> 
> Also, did you consider nvmem layouts instead to detect and define the
> ART area? (just asking).
> 

They still need a MTD partition and most of the time userspace tool are
used on the ART partition. Using block2mtd and DT support will permit
the use of nvmem cell as a side effect (and that is a missive bonus
point of this honestly)

-- 
	Ansuel

