Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C16E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 14:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=; b=z86dxF4H6jrPWz7q8HOojVQyiG
	tizOpssb4CJkgOY/6n2ILojOl/ZO98jNFK1ziF1nDneVHM+SJL1Au/u/T4JUzjfe2k2+UTjeFP7f/
	QJ+1jILcW575FK5dUbhs6ZbRtCi5ygz/NK7i5DKZjM/CN6yL+YFTys9b9FlBB3nUteM4Cflbmh1Wx
	TysXI+9bFvZXl5mZimiswqYvGO2X1NYAHuFmNbondudIXcl1fthyRp4guDWBBHLJguaxyxdHUOcPR
	L5+skSvgSFyLAL5JqA8qLdiWRSaZ/4Q8Gc0zXfks+A4LF2Vbeu3XY+BaoLmR103jgSwWFjfXjg5p7
	ZtS3aTzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKeu7-00000008EPH-0gtY;
	Mon, 09 Dec 2024 14:38:31 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKeu4-00000008EOg-2QEB
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 14:38:29 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3600905a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755107; x=1734359907; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=PQiMIuFQsWP4zNq1BfM4EUaHzhK6V1c7+dpKV07TJWzNDMRuFBW5o49/y9uWX42JOe
         NO0+Q7eyAV0fRfPmeANwPUu6kz8HsI1e5Aatl4RNwGotpqNw45ok/OX8V/y/RcdHfOLZ
         zRtbvVCWVDlVtNx2bWkCoA5XEJjk2Xgly0+5OXNDSamJIOt4EEyXsEsIej8SPVo8xj+D
         Y3EsI9ZAu6u50O5MmkW5c6G+G+oCzzj4Dynt+aXSkkTPpzpQausJx7oXqh2EFVXcj2F4
         ykkvKzrF0yqAw2gcWDGpxj3x+waJkZgmit0SK7JJ74dGnbi9vLunG00KLRwpOQoJ6AVd
         lLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755107; x=1734359907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=pAUXexNQnjWBZ9F2gze7nVimOxct0B2DKHLZkDdNe7a57B2bBgUS7acziQS0oulCSo
         QrFwQgbE0QNBYruSt3bsg2ghJEuaR43B7MwLw3o8yTuLa4adVWhlHP60HMeDhq2+WHvM
         0/0FaVnCiotC2r/nWlB4+FXn7wVp61+knt5aHA9ldqnOHHueXjNAOb3BzZ4E3wMAgNAQ
         Oz7oj33+4ymcBvdK+ZTK/UCTVXbgCCLIh98GxIK6WbK1XgratRqfH4MCEglL9fRs9ShV
         vYvZPIwPFqbZfW1uM5NTWt9vzksx2PnY3hv/IJpTSS0px/TQg0Vk4IHZLiO+GMkl/K53
         OrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnhBnDMpYzvRfj0SYz7y2GU+gHDGFNGCEdf38crcvuDbFMl5h4HDajF47lVvgNGMlJBHmBxLpj+6iI@lists.infradead.org
X-Gm-Message-State: AOJu0Ywb2/FgnMCWpJ2gnqM7xr4NDwwETau+7bXwsoxApvZ8nR1hMboe
	gv7HgSmfZwC275Gi2SAE+MY5gVNfGYbPsw6uLa13Qkf/w/ki7y2ACRgC1znrBw==
X-Gm-Gg: ASbGncuD5M7unpMhUEu1gFEeWtgml6qgn+mJDifvUpRGDQE54ns76MODwwOOD8it6pg
	UJmiipgdKeYDlSMh4KiTnexsKoZFK80yP9zSmnukkelnaIYrITKdnWVq9Q1+yK+zcL9ghHih8c+
	3lV0kKR60Z0VELYh7SEqrdnq5eSfAVWU0kS7lsceTwx9nK0JgmxK4ApQhahSMRsn2O4MWcV27Xr
	AYImcOoe7WPUlYflTWZ5M90s04PmKhKz2FT3Hyj0Mq6tY8qHmIe2q70O13P
X-Google-Smtp-Source: AGHT+IEjPNjheOz3H9P3KXCwrAQ0y1vhFh9v5UWKuqQE+ayZeQAQXxalmpEVYcnYnJ4nAlOJIgjr+w==
X-Received: by 2002:a05:6a20:d526:b0:1e1:f5a:db33 with SMTP id adf61e73a8af0-1e18712d2a0mr18475477637.36.1733755107284;
        Mon, 09 Dec 2024 06:38:27 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4681b0d5sm2644867a12.24.2024.12.09.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:38:26 -0800 (PST)
Date: Mon, 9 Dec 2024 20:08:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209143821.m4dahsaqeydluyf3@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241206014934.GA3081609@bhelgaas>
 <20241209133606.GA18172@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209133606.GA18172@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_063828_624160_BA010C50 
X-CRM114-Status: GOOD (  28.89  )
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

On Mon, Dec 09, 2024 at 02:36:06PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> > Oops, I think I got this part backwards.  The patch uses PCI PM if
> > d3cold_allowed is set, and it's set by default, so it does what you
> > need for the Qualcomm platform *without* user intervention.
> > 
> > But I guess using the flag allows users in other situations to force
> > use of NVMe power management by clearing d3cold_allowed via sysfs.
> > Does that mean some unspecified other platforms might only work
> > correctly with that user intervention?
> 
> Still seems awkward to overload fields like this.
> 
> The istory here is the the NVMe internal power states are significantly
> better for the SSDs.  It avoid shutting down the SSD frequently, which
> creates a lot of extra erase cycles and reduces life time.  It also
> prevents the SSD from performing maintainance operations while the host
> system is idle, which is the perfect time for them.  But the idea of
> putting all periphals into D3 is gaining a lot of ground because it
> makes the platform vendors life a lot simpler at the cost of others.

No, I disagree with the last comment. When the system goes to low power mode
(like S2R/hibernate), it *does* makes a lot of sense to put the devices into
D3Cold to save power. Using NVMe or other endpoint devices internal power states
only matters when the system is idle (which is not S2R/hibernate). This is what
ACPI is doing currently.

Then one might suggest to check the suspend state using
'pm_suspend_target_state' in device drivers and decide to keep the devices in
D3Cold. Unfortunately, it won't work for Qcom platforms as most of them (except
chromebooks) don't have S2R (a.k.a PSCI_SYSTEM_SUSPEND), but only S2Idle.

When it comes to non-Qcom platforms based on devicetree, they also cannot power
down the NVMe device during suspend (as they cannot satisfy existing checks in
nvme_suspend()).

The current reality is that most of the devicetree platforms *do* want to power
down the NVMe during suspend. Only when NVMe is used in an OS like Android, we
might not want to do so (that's something for future, but still a possibility). 

So this is how I ended up using the existing 'd3cold_allowed' attribute as it
allows the devices to be powered down by default and if the OS doesn't want to
do so, it can tweak the attribute from userspace (similar to UFS in Android).

The flexibility of this attribute is that it just acts as a hint for the device
drivers. If the device driver doesn't want to do D3Cold (when used as a wakeup
source etc...) it can still opt out (assuming that the platform would also honor
the wakeup capability of the device).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

