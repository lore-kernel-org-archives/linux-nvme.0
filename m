Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB93C433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 11:12:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB68206F0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rh0UhDN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB68206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zBhK4l4yxyOnk5kfMoZBzaLBVCx56Px3bINtWg/zqlI=; b=Rh0UhDN6glPdnCoRyDC+kL7RA
	0c9rLw7lwD4fE49aabVx3wF/SZdfojBz/3gYsteeKjCzXtkadrVs1zt5Lq3be+PohYII8wHS0ioof
	tUAsxpz+4TWmaMtXwxQAxOjtInlBnQrlk6HcZ1qEQc3ZslcOTm6JZlSpe7uiznOJzMA9tBuVZ8UbI
	xxGHTkuCgpCcUaEIgadj2Ein9tb2yAJWzU6xvHB60/+JIJYozJGTakTscHGm5EgZ+2QhP2jij8S4X
	3/7FU/YHnLJCYwPVsEvHCVp3OwBrVm6weEgQQTOYX2Bn9bH9I0P7ad7WA4lSlCXM5Y2HBNuXilubR
	nCzd8Pp+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juwO8-0007VU-Fi; Mon, 13 Jul 2020 11:12:48 +0000
Received: from mail-oo1-f67.google.com ([209.85.161.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juwO5-0007U5-FD
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 11:12:46 +0000
Received: by mail-oo1-f67.google.com with SMTP id c4so2266536oou.6
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2020 04:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z4UpwgfORrj3oigw0RrvSnmt+2ICp2THbIeB0EXtjQs=;
 b=ZC7t7IJJo8sNRs4/u5G9TOURWt+JG1oOnKVbtqKZQjajYkGSWLzxD7tJiQCNbRilpb
 SUqs3XctTr6ukm6s85TqRk0UWpghC4v2PY74gL6iPfudH4AHz9rTBZcbV5tJzFSj0zFM
 3Rs4z5fNqaG29rbryyMXEBfW+X+NNAoZsDDOA3KjeC+0dpKYBdI9OnxyZSShMbi1JLwd
 Myi68JFJkwOlUcsFf2Q8GUA97lk3zKKIGwwaPOdTZkww7F1nnKZU06wXUzpl+2Ih53Mg
 7pZtgZp+RL7ALzzCnVrZFvmdE4vFJjn8slPtsi7mC4Wv52S3SVmF5+YEtodwAzbZKHxX
 Rgaw==
X-Gm-Message-State: AOAM533CXj3PEsCTRFNX7UKThu2Cs6tbum7Y/cKktq8cGw9x+OAFttt0
 MsIh+VKGET36i01ZQegjbRDNWVxu9zla4Ji6DP4=
X-Google-Smtp-Source: ABdhPJyYp3FcOLd+Hr8loSactjFLqisWoV+Mzkbr+S0itAT4vKkHKQiebuqigXUPu/zupCCVoHSY7aYZh1+0xYdK224=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr70607424oov.75.1594638762903; 
 Mon, 13 Jul 2020 04:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702225011.10932-1-david.e.box@linux.intel.com>
 <20200709184333.6241-1-david.e.box@linux.intel.com>
In-Reply-To: <20200709184333.6241-1-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jul 2020 13:12:26 +0200
Message-ID: <CAJZ5v0iJeyf+eMsDd37GdBdQq4e_JkJwcCm9VdQNgaxcf_RrEg@mail.gmail.com>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
To: "David E. Box" <david.e.box@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_071245_528163_304E40DC 
X-CRM114-Status: GOOD (  39.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: shyjumon.n@intel.com, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 9, 2020 at 8:43 PM David E. Box <david.e.box@linux.intel.com> wrote:
>
> This patch implements a solution for a BIOS hack used on some currently
> shipping Intel systems to change driver power management policy for PCIe
> NVMe drives. Some newer Intel platforms, like some Comet Lake systems,
> require that PCIe devices use D3 when doing suspend-to-idle in order to
> allow the platform to realize maximum power savings. This is particularly
> needed to support ATX power supply shutdown on desktop systems. In order to
> ensure this happens for root ports with storage devices, Microsoft
> apparently created this ACPI _DSD property as a way to influence their
> driver policy. To my knowledge this property has not been discussed with
> the NVME specification body.
>
> Though the solution is not ideal, it addresses a problem that also affects
> Linux since the NVMe driver's default policy of using NVMe APST during
> suspend-to-idle prevents the PCI root port from going to D3 and leads to
> higher power consumption for these platforms. The power consumption
> difference may be negligible on laptop systems, but many watts on desktop
> systems when the ATX power supply is blocked from powering down.
>
> The patch creates a new nvme_acpi_storage_d3 function to check for the
> StorageD3Enable property during probe and enables D3 as a quirk if set.  It
> also provides a 'noacpi' module parameter to allow skipping the quirk if
> needed.
>
> Tested on:
> PM961 NVMe SED Samsung 512GB
> INTEL SSDPEKKF512G8
>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> Changes from V4:
>         - Add support for North complex PCI root ports.
>         - Use acpi_bus_get_device instead of acpi_bus_get_acpi_device.
>           Also fixes compiler error on V4 reported by lkp@intel.com.
>         - Place CONFIG_ACPI around function since acpi_bus_get_device
>           is not stubbed out.
>
> Changes from V3:
>         - Use pcie_find_root_port() instead of pci_find_pcie_root_port(),
>           changed in 5.8.
>         - Remove "Cc:" emails that ended up at top of V3 commit message.
>         - Fix changelog numbering.
>
> Changes from V2:
>         - Remove check for "not yet bound" ACPI companion device since
>           this will not be a concern at driver probe time per Rafael.
>         - Move storage_d3 function out of PCI core and into NVMe driver
>           since there's nothing the PCI core can do with this code as
>           noted by Bjorn.
>
> Changes from V1:
>         - Export the pci_acpi_storage_d3 function for use by drivers as
>           needed instead of modifying the pci header.
>         - Add missing put on acpi device handle.
>         - Add 'noacpi' module parameter to allow undoing this change.
>         - Add info message that this is a platform quirk.
>
>
>  drivers/acpi/property.c |  3 ++
>  drivers/nvme/host/pci.c | 64 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e601c4511a8b..c2e2ae774a19 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
>         /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
>         GUID_INIT(0x6c501103, 0xc189, 0x4296,
>                   0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> +       /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
> +       GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> +                 0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
>  };
>
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b1d18f0633c7..7c0be363eb22 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2011-2014, Intel Corporation.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/aer.h>
>  #include <linux/async.h>
>  #include <linux/blkdev.h>
> @@ -94,6 +95,10 @@ static unsigned int poll_queues;
>  module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
>  MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
>
> +static bool noacpi;
> +module_param(noacpi, bool, 0444);
> +MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
> +
>  struct nvme_dev;
>  struct nvme_queue;
>
> @@ -2759,6 +2764,55 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_ACPI
> +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> +{
> +       const struct fwnode_handle *fwnode;
> +       struct acpi_device *adev;
> +       struct pci_dev *root;
> +       acpi_handle handle;
> +       acpi_status status;
> +       u8 val;
> +
> +       /*
> +        * Look for _DSD property specifying that the storage device on
> +        * the port must use D3 to support deep platform power savings during
> +        * suspend-to-idle
> +        */
> +       root = pcie_find_root_port(dev);
> +       if (!root)
> +               return false;
> +
> +       adev = ACPI_COMPANION(&root->dev);
> +       if (!adev)
> +               return false;
> +
> +       /*
> +        * The property is defined in the PXSX device for South complex ports
> +        * and in the PEGP device for North complex ports.
> +        */
> +       status = acpi_get_handle(adev->handle, "PXSX", &handle);
> +       if (ACPI_FAILURE(status)) {
> +               status = acpi_get_handle(adev->handle, "PEGP", &handle);
> +               if (ACPI_FAILURE(status))
> +                       return false;
> +       }
> +
> +       if (acpi_bus_get_device(handle, &adev))
> +               return false;
> +
> +       fwnode = acpi_fwnode_handle(adev);
> +
> +       return fwnode_property_read_u8(fwnode, "StorageD3Enable", &val) ?
> +               false : val == 1;

I would write this as

if (fwnode_property_read_u8(acpi_fwnode_handle(adev),
                            "StorageD3Enable", &val))
        return false;

return val == 1;

to eliminate the redundant fwnode variable and untangle the last
checks somewhat.

With that changed please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch.

Thanks!

> +}
> +#else
> +static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> +{
> +       return false;
> +}
> +#endif
> +
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>         struct nvme_dev *dev = data;
> @@ -2808,6 +2862,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         quirks |= check_vendor_combination_bug(pdev);
>
> +       if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +               /*
> +                * Some systems use a bios work around to ask for D3 on
> +                * platforms that support kernel managed suspend.
> +                */
> +               dev_info(&pdev->dev,
> +                        "platform quirk: setting simple suspend\n");
> +               quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
> +       }
> +
>         /*
>          * Double check that our mempool alloc size will cover the biggest
>          * command we support.
> --
> 2.20.1
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
