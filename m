Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E93BE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGOstDBbuzWKPR4GcvKniMYiDdZSOAYV5X1DyfRCjKM=; b=q2+6tbV61tt1on92IjQR1R/wYB
	BPkpIiOHSz4jMs8SU1M/+SQU6gJB7plC0O4Sfq3USC4t5gRotAm+SmSjFbLBMHNOApXHIzW4ocVEN
	78WeBnzoeWwSVNsUm5R/iIctQmJOlNmv3G4vw3rbLg0+eDGGQ8G2gJzGP34DqFcClGFfq4+XSpFe9
	O0SASXxrx2m0dralk5Wy6TT35BZM2zii/9hOq0sbcGUu3k3NLbBldtE/ZQ8YOdvRNbuhf5JqmIqF8
	/OUV5ShmrAR/lFxyzPdzm7gJZTR94s5aYhRT5fUEUMoR89IlZzwzAmSqsZaDOIlfTBw9zRpUZvA+g
	Ly6MRhqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZIu-00000004QVW-1YjR;
	Fri, 20 Dec 2024 09:28:16 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZIs-00000004QUo-0qVq
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:28:15 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7292a83264eso1508718b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734686893; x=1735291693; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zGOstDBbuzWKPR4GcvKniMYiDdZSOAYV5X1DyfRCjKM=;
        b=lDJWqQ2ddwE68FMCiNJZmeWH6kuc3WAYceoBj9wAqqYky5lA+Kb27BhGOpE1zamY31
         l30ei6x4iuQAN7A7c3gjfZUed4dgkrD/+8iuNmgm68lFpci9a3AFcJNiPaIyUpqVPHLJ
         3zqmjR+eDzd5XIWpdn7v6egsElwMUQW7QnM24GerQIdnulHBMOYdBBD8NjnqPYInUjCk
         ZPnfczCR/Gc0ySJZFzjpnO1NZIwUq4w3MvrnECT8kw6GMwd+4PZ8JxINDqHFX3UUQE9H
         6cSK/Q6aKc8har2IT11BuE6B9vkDoK67RjJYeAsSjQynRUTnTKm0shSOZq4nI8vKET1C
         SgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686893; x=1735291693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGOstDBbuzWKPR4GcvKniMYiDdZSOAYV5X1DyfRCjKM=;
        b=stnFK1go1T/fVlNMa2o1eso1G1p1+67lQ7+pDBD+eU1hMVQt+NShL6mrrVdhihXgCm
         z8Sfg/MBm89F/rI4L2tI9ZN+VEvFS2m8I3IUIH/kRkYVorwO7rzyd11Gskt0gZ3Mm+GQ
         7FOJShblalrOsvueowdeS4slTbHiWTl79RMu8iSdjK0XEbNRm6QkCp1JfK/iNs3m3i0w
         UYqpK3LYCIsAGpb59pwtV8AoClrGB4EPKKCWg4t+F7/mqtcKb4YtBKMJ4PmBHXg4O1c6
         ZAOV8ycnI1fAntRDaPmRez4IWdYXHl6Y2BAAT3Q6OGVNy+WUxyC0Th+EvsvO70x0s0nn
         WjMg==
X-Gm-Message-State: AOJu0Yxz6ShvLWb+EmNHHBkkBYI3IsjhP9T9U49VqLldkHeVSE/IIoGi
	spM+4ekLxcdS3H/guZME4B8j2OFOEQMUHFqEfUt8YXC03npfcFrRkLR0Bx60vA==
X-Gm-Gg: ASbGncvt/YJ8G4gKb5PRUctS1HfYOGNOfwIqKicJ/ZmOy8gPg/LaLGiZ997rq/fBX12
	kPbTcGRA67O9gaBVp1vrtZQQYI736xg8ecme3a2MeaXwpf2I0YFeoGYwD6ocv/HkoEfRXUEI+49
	0S6tatW3CYb65JeMnkRDO3oQ/xjdJdyG7as/JVwQjU6J6NVsJobcDajDw4ZXoVwd9tNp6fQ56/8
	1pNGPRktqzm6rLtx0uQpCIidg/UJEtCD4vM4gMXFYGjVsiux0attWn6Xhv8ORCA6jwS
X-Google-Smtp-Source: AGHT+IGUBmYsueo5Wz7hkGJCR2jBDC8RNOZlfQ5c+U1fPAd+Ac3LpGvoXg6oS8pEIjjRlHfe5J9L1Q==
X-Received: by 2002:a05:6a00:3e13:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72abe060a05mr2947359b3a.16.1734686893272;
        Fri, 20 Dec 2024 01:28:13 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c25csm2674940b3a.199.2024.12.20.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:28:12 -0800 (PST)
Date: Fri, 20 Dec 2024 14:58:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241220092804.zgmge5pf7fm6wydp@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
 <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
 <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_012814_241185_C414940A 
X-CRM114-Status: GOOD (  21.35  )
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

On Fri, Dec 20, 2024 at 05:37:20PM +0900, Damien Le Moal wrote:
> On 12/20/24 17:14, Manivannan Sadhasivam wrote:
> > On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
> >> Add a documentation file
> >> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> >> endpoint target driver. This provides an overview of the driver
> >> requirements, capabilities and limitations. A user guide describing how
> >> to setup a NVMe PCI endpoint device using this driver is also provided.
> >>
> >> This document is made accessible also from the PCI endpoint
> >> documentation using a link. Furthermore, since the existing nvme
> >> documentation was not accessible from the top documentation index, an
> >> index file is added to Documentation/nvme and this index listed as
> >> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> >> API index.
> >>
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks.
> 
> > [...]
> > 
> >> +Configure the function using any device ID (the vendor ID for the device will
> >> +be automatically set to the same value as the NVMe target subsystem vendor
> >> +ID)::
> >> +
> >> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
> >> +        # echo 0xBEEF > nvmepf.0/deviceid
> > 
> > It'd be good to mention that the vendor id set with nvmet configfs will be
> > reused here.
> 
> Please re-read the sentence above the commands. I added exactly that :)
> 

Dang... I missed it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

