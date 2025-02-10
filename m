Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17027C0219B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxE6aeuZ6icUuNgn0+qtoSgt4QTImDEuV+J46d7tdCE=; b=dcyp3NIxH5ssKrwNt2PhkhuBM1
	k8CLwfR1DDB/UJj1VhOrTNDbo9KrY8tSuecwpMdZn/DQMYhgqMb+8DtcT+fPJ3ESN/JUHyqBmPlYd
	uIOn+/HVzSDjOM+6Fh5q5zosYCQP9bA4P8vt4H5Dgm1bZaWaoqY7n3ed0jXs1K/z6ev3FLTHMuFiv
	0sy8j2JF9TZ5x7y1XTtv6T7xuLz4XaPz1LSFgU6HzZGx0qTmH+fg5H4tNhQpqL12N0DW+A3vNJP6r
	E7VUFoZu4SeEWI4Ox4+4JaIKU2FfXuZmkVrNUepQTzkDk4H9ngSu/XOoB29qRGfGglhE8LvN5JTsw
	hH+2t9kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thNSa-0000000GOgL-1RmG;
	Mon, 10 Feb 2025 06:40:00 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thNSW-0000000GOev-3HP1
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 06:39:58 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21f40deb941so79991445ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 09 Feb 2025 22:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739169593; x=1739774393; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LxE6aeuZ6icUuNgn0+qtoSgt4QTImDEuV+J46d7tdCE=;
        b=i3Ck/sIXrvZBWstgPVReLM0AMrj0Y7DQw+xO7Td7X+2VlzJiv1qXDCa1od5vMaNoYR
         C3Qb4ib9vSXWYTfheE9B1c8uOhqsP9xsIAMNA0d4R58wDSh9l5JryBZUB/r+Etmc3J7W
         2DtU1qJUho1MKQnvGHv5GCuZrqFUkf6/F59JVaFNKztpp8vSg9CFGRAXL/Ewe3Ad21B+
         uStKx/RUXnbXHXMyPZGYBozxdDwV1zjAC4RSdO+g9uDAlJC7opF3Q0T+WcDUKwNAMfqJ
         klBtzxK4pAgm0v+//fesxjITg+BqP9Ey1cTafi+C0AV97HHPqZucVEBzb9jSVu9sUXwu
         spcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739169593; x=1739774393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxE6aeuZ6icUuNgn0+qtoSgt4QTImDEuV+J46d7tdCE=;
        b=KP//rileCwnnTXOiKXISBW8ibmxBmomjbbOH+M/moH0BzE4HgYs6tnOKtCIOIgcwUM
         tcjwzjqdrBF+6XcGe4kmN4lH3fPCjCpm+Ph5JNg/TlXB9UchmM0tYyBxeEsd62UbloXs
         3yqmEX/KI1EIDY0FrJ2eBt/4zQILyQs5XTHo6ICUFLcFVvG/LTOB4BWXhLeD+Ryh2skP
         HJa2E9/HvDHV5djS/5gc2icjV/T32fdOPW/vNBlffzw/x/FxJ6Nq09jUSVdzHBoeHzyC
         7d1yI9US1oixSfCLYW0nfp97dBSkjVQxPWWhp2yZ3aOIH0ScINP7LeQgAj7MDlOTEL6n
         YPVg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBkQW6LiJ+k2pLWjVUh8AfmYrMDV4zs4m24NrvM605CjwMtOo2qHLwfNp5rO0gFIdbJGDNS6JxStP@lists.infradead.org
X-Gm-Message-State: AOJu0YyO/3xXhEkdTx9n+4gJ3Ywy1wz9hgeTKm5DBYzjnr5S1UKUEYwt
	P01qxcrp7NOYSfm8Lp7mo9r6izVXAktNxaPsnexYzF7l7Hbigkt+aC6aMGpz0w==
X-Gm-Gg: ASbGncvnH08jf4OUUzXsOObPNDRM4b3waQ7mKJC2ULICe5fgOlOM+H/vvaxnmgPhpzz
	I6ZEslc7AOZu+BoMvaruGrsqPbLE/UCGxffpt6+v0UJbc++KHxTNHy+hbMTdkymVh7o2ngZLoIg
	CH4gp0QOdqIWtCFXjesoDaQyhy8JB+1IwMwiWTi9PUB45oTJwTtBgSDWId2vcGUB0ZVo9w+MQ+0
	+cQSy44z8eD/O0tCzQrsqwyu2R5tqKI2tdZcEm5TBABgHsYcXRQtb/F3AEUmqGAvAw9IeM+1nmS
	qxY7UweroDeO4cq9myeB0KrC7y9S
X-Google-Smtp-Source: AGHT+IEsvR90d7Y3wwFLt9xyFfk3qexrds3FNoWUB2eioUnWhv5DCGZoPflNo843Qb/ySzyODQ8qCA==
X-Received: by 2002:a17:902:e946:b0:216:7cde:51a with SMTP id d9443c01a7336-21f4e72631dmr229479615ad.28.1739169593619;
        Sun, 09 Feb 2025 22:39:53 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d51ebsm70739595ad.252.2025.02.09.22.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 22:39:53 -0800 (PST)
Date: Mon, 10 Feb 2025 12:09:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250210063948.xjf5rupebhljujgd@thinkpad>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
 <20250208185124.GA1120888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250208185124.GA1120888@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_223956_826082_70E102F9 
X-CRM114-Status: GOOD (  19.14  )
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

On Sat, Feb 08, 2025 at 12:51:24PM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 26, 2025 at 10:33:09AM +0530, Manivannan Sadhasivam wrote:
> > On these platforms, power to the PCIe bus is not retained if the SoC enters
> > its own deep low power state called, CX power collapse state during system
> > suspend. Once the SoC resumes after going through CX power collapse, all
> > the PCIe bus state will be lost. So the NVMe devices on these platforms
> > won't resume properly, rendering the machines useless until forcefully
> > restarted by the users.
> 
> I guess "forcefully restarted" means a power cycle?
> 

Yes!

> > +++ b/drivers/nvme/host/pci.c
> > @@ -3162,6 +3162,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
> >  	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
> >  		return NVME_QUIRK_NO_APST;
> >  
> > +	/*
> > +	 * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
> > +	 * power to the PCIe bus after entering low power CX power collapse
> > +	 * state during system suspend. So shutdown the NVMe devices to have a
> > +	 * working system suspend on these platforms.
> > +	 */
> > +	if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
> > +	    dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
> > +		return NVME_QUIRK_SIMPLE_SUSPEND;
> 
> I certainly acknowledge that this is a big problem for users.  At the
> same time, this seems like a maintenance nightmare of
> platform-specific hacks scattered through endpoint drivers.

This chipset is only used in Laptop form factors where there are no open PCIe
slots. And we have seen the issue with only the NVMe driver as the rest of the
endpoint drivers (WLAN, Modem) are all behaving fine.

But as I mentioned comments section, this is only an interim solution.
Obviously, we would like to have a generic solution available in PCI/PM core and
we'd certainly work towards that. Once that happens, this quirk can be reverted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

