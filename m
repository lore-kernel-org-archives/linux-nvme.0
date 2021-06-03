Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F48C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 22:28:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE6261402
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 22:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE6261402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g8X3IDDmI7lrt4ntoPElz8ftSGNeJyQO4GQkdgpL4Iw=; b=vxv/PLcVknH9Yr
	xwJwMbjzT6pNjzoaHVumaLSl+IzetByiecXqamGHE3Eaz3ogjNpDoQ6AKBLfv9vlm6EpsimNchX/x
	uaZXYQurIx1u0zSNc77q4rZzIS9NeunmYOLZpEQcmxpC67uA0kpWz4S8aDjhCARSk59UNOP0r8lpu
	hzTL/67BEk7g0WrD6ZNhlgJqd6+k0R3RiDjwPYWNCB27PjNre3IVKOWOIIQVhoN5e+czlIY2T78sG
	dRx5RkF2b/Ed/hi/lJe8DCLQ73VDlVh2Wc62z0buScc2r3E6VeUZwbUmcu+dICbHJtepanI2NRT/S
	Bkil8w7C5DpupHocLmbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lovok-00Ao9x-RO; Thu, 03 Jun 2021 22:27:58 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lovog-00Ao7c-G0
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 22:27:57 +0000
Received: by mail-il1-x12f.google.com with SMTP id a8so5906801ilv.9
 for <linux-nvme@lists.infradead.org>; Thu, 03 Jun 2021 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EYQbcvibiQg/DnUam+wLaSOQ2UV3ZafOtj4rPommSME=;
 b=eONCVyJG8reQysQ4HqQPn9JbnCwm9R7Mi3NhkPGLL6ItUR1Ov5MqfX4dG4+ncwb8Ge
 rzh7THXy3i1zBca3kiJxC2exppTDkk5034+bLFlDBTTqi4Dr/kCD/WQ9/GnUKKipi9af
 9nqMvBaMbcjx1O+Q2okxWyQdYxHvmNj5NSfGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EYQbcvibiQg/DnUam+wLaSOQ2UV3ZafOtj4rPommSME=;
 b=iYFkqBIMn6RurFWAnKsGFc0lahkD0hKp+2pKH8BBdkgX5Yt9qO/6Bt4WcxSzuLt2Rx
 BllMuGPKcOxv7L0UhcmiMgenTb+x88VNe43Bx+QdFyk593Q/XOJbohWAmytpmQxZAqcc
 /pey5fkW5xjaaPZRcqA4LTANZEuK29eCu+Ik28rTdnA4GHBXeeRCDsdLAMZCePnxjuOM
 hKN/wpT5wkOR8P/u63RRvOh5esgI5+dSvzzFahLRMbLcqdZtu22I/daN6LuKvRR+8pat
 jYGmsvW2w2UORf/ulJTiOSAzwjSVjiS2Yie8StAWk2XwKpd5p8lzGaxaCLmLiIHOjZA/
 Qi3A==
X-Gm-Message-State: AOAM5300AWuTG5JdKZ78zJvKa9+yWE0LtCB9gD60+En48/mYN1Qz9YzB
 W2/9dhfaH1Uf6eqNr/sN5+r6XQ==
X-Google-Smtp-Source: ABdhPJy2cCbn6S+OVOgxep7zZ4X+W9504GaOSMvrUiXR2300RkJaKnIP7U+IUGkRNuwwA7/yX/MVCA==
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr1317896ile.274.1622759271677; 
 Thu, 03 Jun 2021 15:27:51 -0700 (PDT)
Received: from google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net.
 [184.60.195.141])
 by smtp.gmail.com with ESMTPSA id z14sm2492618ilb.48.2021.06.03.15.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 15:27:51 -0700 (PDT)
Date: Thu, 3 Jun 2021 16:27:49 -0600
From: Raul E Rangel <rrangel@chromium.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
 Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com, prike.liang@amd.com
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to
 acpi
Message-ID: <YLlXZcp6ne7hcXNM@google.com>
References: <20210603190753.5084-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_152754_601573_43DEB54B 
X-CRM114-Status: GOOD (  30.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 03, 2021 at 02:07:53PM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
> 
> Link: Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: rrangel@chromium.org
> CC: david.e.box@linux.intel.com
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------
>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
> 
> Changes from v3->v4
>  * Rebase on nvme-5.14 (w/ patch 1/2 from v3 of series accepted)
>  * Adjust commit message per Christoph's suggestions
>  * Adjust documentation per Christoph's suggestions
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..1edb68d00b8e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3.
> + * @dev: Device to check
> + *
> + * Returns %true if @dev should be put into D3 when the ->suspend method is
> + * called, else %false.  The name of this function is somewhat misleading
> + * as it has nothing to do with storage except for the name of the ACPI
> + * property.  On some platforms resume will not work if this hint is ignored.
> + *
> + */
> +bool acpi_storage_d3(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	u8 val;
> +
> +	if (!adev)
> +		return false;
> +	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +			&val))
> +		return false;
> +	return val == 1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_storage_d3);
> +
>  #endif /* CONFIG_PM */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..8fbc4c87a0d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_ACPI
> -static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -	u8 val;
> -
> -	/*
> -	 * Look for _DSD property specifying that the storage device on the port
> -	 * must use D3 to support deep platform power savings during
> -	 * suspend-to-idle.
> -	 */
> -
> -	if (!adev)
> -		return false;
> -	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> -			&val))
> -		return false;
> -	return val == 1;
> -}
> -#else
> -static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>  	struct nvme_dev *dev = data;
> @@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	quirks |= check_vendor_combination_bug(pdev);
>  
> -	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>  		/*
>  		 * Some systems use a bios work around to ask for D3 on
>  		 * platforms that support kernel managed suspend.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..dd0dafd21e33 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
>  int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> +bool acpi_storage_d3(struct device *dev);
>  #else
>  static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
> @@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>  	return 0;
>  }
> +static inline bool acpi_storage_d3(struct device *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)

Tested on an AMD Chromebook and it still works.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
