Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A383C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKwpMeRWLixHVGIEVwWAhvE6qsh+fQ54ma+33XFP9Qo=; b=x9Zfil3FxjRysMx4r7kLyDcOb3
	FuoRUcMH4KhJXrggeS40LK14NovgEFLB3+mPG+34qex4keCbPXZZf8mlc4i4h20aWz1L/G/Ykst4R
	biKzFWz6ux2onarqmOgEEXU95U0av+kfO/i2wRKqEV9aGzS7zkSSG67EIcE57VCCfVQZh9T8gsJS8
	3g4mrJpDFDLaCbhVc19DM2kcuKSaC2QTg/3nSWF9Id6ZEe803JZuiqzy8IRLqFSRhzsioyl3GagaU
	o1ZGMN8uJCkp5icPoj6TUdVb1SeB3LIRBYJPTmvUJ7aJ2ROGyMx6JGAARialcGLo1o6Wl4DvR/VUF
	yWbOFNRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nduZL-009FY2-TN; Mon, 11 Apr 2022 13:59:03 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nduZJ-009FWW-9O
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 13:59:02 +0000
Received: by mail-pg1-x52a.google.com with SMTP id q142so14231315pgq.9
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jKwpMeRWLixHVGIEVwWAhvE6qsh+fQ54ma+33XFP9Qo=;
 b=vONrMIN5TPHz0pVo8bpeK2ecGKClg0RgVeKc3x2nQWKp5822r2vVD9qiCK5fzycwkS
 XnR1LPf3So61JFYSaPLLr4GaRuGYqeVbYAGMSrV/IVOL0bsI1EFsKokv+TTh03PPk5nZ
 NijTxXnz2DGxnHh1/wsiGYA1tBQnuUUbzmwG7vyMNzMEMGqDL9cOA/KAwW6wTlh44HjY
 Q12pEVDfckwrUVU5nLpXHjwgVfTZUv31IqzHWyuzqEuc4FvhrBVEEQkks9r3B8GFsPOz
 tgaOvhVcLF2+58yK/74M8wHtUW5GOvf0k41p5mFakx1JQ1EBYQLn3eoBdvv8wsbpo8Ae
 i9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jKwpMeRWLixHVGIEVwWAhvE6qsh+fQ54ma+33XFP9Qo=;
 b=WXgSa0At3jJkAVAyMqtmiJojTAqBwFzhuHxDdfjdd5rin79bzuCoGxmD7UAnXTqjgi
 PfnIuaYzXiOcl/usrt8Z5Dr/dOu5TQp4XUGj/N+tOcyOz2hMI7INzfPiNhuO/mW3Rvl4
 eLvzk5R0wTzOOsylVN00kdJHFzIwIKjxKldbZMDNNbirQaFgA2x7mExezNotAxvat4hP
 xm4P67c0btwNQ6zb8xfbqa0oVKNYN/AujFJ6FGofrgcsu3s+UE8GX19+nhqDnJvPXbLo
 CprPcZdyL83i3T6mu2kzg96XeElR6Sgabz/3DlcABA12yxDs0Aj58vx0J2TxjTbQG/0z
 9u+g==
X-Gm-Message-State: AOAM533bfyaV4aw/1kMMIN7fBvjV/qkOpWjAHjhTpYSu3ngFyBBFv3A+
 R/Mg+mq5x1RvIK6N+KXMCFtG
X-Google-Smtp-Source: ABdhPJw7ybry4TP30O2H73uf6I4VYPted7Q/77nInPaYwl6/h0mTkp7ec/r1IOkxXj3a/OQPDQGoEw==
X-Received: by 2002:aa7:88d4:0:b0:4fd:ad26:c52f with SMTP id
 k20-20020aa788d4000000b004fdad26c52fmr32557564pff.25.1649685535814; 
 Mon, 11 Apr 2022 06:58:55 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 x6-20020a056a000bc600b005058a09f3aesm11574569pfu.147.2022.04.11.06.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 06:58:55 -0700 (PDT)
Date: Mon, 11 Apr 2022 19:28:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: hch@lst.de
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, kbusch@kernel.org
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220411135850.GA42637@thinkpad>
References: <20220201165006.3074615-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201165006.3074615-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_065901_382999_16F08637 
X-CRM114-Status: GOOD (  31.19  )
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

Hi Christoph,

On Tue, Feb 01, 2022 at 08:50:06AM -0800, Keith Busch wrote:
> There is no complete set of attributes a driver can check to know if
> nvme power management is the correct thing to do in a runtime suspend
> situation. Every attempt so far to optimize idle power consumption and
> resume latency for a particular platform just leads to regressions
> elsewhere.
> 
> Default to the simple shutdown since it is the historically safest
> option, and provide a user parameter to override it if the user knows
> it's safe to use for their platform.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215467
> Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I was looking into the nvme simple shutdown path for the Qualcomm platforms and
it looks to me that this patch from Keith is the way to go. I do agree with your
resistance on adding the platform level support to the nvme driver, but there is
no good way of working around it in the platform level.

PCI core only accepts the quirks for the host devices that could be passed onto
the PCI device drivers like this one. In this case, this is not a quirk but
actually an aggressive power saving feature (atleast on the Qcom platforms).
Moreover, adding a flag to the PCI bus will make it applicable to all the
child devices of the RC/bridge and that would be wrong.

In our case, the same power saving feature is not applicable to all PCI devices
like WLAN for an example.

Then if we try to add the platform specific support in nvme driver using the
of_machine_is_compatible() API, it will get piled up over the time. So just
using the simple shutdown as the default suspend choice and using the module
parameter to override it makes much sense to me.

Please let me know what you think.

Thanks,
Mani

> ---
>  drivers/nvme/host/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d8585df2c2fd..7e25cdef09a2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -103,6 +103,10 @@ static bool noacpi;
>  module_param(noacpi, bool, 0444);
>  MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
>  
> +static bool pwr_mgmt;
> +module_param(pwr_mgmt, bool, 0444);
> +MODULE_PARM_DESC(pwr_mgmt, "use nvme power management for runtime suspend");
> +
>  struct nvme_dev;
>  struct nvme_queue;
>  
> @@ -3094,7 +3098,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		dev_info(&pdev->dev,
>  			 "platform quirk: setting simple suspend\n");
>  		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> -	}
> +	} else if (!pwr_mgmt)
> +		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
>  
>  	/*
>  	 * Double check that our mempool alloc size will cover the biggest
> -- 
> 2.25.4

