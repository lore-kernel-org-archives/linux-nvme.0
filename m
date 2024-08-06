Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84518C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7zPzbWeT3ajGHr373KRI//jHW9eGHoTwTI24+zUeFk=; b=OoAjBeMGU9d2A7W601dyVHBL0a
	bzK3rIrfkIxlUhgdxEAizsd3jz818W8GtDI5NoOnVQSZg+bNxZsDVBFPkQXUznCapvA2o4VwvKm32
	HjLH65Xqg5oZgf6fQxJwSbDIFqavwIl95c+wHcO1eNs+WYHN7y8leK5oVewXedwhcEVBwiWKzinPS
	kZ3td2IOZcxDGYLYMfHoKfl8k+FMaP9SbtJp/ri/5HjD4jQc0VDIWSOHx3mDQghHHbyhgMrwSPIyT
	j3ZKtojbyxQylyCbt17CX7II0FxSjmZArYvG69JNvfulTUR33RIVcuTYLCdsEzX6n5JSTPiBOTyKx
	mNPBp4Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbK5R-00000001i26-1DqD;
	Tue, 06 Aug 2024 13:18:49 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbK43-00000001hR9-2CQr;
	Tue, 06 Aug 2024 13:17:24 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4281faefea9so3881115e9.2;
        Tue, 06 Aug 2024 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950241; x=1723555041; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7zPzbWeT3ajGHr373KRI//jHW9eGHoTwTI24+zUeFk=;
        b=gn5rzHiYJHpxpPTU1BVwJFjVvEROsxBvu5CTGKGogXr9E9PWtw+n+k7MisxaXjajGn
         oxVE5oWgeaaP15Rke0t/KPtnu7mk+84L8w530qYpm1fR8gfbu0JamFDfg70EjE9KQ/48
         YbgUzJN4LH3WdVtXjrIkoiDKlyWbdU6xPKqqte/nO2YX2VA/DoMmDIxpbQMksUUGa+1B
         Gt6W9H4Fn25ewmpoNigFxShzNK/VEHd/lY3foVHuqy6OneTQM4bzV162lcplGQaUc0Pk
         Y+zJCG696d1lzK9iFxSETYD0Rk1qStHCxZeMbol0URyR7cD0yvCaDAP6n8YBwPa2sADd
         5BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950241; x=1723555041;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7zPzbWeT3ajGHr373KRI//jHW9eGHoTwTI24+zUeFk=;
        b=kSnymyADTeSoEXP+B5XbYwknM3FVi6n3yZOF28R3AOMYSfbJWx36P+Va6t+AYeRBgc
         SbHgVFI7VJKO1rkeyNceRZBQglOua9KvxQvcGaePhU7WR+R4Vu7P0XlefxhFZ58rVwgt
         uimA+L7/0vK8RMbIuTTg/AaT1YSK5PZSYYE8prjwp2G6G5OYSlzJzHwxfbyRuZYOOxGD
         AIf2+0L6VFgPrdphJyTnaWoM7xWA3Ctu+/3q2HG8/jEX4/PluPTbSrrjS3AT5Wf3TCqZ
         L2U8LBNBdbLxlXUl+v7G3V7qvY3ujgm2Y3kXQvfq6Q+ykefhxoYCVTuadwOmOW/I7i5v
         mnvA==
X-Forwarded-Encrypted: i=1; AJvYcCWrc0exG96Fp8b4ER41RYfpNCvLol7Do1A5YmEiVDY096qu/W+G7osQe/4jEZVZH9qtHaC+kI6/4TJXllZUZzAU8ADwyEFuALrD6xvHpNEzDaTeJK17aNkZhh6SNWry3afMbY4ZdyjTW1aele2w
X-Gm-Message-State: AOJu0YzlHz6QXXK5xNdXWOrpfcz6r0fqkJNdnI95I+raAQnMYyAc/ASb
	wE2yUO5u5Vui3wxkoFLDKNg/iSbUtn6Lgg9hbI1lQ1I9wYeB5fVf0iUsxg==
X-Google-Smtp-Source: AGHT+IEut66y9HBGYWpB8iEX0ePNj2Rw9qoCD9Mj6LeeUaFBErVh4YbDclRk8F/WRbu/POoNdZxUOA==
X-Received: by 2002:a05:600c:35ca:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-428e6b7be88mr102599445e9.27.1722950241128;
        Tue, 06 Aug 2024 06:17:21 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm242847475e9.12.2024.08.06.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:17:20 -0700 (PDT)
Message-ID: <66b22260.050a0220.18f4fd.5a4d@mx.google.com>
X-Google-Original-Message-ID: <ZrIiXBYsm8a1WjGM@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:17:16 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-2-ansuelsmth@gmail.com>
 <20240806124224.GA10156@lst.de>
 <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
 <20240806130003.GA11766@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806130003.GA11766@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_061723_604249_07F5E82A 
X-CRM114-Status: GOOD (  16.24  )
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

On Tue, Aug 06, 2024 at 03:00:03PM +0200, Christoph Hellwig wrote:
> I don't see how this works.  There is absolutely nothing nvme specific
> in there, and we really should not bring OF into NVMe.
>

Thing is that OF for PCIe devices is already a thing so NVMe already
have OF support. And that is totally OK if the PCIe is not removable.

So it's really a simple subnode to keep things organized in DT and
permit common code. Why this would be problematic, the implications of
adding support for this are really none, only additional support for the
new devices that are taking this path. (you would be surprised by the
amount of hacks they use downstream so about times to stabilize this the
correct way)

> > (alternative is to have in block2mtd all kind of extra logic with switch
> > case to check for major block ID that deviates from a common schema)
> 
> What common scheme?
> 

The emmc one and also nand attached to spi. They all follow this.

controller {
	card {
	};
};

-- 
	Ansuel

