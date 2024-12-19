Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D9E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=; b=PUxmoO9Ub5PXzpacORKaf2+SFi
	2HrrO+nxIkqxs50ziHfddunyekKEQOtVN5mxGOTXRY9mzvyFFBMARXDxZhJERSooonv9PwZcODulI
	sLfhD5BOhNqjvYRjtsVFKKA+TjSkOpwFwmhd34cHiCTQKFyYPgAywsmqX+dEAQQrtGTIo/1YA0Vhi
	0uLeVm15RWBuCPaNx1CxV+OZYcARcVj6MA6nG+SHa+WmaLPjORIfWZpr1IMW6SN2iXDJmtS7tvmIW
	ExbVSnPDu0aC3YDPWuYFa7ZuYWQrMUolpBvfeZUjVzN0vvibL9R29VrPlvK1x8o6VDlcYnYWS5plb
	y//Q7q4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBVS-00000001CaE-0C4j;
	Thu, 19 Dec 2024 08:03:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBVR-00000001CZZ-13yv
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Dec 2024 08:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=; b=J/mm7tAQUJj2XRrtZCA3L9zeI/
	8sv59bzMKVEPGlLES67XYpqSJUsf7tDC1GiM9DlvOJpne6cQLU/AHHSmTmw71ndcTQpTGPSfKj+IO
	kDlYuhlCPwCWiXDVh8lE+KLqSTtfdR3Ta/oXILNRfcN65zMKyxlXZ8RytRtPuzaf4Cch3JcrBNKMn
	1IdXor9SSr7die8ueSHXL495ji0ROb+biNwsoDNNfBoUzV9Emezb9gwrpSYxLwQkmDvHxf2vf8/qa
	zbjx7Y/CjtBj5KhKZlCfgkjZbXTwhq96ime9XACOQYMl+4Z/4pMGYjujQbTtYLyLwUj2qA5S5q7X5
	C8rx/VcQ==;
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBVO-00000005PX0-1hoa
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 08:03:36 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-8019338c2b2so241879a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 00:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734595411; x=1735200211; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=;
        b=sxM4VED27cyfWtbCzWiv62cXFni0rrW/AfeRI/1D/JwlQIEC9OsRjvvMx38cMgaMnc
         /F8gkyUlK3KwIpkqyVsYBNWvpAIipfA0qhZie+Sg1/IoADLp72e4C5TRHNhiuJqPkQZI
         dhAgwWX8HRGlL+Nwv8NFOjMMAxX39lB6IgljY54iB+FSO1eVuba+H4ouvvLQr597LaCn
         wFMvTtnJItXb9J6RQ140AvBocEfCF67pwgE4bWIy0n6nYqc+Z5foJRVhRdASRYcRfWVA
         K3pbwyiJUjyVIEv3FsyaSamwfq83ZWC0o9Wc4b+wzgfKyrBg4xPUKE/P1wTFsgn8mFsu
         lDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595411; x=1735200211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=;
        b=Tn7CzkG2eD5hHZeoEx3W7KiLFJjupiFQ5wfmoEkxVdRjaCMg2+lT+Jx9DgLEivXGB4
         bAoSZD2rCHr3TriC4USjvuHJh6duYjPena5W5Kg86DTS8jMcUPIoAHn7/9efD3lHNk+8
         F70G3ZIp6S5HhLrVkq/qflPQiTRkCU/eb9CM3sNFFvYZKjRaCXr1sp+JkwTeAu2acNyC
         xE2oDqk32Z4fB5WvY6sB6XEIz39GsqNe3v7JwI3IIiM9epoCW1QY0CN7NKqTSVwOCjf9
         SbpRVVqvR4BQGlsHKp+WWMDordJvAShNz2qm8m3QPLFEzMh1tEOi2T5qYo6j4bxNjNuu
         wAgw==
X-Forwarded-Encrypted: i=1; AJvYcCXM24MvxxW6vbUcXOjM2xeaVRO82SlDpGYqba00n7asFO2m7UNRnr+PrXmpTAKr61BLW0zRT1WBpAxb@lists.infradead.org
X-Gm-Message-State: AOJu0YyCCODc78r2LfY5FymVIGB8jHHorrOUQ/XgLk+5sMYJ0fck2jCo
	6tQ4liG2VUMS8jvilCeJ7IVZH5xnj/c539eGFRCLbuP1aYkqTrKi07+UAKvFFQ==
X-Gm-Gg: ASbGncupZvdggn8dnk10GJRNtm7Ov5OLjUC2BWqiy/cOafAoufd0jSUOn/EEqXbwiUS
	EzrAFCIsbpqnr8Mu6VbUQ+CntF+6W3xoltOUNnJmfNRAiz5gmWWr0BO0PfpVA68vWfVvxq0cKW9
	cAwKS2rU7HX84EFsZn/Yy4OY4gwZVIhmTK8Dub01PxndX8QdYgnNrlXuGEsRu/gHrbs2ncEMFYI
	YJsfKl/Y4KOXwnAAiYDUL131Lcl7y7U1mXl6Kmxj/cHz+ockU+QSyKrsN2mwZogAsPt
X-Google-Smtp-Source: AGHT+IGkAKRKIGy2PWGUpJtb9ofOGf4tb9aPaoih3oeJ6FkCxuJrXISiTP6H5Og+dCW667T6Nacl4g==
X-Received: by 2002:a17:90b:524a:b0:2ee:d35c:39ab with SMTP id 98e67ed59e1d1-2f443d0189emr2977479a91.22.1734595410812;
        Thu, 19 Dec 2024 00:03:30 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cde6sm2963410a91.13.2024.12.19.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:03:30 -0800 (PST)
Date: Thu, 19 Dec 2024 13:33:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241219080322.gskydm7mg6srhv3p@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <20241219063052.GA20003@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219063052.GA20003@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_080334_538410_19BD1F7A 
X-CRM114-Status: GOOD (  14.42  )
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

On Thu, Dec 19, 2024 at 07:30:52AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 11:22:10PM +0530, Manivannan Sadhasivam wrote:
> > > So what technically is the problem?
> > > 
> > 
> > NVMe wear out is the problem.
> 
> Btw, it's not just the PE cycles, it's also the sheer time a clean
> shutdown can take (or the time for an unclean enable if we don't wait
> long enough).
> 

I do agree with you!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

