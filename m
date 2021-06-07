Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85534C47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DABF610E5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DABF610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=frs5O+c2f/1QFa3J2909UsaTjUtyU31Srq2/LdlJMzs=; b=bpkxXBrZxQJj7C
	ZoFpCaaXlF/NihviBO/ERMaeJOn/FI/n678nTfizMQoFGco0wKDJnJwWRLMfhID6ZbeC1mBzJ7DIO
	m9tgBcKOqQGr0Bab+8HODUfnsOtvvKlC90HfKI1Hli79V7n4VU+ATupCu2WQPNtvc2iOk4J5duE2w
	aYshppatB33goqxAR7Iv4IOLoOP7oOHtH0fVZnsFR8rjFhSDK4ofwjjeYwUnTQ9zuOj1yhI5Rlg/a
	C+xDabLZ+YMmfE0Oqh5oALHyQMPND2Mo64IevxFWi2eIfxRRJ74wqc8uXd/ekaYK4ADeWH8wm1CDR
	ybJqyNvEzV0HjCpYObxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqGN3-00458r-0k; Mon, 07 Jun 2021 14:36:53 +0000
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqGMx-00457w-Be
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 14:36:51 +0000
Received: by mail-oi1-f171.google.com with SMTP id v22so18272612oic.2
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 07:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BGnBmGjVJO7dExTR9Aq7lDjQTstrtJ/XYm4hMbstlbY=;
 b=ctZHDmSxGgI98e1yeBphgOf6y8bDjIfw9tIK7CO2/IKrjH6gwN/Ypfy49ApJI4r2OH
 eWYFbF/g6wkcRbj/sITIvkf0VJx43oZNGVdzuOYbl1HPcSPCLm+pYKx65xF2EC3vmUWR
 4oD1/BGtBPbyVUSQZENavoIMVQ9kV36sALzDCGm1FJ8nEMGaewdFGtsaTmsJ0wWcKwho
 wZA+tqr2g+DwDbnWf85Xs5cQ5WEdEiDcfxaUMyHU6cnvQD/7FgFj4Ys/x1gVmVsUsYW5
 KOLwM2BaANL/CoyyFg478ATlJDcnPUkpu9MJo3DGpE8MuI93OAk/7mexWfIFVw/cgPfJ
 NUcA==
X-Gm-Message-State: AOAM530apk61RtGezSmAktc7W4NsebXL36fvM358OW0TVnM3m7utpcjD
 I6bn037MhhZgtkar8l6ziW8bzBcc6EN5qfTtqxs=
X-Google-Smtp-Source: ABdhPJxB/kooTPoIoUjKiHNHSnVHPgjZf/KLnjPVAh8REreEBuCJ2hDeVY1y0dzbUUMKK+/yeMm+R8QXRtwO8HKex8s=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11556247oif.71.1623076606050; 
 Mon, 07 Jun 2021 07:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jun 2021 16:36:35 +0200
Message-ID: <CAJZ5v0iKDwttHxFSB5tTMgyaOcvM40oq474BzwE9mfX28n+BJQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] acpi: PM: Move check for _DSD StorageD3Enable
 property to acpi
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>, Prike Liang <prike.liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_073647_428634_D74E6AEB 
X-CRM114-Status: GOOD (  31.11  )
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

On Fri, Jun 4, 2021 at 6:54 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

You've received some tags on the v4, can you please resend it with the
tags added?

> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------
>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v4->v5:
>  * Correct extra "Link:" word in commit message
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..1edb68d00b8e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>         return 1;
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
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       u8 val;
> +
> +       if (!adev)
> +               return false;
> +       if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +                       &val))
> +               return false;
> +       return val == 1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_storage_d3);
> +
>  #endif /* CONFIG_PM */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..8fbc4c87a0d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_ACPI
> -static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -       struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -       u8 val;
> -
> -       /*
> -        * Look for _DSD property specifying that the storage device on the port
> -        * must use D3 to support deep platform power savings during
> -        * suspend-to-idle.
> -        */
> -
> -       if (!adev)
> -               return false;
> -       if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> -                       &val))
> -               return false;
> -       return val == 1;
> -}
> -#else
> -static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -       return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>         struct nvme_dev *dev = data;
> @@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         quirks |= check_vendor_combination_bug(pdev);
>
> -       if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +       if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>                 /*
>                  * Some systems use a bios work around to ask for D3 on
>                  * platforms that support kernel managed suspend.
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
>         return 0;
>  }
> +static inline bool acpi_storage_d3(struct device *dev)
> +{
> +       return false;
> +}
>  #endif
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
> --
> 2.25.1
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
