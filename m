Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853E4C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXqcooF+h0MdP2Fz1xLEPngVq2SpaVVQUfokhORQgX0=; b=MSRHdabMTknZQpzuFhg74rLb0Z
	bka/Zm8IwZ+8FJldPfr4pldPOxDZwP4LWuwtZOGuuW2Dhn4EM2i0HNB42apEq8o73nssJm0CjKwSV
	aU1LHD0wFCgkD2gpVvLXkMvk1MooS7lRJaMZvCHr+MLfiGd5y4A/ST5jSr4xR4XaV4FnMht+IrSPy
	eMyCtTOBsvKhnIe9ozdiHQFM1Gr1QMRPTvM+u00wREHOFxEn03cLKbnuwF8ze3Xx6vhqOCxt9fggs
	eqtn7obs0UKB6uCXCenmIB/OqogEFH9+HP0RH6MmlNM93MsuPsfan7Sv7Nx5ZxAAwP8Y87yy/TNpD
	iilAfSgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJqi-00000001cCY-2RAk;
	Tue, 06 Aug 2024 13:03:36 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJqd-00000001cB5-2Wz8;
	Tue, 06 Aug 2024 13:03:33 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-369c609d0c7so465176f8f.3;
        Tue, 06 Aug 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722949409; x=1723554209; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NXqcooF+h0MdP2Fz1xLEPngVq2SpaVVQUfokhORQgX0=;
        b=cazLGFAK/N+FFADEWajk3V/6Y9cq9q5Ud21Zx2qKCPZVRVy1U2tKdEyPyRmBfsd3RE
         vM88W+RN4qQZbRHNv6GcutXqtmC68X2y2DGMxq0XDPeIEYkD2kqNEbtTGd01KM1vPa/d
         XpfDnQ1L9NK38wknpJME7rCzFZLs9SYOBF/Qr7BHue8WSovj/6FoP7dtY52dUYWs6dMz
         7D4ip9WCozLsaB0q052uChMdvmmZAfFVoGfqADo0ohyFY9OStdvhiBzRUsOtF0rwJBEv
         HFNHeW7f70O4/OjFWZkMKQkar/FMgZYvKlBN95X5tIBWOlcXmHxqLNlwBnm2VptrjZ/v
         S8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949409; x=1723554209;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXqcooF+h0MdP2Fz1xLEPngVq2SpaVVQUfokhORQgX0=;
        b=g3z2bQnXW30cfkjfphZgygg5EzO+NmQnkGLAY44pmzLO/Zqc6M+XDHJ7s7axsK6OrN
         m5fjjqv+K7aAsWrGRNzHPtHGpIQX1JHP1I+do70S3CYM+C1FFCe/M6prn19STuH+UpMZ
         sz97zNae+J9bEwIDL8qXVcelE9jbQ7gYODETMMO4fyD2CWLLM1E0p8QyhKRaOkTQ1eSK
         PpYZhe7oGDbMmgWoqOs9r0/NZqyurufoeVXBUWPUhFAs7mJXADQn0i1kFFI1CPzZHpS2
         3ECJf3k65JAnhMUnrl5/MRyVaGFKbNw9905qqAdwz1ANPwEBHRWzRTEJnIKbYd0swRuU
         DLRg==
X-Forwarded-Encrypted: i=1; AJvYcCVRypob6fzoGzXVbxRZQjp8ruwTwiOJCOyQmRmY2TBRibspd6npQN+idAhkpSCNhTF7DlvMcT+EA4p6oFfcqboOwAZ2pss2aihWQxdfcoPhPvqb8IJp4Vqi/GX0/WbLziPEeJDcxxnLfe33wyeo
X-Gm-Message-State: AOJu0YxZJVksUFQ0VA/aytpe+lrpmFjHO4Q/13VSxxXqjXcUtpuAFGFc
	EDmPwSLa1a4o0d5kWndHFdaVUwHyK4k8Inb3kJutPse3gKsK/oWW
X-Google-Smtp-Source: AGHT+IFE9bmHdwlb1KsEb5e3xHweTxoHAD/CnO0l3FUpup1/tPLMxcnaiVALbAIQ0dYjYRMgUd3Syg==
X-Received: by 2002:adf:e7cf:0:b0:367:4d9d:56a1 with SMTP id ffacd0b85a97d-36bbc1a5f49mr10771026f8f.45.1722949409137;
        Tue, 06 Aug 2024 06:03:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc9csm13026496f8f.17.2024.08.06.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:03:28 -0700 (PDT)
Message-ID: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
X-Google-Original-Message-ID: <ZrIfHDm-fNcmSaHZ@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:03:24 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124312.GB10156@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_060331_684782_20CC2FE3 
X-CRM114-Status: GOOD (  21.06  )
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

On Tue, Aug 06, 2024 at 02:43:12PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
> > Introduce support for a dedicated node for a nvme card. This will be a
> > subnode of the nvme controller node that will have the "nvme-card"
> > compatible.
> > 
> > This follow a similar implementation done for mmc where the specific mmc
> > card have a dedicated of_node.
> > 
> > This can be used for scenario where block2mtd module is used to declare
> > partition in DT and block2mtd is called on the root block of the nvme
> > card, permitting the usage of fixed-partition parser or alternative
> > ones.
> 
> Err, hell no.  Why would you wire up a purely PCIe device to OF?
> PCIe is self-discovering.
>

Well on embedded pure PCIe card most of the time are not a thing...
Unless it's an enterprise product, everything is integrated in the pcb
and not detachable for cost saving measure or also if the thing use PCIe
protocol but it tighlty coupled with the SoC.

This implementation is already very common for all kind of pcie devices
like wireless card, gpio expander that are integrated in the PCB and
require property in DT like calibration data, quirks or GPIO pin
definitions, i2c...

In modern SoC we are seeing an influx of using cheap flash storage
option instead of NAND or NOR as modern hw require more space and price
increase is not that high... Almost any high tier device is switching to
using emmc and even attached NVME and simulating MTD with them for easy
usage.

Please consider this well used scenario in emebedded where PCIe is just
a comunication way and the concept of detachable doesn't exist at all
and things can be described in DT as static. Also these storage are used
for rootfs mount so userspace is not so viable.

-- 
	Ansuel

