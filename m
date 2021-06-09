Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE6CC48BCD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2724F613B8
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724F613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lc0htxyPRoOsEQp5kQ40D8ZCy/p/uxPtXtFSR21wRgk=; b=PhckZhBcSE8lCh
	t6NdbaxZsBTtdv0b5rj923khpPy3Wgq32iVnh3Byx/JQlH2cKVN45yQRlf0Nj8u6COPcWHmQe1Zms
	UmsLJyr52dkJjp01Ub6CXP/feN5IY46GeGzvuUSyf47JU9qiposrFADyXp35nHygp60N4VpLGLHZ/
	lDSYBAsX2vDjipuhP4ye8sBqQ06Ht/ZiAFyR8ZZ4mmEhZKk/kc66NyZUDEWlRFLfi3ZsdOSxG6UcX
	hJxlgBcYK6bp2nSDRa5JpeRiWWTtbMwdUkh0i9TraVHcsLY1YqrwQcC3+Tksy/4Nso7mHLJEiIp31
	rwgoBikj2RwX4dtiK7gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqyKz-00E19D-KG; Wed, 09 Jun 2021 13:33:41 +0000
Received: from mail-ot1-f41.google.com ([209.85.210.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqxqV-00DsrB-LQ
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 13:02:13 +0000
Received: by mail-ot1-f41.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so23834276oth.8
 for <linux-nvme@lists.infradead.org>; Wed, 09 Jun 2021 06:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOMB9VcGIsLxTCSfGIXF8Bd/z/LUoxmBOfes4pXl5ik=;
 b=J8UPn3rl4Pbf5Si0+JG9eG66bofVpVLF07vB3qjqH7GgaCpyWKNn5P2s0mWmDpltWv
 c44gXx0yMu6b/cVkYs/0sEW4o3H14TA4r16xmW6x0J40jnlftW8UGScP9N+dzjAeCp+m
 fhzViV81ONfZvmTYXLyq9Ue306lC0UL2PhErhMfsATZTTsUEck08vSC/CljJGuie+gXh
 84anpiS/4edlbh8Ph+7WrS35y2ZBfOyDda6DYt8K+wpvkDQ5NRhD1bcycofX9jqTZTtX
 U4/799WuTjAw0PIv61oLivXBEHBHXYO0LJMqnOh4gJrn83WvIKQnMRdFcuGP/VsDw7G9
 j0Eg==
X-Gm-Message-State: AOAM532pu05WvqVQZpu3x1tIYFLoLn5jaZPsD3kq3I4BlzsKGkvYYbfs
 /Rc8CnqeQpgzTEKUHfEAy+Lnx94R9/7+Z+bdV6Y=
X-Google-Smtp-Source: ABdhPJzYF4hwT3T/mkrdk5cXrMRLhDinMJMWwR8kLjRKgxS+dV2BrU48zWwMSl6ELMOu1+KCJU3Bb2xmfkzjqbRbv+A=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr22358365otg.260.1623243730796; 
 Wed, 09 Jun 2021 06:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154255.8693-1-mario.limonciello@amd.com>
 <20210608154255.8693-2-mario.limonciello@amd.com>
In-Reply-To: <20210608154255.8693-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jun 2021 15:01:59 +0200
Message-ID: <CAJZ5v0hOgQCyEaRWEM=wELSYKJyuvCi8r4EnaAFQv+5EQRcOJg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rrangel@chromium.org, 
 David Box <david.e.box@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Nehal-bakulchandra.Shah@amd.com, Alex Deucher <Alexander.Deucher@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Julian Sikorski <belegdol@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_060211_742591_DEE6F628 
X-CRM114-Status: GOOD (  34.13  )
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/device_pm.c |  3 +++
>  drivers/acpi/internal.h  |  9 +++++++++
>  drivers/acpi/x86/utils.c | 25 +++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> Changes from v4->v5:
>  * Add this patch back in as it's been made apparent that the
>    system needs to be hardcoded for these.
>    Changes:
>    - Drop Cezanne - it's now covered by StorageD3Enable
>    - Rebase ontop of acpi_storage_d3 outside of NVME
> Changes from v5->v6:
>  * Move the quirk check into drivers/acpi/x86/ as suggested by
>    Rafael.
> Changes from v6->v7:
>  * Move header location
>  * Optimization of force function
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c45f2d76b67e..31e0025a913e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1356,6 +1356,9 @@ bool acpi_storage_d3(struct device *dev)
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>         u8 val;
>
> +       if (force_storage_d3())
> +               return true;
> +
>         if (!adev)
>                 return false;
>         if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f973bbe90e5e..e29ec463bb07 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,6 +236,15 @@ static inline int suspend_nvs_save(void) { return 0; }
>  static inline void suspend_nvs_restore(void) {}
>  #endif
>
> +#ifdef CONFIG_X86
> +bool force_storage_d3(void);
> +#else
> +static inline bool force_storage_d3(void)
> +{
> +       return false;
> +}
> +#endif
> +
>  /*--------------------------------------------------------------------------
>                                 Device properties
>    -------------------------------------------------------------------------- */
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..5298bb4d81fe 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,28 @@ bool acpi_device_always_present(struct acpi_device *adev)
>
>         return ret;
>  }
> +
> +/*
> + * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * is put into D3 over a Modern Standby / suspend-to-idle cycle.
> + *
> + * This is "typically" accomplished using the `StorageD3Enable`
> + * property in the _DSD that is checked via the `acpi_storage_d3` function
> + * but this property was introduced after many of these systems launched
> + * and most OEM systems don't have it in their BIOS.
> + *
> + * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> + * a hardcoded allowlist for D3 support, which was used for these platforms.
> + *
> + * This allows quirking on Linux in a similar fashion.
> + */
> +const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +
> +bool force_storage_d3(void)
> +{
> +       return x86_match_cpu(storage_d3_cpu_ids);
> +}
> --
> 2.25.1
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
