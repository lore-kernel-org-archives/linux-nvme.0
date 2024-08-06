Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1BC49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJLq6wZ3V9tDfVtOdZGITLF+SX3fZ5WHv+sByglbu5s=; b=lZZ6ZFexMX93i7HE2tBc9YFRBY
	AW1rbYbmh6tjbsOq5D0v0EtPFH/w+HgcEDGQ5j44AFKkAyx69wTMa3NpcMav76oahyJIOQ+FU+Zv8
	4wWtp9AR/uKiqTZUUdOvo+2ZKg4kK7i58uschBYraguBBdOdONr4cIA9T8IUB1JWefNhViQs8WfKk
	eUFvZ615Ma6fY2kYH6OXdHjgvvDelCLeAL6rzSXfYtfjOqU6VN4Q1fL3EOdfspo2CQxM0U6K771Lg
	R87PtGYBiPsGAQLJ1UCKzHdAGjOCGaxcgJSmvPb8Mvz4ikO3pNYqslMPPice9MJslcjzQemstCAdb
	L6xsIoRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbKDH-00000001lEo-3XiJ;
	Tue, 06 Aug 2024 13:26:55 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbKDE-00000001lD4-1sjC;
	Tue, 06 Aug 2024 13:26:54 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a728f74c23dso73080866b.1;
        Tue, 06 Aug 2024 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950811; x=1723555611; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJLq6wZ3V9tDfVtOdZGITLF+SX3fZ5WHv+sByglbu5s=;
        b=J6yXkuvv9/tAQBh5eGmXuS1bi/LnS42Af3D5UCBcPxL0x3dSVe7k0aIDNNIqoyHN38
         1Jz3oEE8XOb+iKiycE6sIxCFttlMbdgBLNIs1b86si7p1VUgmFklmvS4bXlRYcMp8G3B
         AT2rIU8eDg+bVB78lz+3xT0R4IwB2i93Od/tjXLYwG9LJSxwO+EgmH1Ie+Gu1SSldsxF
         l6rnqKzZ4Iu3R6NpJIEIHlEps0kx/z0fpW2JiwfXGQ4KBJtiYwyNX2fJT+er7sycL1Pp
         1i+oa1JBTgnF7EMF0bCtiWKNDAdUAJURYn6/kXtC76AlGjGCg7wXgH1CwSjKhzTiqKIR
         8iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950811; x=1723555611;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJLq6wZ3V9tDfVtOdZGITLF+SX3fZ5WHv+sByglbu5s=;
        b=QAbQAnSzmb+F+zp2q/xSKl42RKomfK1OiLhbckfd1JwC8x1cNnlfPtX8x9wyV/i2TW
         sGm/1Vrwm7mWK9RBGRhjKlKtTRShKCxfYToCI9fPmnm5S15UVxldTbeTrpQ5knzKORli
         DxUEKCGsouiobL9mXXWSAozEJKEql43saHdAFgtWxsz58VGnqy8BbWRGmMtZW4k+RSs2
         dk9YmgONQCKoX2RtTunD/4tM5eM4avwy7oXlXsVyQx0ySvFslnXQPSLGo1hSfh3SBkS0
         Q8m4mUBdfvapjy2m+dFfId9NMVoMd4eJYN+UeoVhNDGQEKJayQcZYV2s9DcGHgmaTnn5
         TL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnFCFgJxUrxRpLa3YIqICyOn+VmaGVhLh6N+fzzBBPgdggFkHIxL2O/r5MZHjsZqXCco89rlXdVktj7/wmFkMcz5l/tW80H/LP1NveLqySVdCqtBAYh7aBpORJ92ZZZzpIGNMPsrsA6YbbEYSq
X-Gm-Message-State: AOJu0YxOMQF8900eU6ibs2LntPl8AlHj8wlJK4WUlIysvsRtDN+J5Koc
	itxGAP1nepKE/z09fY/xP4XCIX70/8huuAYU4dt1+07VwO7AwD9V
X-Google-Smtp-Source: AGHT+IFCZboMdtGhjAjAlddCPcdXU/2ru7VniI37xRcVSX5ZWE/iyT9EsbOEIdYyKoXwTHhvEvlGlg==
X-Received: by 2002:a17:907:7ba1:b0:a7d:a008:abca with SMTP id a640c23a62f3a-a7dc509e2damr1049187866b.56.1722950810418;
        Tue, 06 Aug 2024 06:26:50 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec285bsm545048066b.188.2024.08.06.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:26:49 -0700 (PDT)
Message-ID: <66b22499.170a0220.cc48.fa2b@mx.google.com>
X-Google-Original-Message-ID: <ZrIklQiyQvFIIPz8@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:26:45 +0200
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
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-3-ansuelsmth@gmail.com>
 <20240806124312.GB10156@lst.de>
 <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
 <20240806130938.GA12231@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806130938.GA12231@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_062652_510765_8CE698B1 
X-CRM114-Status: GOOD (  19.47  )
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

On Tue, Aug 06, 2024 at 03:09:38PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 03:03:24PM +0200, Christian Marangi wrote:
> > Well on embedded pure PCIe card most of the time are not a thing...
> > Unless it's an enterprise product, everything is integrated in the pcb
> > and not detachable for cost saving measure or also if the thing use PCIe
> > protocol but it tighlty coupled with the SoC.
> 
> Yes, PCIe has a bunch of form factors, including just soldered on BGA
> devices, but none of that matters at all for the logical protocol.
>

Correct, for the context of soldered stuff tho things can be
malfunctioning (problem in the PCIe driver) or working so it's possibile
to make assumption and attach OF node in DT. Consider that the thing is
probed only if the card is correctly detected. Card not present ->
nothing is done.

> > This implementation is already very common for all kind of pcie devices
> > like wireless card, gpio expander that are integrated in the PCB and
> > require property in DT like calibration data, quirks or GPIO pin
> > definitions, i2c...
> 
> Do you have a document on that/
> 

You mean example of PCIe that makes use of OF? Pretty much ath10k-11k
mediatek and in general all wireless card. Example ath11k-pci.yaml [1]

Compatible is set to the ID. PCIe will attach an OF node if found in the
pcie child nodes (already supported)

On NVMe driver side, the NVMe controller will already have an OF node
present.

We are now just adding an additional subnode "nvme-card" and attach it
on the root disk when it's created.

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/wireless/qcom%2Cath11k-pci.yaml

-- 
	Ansuel

