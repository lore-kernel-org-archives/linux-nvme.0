Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB576C48BD1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:31:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F316108E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F316108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bYjXeCMjdH4AOJkOR2oQy1pSEu8MF0TE9FM/eIN2hac=; b=4OHw3pM5pycJIN
	udXXIyFZWkfQ2i5uJT3vEvzMYyWfHULdNvyVEzFnagZQKBaQvILfZKAeiP1Wlbw4NJdOEZ1HGpjG1
	vSmzRJn3RaFlAfOzwdN4dKPd1ApGI4kT4C/sPrdgRQYjh0TZm+0TUSOzD3AX/+CS3eC+9fqpeudbe
	WE3s/4k1beTjuL+LT5u+pTQBHJIpHIoK4ZdeG5bxZffPZ7uyq3tETR5fvnUdiMAcK82BTqnC0Ao5d
	o96hxTcQ2DB9/p2d9SvfpGzBm5xsfVyC1zOG5vvRazdPFS1nRj4FLHnLuE9lMm3P2AMgv9nCT8Zgx
	CZvs/G9SDqQy6czx30OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqyIb-00E0aO-Gc; Wed, 09 Jun 2021 13:31:13 +0000
Received: from mail-ot1-f42.google.com ([209.85.210.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqxpa-00Dsbx-7o
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 13:01:16 +0000
Received: by mail-ot1-f42.google.com with SMTP id
 v27-20020a056830091bb02903cd67d40070so20741391ott.1
 for <linux-nvme@lists.infradead.org>; Wed, 09 Jun 2021 06:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LPch2CZp0YDxdhlusMBnDUEUBjoN7mID6s1Wz3gtiAw=;
 b=NfhVpOeVdI3wbrwB4tIuZAgrRS0vr0TvsBJfVrLwTaMjs7Jr7MXTdypKkS278A3ZPi
 X5OVmcxgE+TYF+qF+SzAUdlKDqCpnLNONraH2ROj1GjUl3raI1xKi5Xk6sn2jDEq9AAn
 XbP4tDF3Qa2EJqF3vvKNmz4rK+3DeTeacJXMdwxJ9/oWKmkRyB7g4/GUEQ9Jtj8SvW2k
 +Th3D6fWF4y5XPdRGSbiKJPW8RgCnnRwDfwG65C5m58vlavz+hmP6O9W0wkW4IlPEMkk
 NWMa2pXoR2YMSJoWleUCytyT3aD//AoquQXpkf7nmbKJ552A7TiuIz3mGONuUKDjuZXA
 Ggew==
X-Gm-Message-State: AOAM531tilU6IWbbQipkivq5Wh0/Fiw3WC65KHVYNzXeKgZ2Km4RH6Qj
 fg25f2pjry175UR5somg8TXDJ/Ev8kCb7F0TIzA=
X-Google-Smtp-Source: ABdhPJzXxpffk7bpfRbobEHMl8RH6HQtZvmiuIU0PKxt/WpfUAZB9KM7fUhP7CpCRy3Uvwh9FggDWVfBX2ur7hIXFAQ=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr22353417otg.260.1623243672804; 
 Wed, 09 Jun 2021 06:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154255.8693-1-mario.limonciello@amd.com>
In-Reply-To: <20210608154255.8693-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jun 2021 15:01:01 +0200
Message-ID: <CAJZ5v0ik+kEn9eZ_g4=i=qW_08p2-PekT2tW4AivwUNc-NmHiA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Nehal-bakulchandra.Shah@amd.com, Alex Deucher <Alexander.Deucher@amd.com>, 
 Prike Liang <prike.liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_060114_337840_3526E842 
X-CRM114-Status: GOOD (  35.28  )
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

On Tue, Jun 8, 2021 at 5:43 PM Mario Limonciello
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
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------

This appears to be based on an nvme commit that is not there in the
mainline, so I cannot apply it as is.

If you change the subject to something like

"ACPI: Check StorageD3Enable _DSD property in ACPI code"

and modify the acpi_storage_d3() kerneldoc as per the remark below,
please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it and route it via nvme.

>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v4->v5:
>  * Correct extra "Link:" word in commit message
> Changes from v5->v6:
>  * Add in commit message tags from Raul, Rafael and Keith
> Changes from v6->v7:
>  * Update kerneldoc comments per suggestsions.
>  * Drop all Acked/Reviewed tags
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..c45f2d76b67e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>         return 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3 in the suspend path

Please change this to something like "Check if D3 should be used in
the suspend path" as this generally isn't about storage only.

> + * @dev: Device to check
> + *
> + * Return %true if the platform firmware wants @dev to be programmed
> + * into D3hot or D3cold (if supported) in the suspend path, or %false
> + * when there is no specific preference. On some platforms, if this
> + * hint is ignored, @dev may remain unresponsive after suspending the
> + * platform as a whole.
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
