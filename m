Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EEEC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 13:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901F6023B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 13:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901F6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AfzW3AqCTaXMP0zqP7w9TPKeY2Oqw9XA+8xwLGQL8yg=; b=qbCJLaykzpJ7jw
	GLZYLwuAi1Qt4kBPGtgItwmkgmGLp59kBxt1N+vpz1iBE6Bjuu0qxzw8TZws3ttNyj2ulLBoze9IJ
	Gony/r+TSaXHz9QMr13gKNz5v1ajibUzseaXuYTC4bNfXfzMVhhgTCNFEt8xSJndRNit2yHtA4Tlk
	dV10eBPu/JzFcCmDNlbb0R+vlL33KSKnzzpUpvITtKXNP2HQ/BylzBZnMI5Y2prUJqjii+Xb/rC+V
	3BrWliEaZrIzg4RiRijuGvhnAULuaA+EQW+AD9JBaF5q7pAGfvT9rBFXQ+TYjd7xc4jn98rs08Kmo
	QmJfWthI59IavwJ9Vr1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqEv4-003fgQ-QM; Mon, 07 Jun 2021 13:03:54 +0000
Received: from mail-oi1-f178.google.com ([209.85.167.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqEl8-003d1C-2n
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 12:53:40 +0000
Received: by mail-oi1-f178.google.com with SMTP id v142so17474233oie.9
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 05:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UJbb0wgONzKu6GOCNY92/rs+FfpsCbB7IddM4Al1SgU=;
 b=sz8VK6MUOXC5v7Gpaac7rV963KFBkB9fpSZ2FWgXCe6/CpopD4deZ2xektftf5tmDk
 PNRB3PBX7c+VXPmAYUpaJvuBiZ96E9eJZ2K5kmvXaOL1bftwIF7aIAEHBjy2UwwBRacx
 HtOfrM0AbtdT0EXtL94z8+QC9LBUsxGxV1v6Ez59THt/MGlhNrJCphnx3XJpYCtW1joX
 +Kjc0EAVIiG87HA/k8p7cj83QTYvceJ4Ew/OIzz/K2wSrjUlL1UXOAmRHTdChKRJk0Yr
 h+k/LAs3EgPnYU3FLlEVBnxoVXBXcBPtzEOFud63v2Egkn/NJzOz2lbBJNf9ZKIb0J3f
 8qqw==
X-Gm-Message-State: AOAM530Xs7pSr3d2+FvanHciKYgA3XzzUVnwvDCk/OoyTF1wJB2W9o4b
 eEsdOK6C8iab0lJx+ZjCjcaAApLfINNtXm8KEEE=
X-Google-Smtp-Source: ABdhPJywaXK6YUCVA3bLWmnpzW2BajWBXA2vWUnK0Z5R0D7fqxT9XN/AkxnBQ4DBNS61nhJar33gtOu6WmCUTqZU71M=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3080478oim.157.1623070415240; 
 Mon, 07 Jun 2021 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210603190753.5084-1-mario.limonciello@amd.com>
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jun 2021 14:53:24 +0200
Message-ID: <CAJZ5v0hH_XuMucyYef=Cq-WNWt2aiVWmV5v-tm77AZ+R7HZFxg@mail.gmail.com>
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to
 acpi
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
X-CRM114-CacheID: sfid-20210607_055338_170828_11C6E924 
X-CRM114-Status: GOOD (  30.75  )
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

On Thu, Jun 3, 2021 at 9:08 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.

Please spell ACPI in capitals in the subject.

Otherwise

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to take this patch (in which case
I'll need ACKs from the PCI and NVMe side).

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
