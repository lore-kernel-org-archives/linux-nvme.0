Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01623C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F3B6105A
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 14:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F3B6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ktx0E7Tsi7fArLDZKZk5TYGD1ZhySABG+MHnQOH3ktE=; b=F/BJbDDoVjn8ES
	jYpcRS5vOBS/levqG8CC+XPliT4FZxzctBQ+2p5yvpSfUrv5XhTdnmP77JcQq0duRtFXZEFQ7NFBJ
	/MD2/GVPscKefZm2I8yyEDt5VyoWLpUA1h6JR3VRDfYCyKT88FdKOswdV3y9skLnXk/XlaL8UNqI9
	PE7m0Rpjse+bO6KDvy37fI3qIpd5tk/lJLwezaozDFdaX3WDy8YPXK5J2S1QfTnxzBy09f7a1OrgW
	QniW69WvU+karkIlOolT5PxhKEM3UCQzBfOSCbGG7Y3bL6J1EFwvTKSjAcMgcQ3OcDVXRuzREJAt7
	FMsqCXv3h07X58K9+3AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqGPo-0045lj-C5; Mon, 07 Jun 2021 14:39:44 +0000
Received: from mail-oi1-f172.google.com ([209.85.167.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqGPi-0045jt-OA
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 14:39:43 +0000
Received: by mail-oi1-f172.google.com with SMTP id t40so5254258oiw.8
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 07:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l7a14rpcAIDQKHi45PdwrQP7pOJuz2pmW2YKVutjVaU=;
 b=GfYW2VPbV/ltr1JAo2F/3nqvtT28Kr6AmuSJ0GcBh5YmakIEAbqdAQf2C5I8scTYqA
 Ko3MGMJksVogTvaoz0kgrh+4SvvNq4vMaSNacmCVnsqHzkd2gs0/KGIBwTj8yb3pqK2w
 qsMNJHsvphoYJj5IJW57JmXXr+JqO0y8Si46cwcIrc6t3Tp57LQGIsdi7IfYTyw1XXN8
 FYLO3768o23uO3BUWTVSSLJmyORA5HMwotDFGquYxzhIkHG73jxNepLISt7MvWkxp5a0
 uehMvocMOqqqGJm9UNedeDBRqQcUQmCiQg5YZe74WeVnQoaW5mxrf1KV361kB+Qnf/MH
 4jWA==
X-Gm-Message-State: AOAM533WHdou29hWELa+k+dCJeaPcnlDfDwOrKHu2n6IjDx4NYp3sBwl
 o/ehM3Ukce8A0LbmmCgwlanzsrqDV2P5gdUJFnI=
X-Google-Smtp-Source: ABdhPJy0WC7qMbNYOvNH9vpw+qGf7mgy9n6UTfUfHj8GaZfxHpxb1wUJ0vUU65w2Yx6S2TxGOXLSYNEnLJteCUuYUbA=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11564478oif.71.1623076777341; 
 Mon, 07 Jun 2021 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jun 2021 16:39:26 +0200
Message-ID: <CAJZ5v0g5KCkE4eRSjKZgX14Nm3FNKQmfzsCYzfigD-M-uT5QJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>, Prike Liang <prike.liang@amd.com>, 
 Julian Sikorski <belegdol@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_073938_818286_EBD7D896 
X-CRM114-Status: GOOD (  29.87  )
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
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
>
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
>
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
>
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
>
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> Changes from v4->v5:
>  * Add this patch back in as it's been made apparent that the
>    system needs to be hardcoded for these.
>    Changes:
>    - Drop Cezanne - it's now covered by StorageD3Enable
>    - Rebase ontop of acpi_storage_d3 outside of NVME
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 1edb68d00b8e..8fd2a15bf478 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -20,6 +20,10 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#endif

This is a generic file, not x86 (or any other arch-specific)
#ifdeffery in it, please.

There is the x86/ subdir under drivers/acpi/ for x86-specific stuff.

> +
>  #include "internal.h"
>
>  /**
> @@ -1341,6 +1345,15 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>
> +
> +#ifdef CONFIG_X86
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +#endif
> +
>  /**
>   * acpi_storage_d3 - Check if a storage device should use D3.
>   * @dev: Device to check
> @@ -1356,6 +1369,12 @@ bool acpi_storage_d3(struct device *dev)
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>         u8 val;
>
> +#ifdef CONFIG_X86
> +       /* Devices requiring D3, but from before StorageD3Enable was "standardized" */
> +       if (x86_match_cpu(storage_d3_cpu_ids))
> +               return true;
> +#endif
> +
>         if (!adev)
>                 return false;
>         if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> --
> 2.25.1
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
