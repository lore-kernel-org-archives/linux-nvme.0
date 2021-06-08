Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F17BC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:31:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AAC6128A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AAC6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VC6zIKyp22I9SCLmViFKHFYlv58svd6EKe1pxe12Gos=; b=klK/XZDOhRti8j
	7a891jkN+RahKFvRwpoUvd0Ysx80BpwuqucqXcku2oLrKjr+aAaDfv2LK5o8SKzQxwCR7OUuK34DS
	2a9XI23+IT5RZ5Hfbs007DrT5X3oGkzm4suSC/E/btLQkkmKIPGaHuzqwLJefDF1bDxUBVjNaYNQu
	4xr5zWEKVyZQ1/ULczSIPuH3y0vnGS59Flv766kKDzGx/IDABLplDsU69FPPscukV29Gh6G5RXnuU
	2pBt96yWYY66nNjx1QIojHM8/NgzQqKyvpzQj2CjTjRZkGMe2+4kTuIxKM4uqFS0HvhY2fj/App2B
	sYMQIWqt/reGFABe3UGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqZwk-0082tA-2J; Tue, 08 Jun 2021 11:31:02 +0000
Received: from mail-ot1-f53.google.com ([209.85.210.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqZtz-0081yF-Cq
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 11:28:14 +0000
Received: by mail-ot1-f53.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so15549574oth.9
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 04:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZDQ2BSSl67ck1vvYJoFh/3g0MHC3Vf+JuWnQHiL10v0=;
 b=qWdhoiUHSR4NdtwCtHnGcc2vw9sk08CSUXSIn7/7IGLtRMp24LzcS62iFPc5EBg9Jc
 gv5vSRHDSYcReL8UwzY/gMmavGF1WSS4RTjgjgUtDkv0UTeLCGKgrPMehOIdnmou/lBU
 Eh3easLf0Uq2jNn7coS4MpnmKQImp4KB4yR1EXL+uOyenDYTqfVUc8U2BTE6xfum44J+
 OAKIXbRiDXr4UijqVwykzPwWhvFte2iy/hOKCYbHlNxEE+RRbkLjOkEq8wb7TP8a38Xi
 HOReLtQKY/2XQCXUuPBX7nMQ9wDk9yytlZ3tixDqpoh6Eb/q9Ct46CA1aro3ESGh0Pfc
 QPxA==
X-Gm-Message-State: AOAM531x5mXAlz6oDPgJEUvUoiqvPBxZiMK9X//jJWvMchmYm1UUTdpo
 syz7iWALQrdwWoOf9V4QQmtSF2g5jMzI7eqlkFEQkGa88I8=
X-Google-Smtp-Source: ABdhPJyJL1GNbZ9W6xaADH/uQ7Km9hFPsTEVOT9RuVOEnq6m8rIEqK2Sfeme2svgp3BjgLELVBJa2VxBtHgknPPzIpI=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr14527986otq.321.1623151689185; 
 Tue, 08 Jun 2021 04:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210607173156.5548-2-mario.limonciello@amd.com>
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jun 2021 13:27:58 +0200
Message-ID: <CAJZ5v0jFop-M6dT18+eDDgUepFY=CxjHWjfYf6nxrk5B64=vwQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
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
X-CRM114-CacheID: sfid-20210608_042811_504461_55A33E63 
X-CRM114-Status: GOOD (  35.97  )
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

On Mon, Jun 7, 2021 at 7:32 PM Mario Limonciello
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
>  drivers/acpi/device_pm.c |  3 +++
>  drivers/acpi/x86/utils.c | 27 +++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h  |  5 +++++
>  3 files changed, 35 insertions(+)
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
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 1edb68d00b8e..985c17384192 100644
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
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..2b8d5b3c876f 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,30 @@ bool acpi_device_always_present(struct acpi_device *adev)
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
> +       if (x86_match_cpu(storage_d3_cpu_ids))
> +               return true;
> +       return false;

Well, what about doing

  return x86_match_cpu(storage_d3_cpu_ids);

instead?

> +}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..9b0ddbae5617 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -607,11 +607,16 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
>
>  #ifdef CONFIG_X86
>  bool acpi_device_always_present(struct acpi_device *adev);
> +bool force_storage_d3(void);

This doesn't need to go into acpi_bus.h, because it will only be used
in device_pm.c.

You may as well put it into drivers/acpi/internal.h.

>  #else
>  static inline bool acpi_device_always_present(struct acpi_device *adev)
>  {
>         return false;
>  }
> +static inline bool force_storage_d3(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #ifdef CONFIG_PM
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
