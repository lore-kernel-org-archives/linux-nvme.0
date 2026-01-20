Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC3D2ED0F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jan 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dfAahEg6p96zRa+cbyIcBvzZKehct4a3arDqmoow9HI=; b=Iy/AHB1DLT8YAlxpYlhv6aeNpq
	IdF+Z96S8qx236UFAwywGiG0UNL2GAuxzvLhyhBedvGein3CQ+tAuTAQspXrCrkQjagaZ40QW3g0T
	QmE9uCbs2rhd55MYee+rbRS6J4AKAUkuQVVSF4Qv0iyTV0/SoOSoB7s+j8CFmKUm2q6K+DchEPBD1
	l6F7UC9i8MWyuT07MFvuqGwLD0jDqEmNDy6RgxeDgnjWzmiwMqKqkiZ7eKdK6ioRs9nDWRjX5FBDR
	XwSGZTLNhXGSWbRXW2Xt3MVbtNCFGWAOMTjnRsncCyOHIQR+VToohcUHcwvT3Fjx5DVY6+9kwnD3/
	aZTJA9/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi8Sm-00000003ZAj-0JYU;
	Tue, 20 Jan 2026 09:55:52 +0000
Received: from mail-m3285.qiye.163.com ([220.197.32.85])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi8Sj-00000003Z8G-0ELl
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jan 2026 09:55:51 +0000
Received: from [172.23.77.185] (unknown [43.247.70.81])
	by smtp.qiye.163.com (Hmail) with ESMTP id 314bb6fce;
	Tue, 20 Jan 2026 17:55:38 +0800 (GMT+08:00)
Message-ID: <56389e0f-b0b6-49b1-8de3-d8d18e507189@sangfor.com.cn>
Date: Tue, 20 Jan 2026 17:54:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@kernel.dk,
 kbusch@kernel.org
References: <20230713133042.3981-1-hch@lst.de>
Content-Language: en-US
From: "xiaoke@sangfor.com.cn" <xiaoke@sangfor.com.cn>
In-Reply-To: <20230713133042.3981-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bdad4ce0909d5kunm8c338aa159d4af
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUsaVhhLSktMHRkZGB5KS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_015549_280397_E20A6DB8 
X-CRM114-Status: GOOD (  32.62  )
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

On 2023/7/13 21:30, Christoph Hellwig wrote:
> While duplicate IDs are still very harmful, including the potential to easily
> see changing devices in /dev/disk/by-id, it turn out they are extremely
> common for cheap end user NVMe devices.
> 
> Relax our check for them for so that it doesn't reject the probe on
> single-ported PCIe devices, but prints a big warning instead.  In doubt
> we'd still like to see quirk entries to disable the potential for
> changing supposed stable device identifier links, but this will at least
> allow users how have two (or more) of these devices to use them without
> having to manually add a new PCI ID entry with the quirk through sysfs or
> by patching the kernel.
> 
> Co-developed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 47d7ba2827ff29..37b6fa74666204 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3431,10 +3431,40 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   
>   	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
>   	if (ret) {
> -		dev_err(ctrl->device,
> -			"globally duplicate IDs for nsid %d\n", info->nsid);
> +		/*
> +		 * We've found two different namespaces on two different
> +		 * subsystems that report the same ID.  This is pretty nasty
> +		 * for anything that actually requires unique device
> +		 * identification.  In the kernel we need this for multipathing,
> +		 * and in user space the /dev/disk/by-id/ links rely on it.
> +		 *
> +		 * If the device also claims to be multi-path capable back off
> +		 * here now and refuse the probe the second device as this is a
> +		 * recipe for data corruption.  If not this is probably a
> +		 * cheap consumer device if on the PCIe bus, so let the user
> +		 * proceed and use the shiny toy, but warn that with changing
> +		 * probing order (which due to our async probing could just be
> +		 * device taking longer to startup) the other device could show
> +		 * up at any time.
> +		 */
>   		nvme_print_device_info(ctrl);
> -		return ret;
> +		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
> +		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
> +		     info->is_shared)) {
> +			dev_err(ctrl->device,
> +				"ignoring nsid %d because of duplicate IDs\n",
> +				info->nsid);
> +			return ret;
> +		}
> +
> +		dev_err(ctrl->device,
> +			"clearing duplicate IDs for nsid %d\n", info->nsid);
> +		dev_err(ctrl->device,
> +			"use of /dev/disk/by-id/ may cause data corruption\n");
> +		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
> +		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
> +		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
> +		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
>   	}
>   
>   	mutex_lock(&ctrl->subsys->lock);

Hi,

I’d like to discuss whether we should revisit the duplicate-ID check
for NVMe-oF transports, especially in HA dual-active setups.

In such HA configurations, a single LUN is exposed via multiple subsystems
(one per storage controller) to provide redundancy. Because it represents
the same namespace, it usually reports the same UUID/NGUID/EUI64 on all 
paths.

With the logic introduced in this patch, Fabrics are still strictly
rejected:

 > +		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
 > +		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
 > +		     info->is_shared)) {

Concretely, with two subsystems exposing the same LUN in a dual-active
HA configuration:

- Only paths from one subsystem are used;
- When that controller fails, the host cannot fail over to the other
   subsystem because its namespace was ignored, effectively breaking HA.

Would it make sense to:

1) relax the duplicate ID check for NVMe-oF HA dual-active use cases, or

2) add a module parameter (e.g., `nvme_core.allow_duplicate_ids`) so admins
    can opt-in when they know their storage topology and accept the
    /dev/disk/by-id risks?

Keeping the default strict is fine, but having an escape hatch would be
very helpful for HA deployments.

Thanks,
Xiaoke


