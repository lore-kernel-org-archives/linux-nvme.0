Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34105C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/tX6CjSj8q7cMLClYhpuM83VN3AYnux1I392MajGFpI=; b=RrmbUpplrZ2nMSvbNgXx0MyWER
	OVyba6zPxkQOQcoWa5RXgsSqnsSWznoJICcdWR6WMEr0qDon98d86cfw1vVrv5j32XwzzOnlZ/aDa
	S/LsNIR9316Z61QZ9X1r56PIwEHRrwX8vehGusjx4NGxsuK0Tf7x5yQmD46BBAPjRxZ6r9rTBDeIc
	a0fLEmULI24VhIKSVEp/YskFsn4TZHXo4nUnxvPFsdT5S6lcaUe2iJIWFtyOMHgV8zQyxauR3FMXc
	LKwIDBDOCvzCFOG8UK2zZnYdrBfUA0ElK1P+ptsRVAf2bwkamuIyp1fUNtu6Q4eA3ciUPoYZOdNoR
	MFGC99Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqfB-00000005TF2-1P8p;
	Mon, 17 Aug 2026 06:17:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqfA-00000005TEw-2NSD
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 06:17:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 93C70600AE;
	Mon, 17 Aug 2026 06:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214691F000E9;
	Mon, 17 Aug 2026 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786947455;
	bh=/tX6CjSj8q7cMLClYhpuM83VN3AYnux1I392MajGFpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hgjPYImyB+fMfiJ0PiGwG33VK9VcGFAHrEqHNnDEDnCEVRloSONm7mAtAN/Rn+6+o
	 zTQ0UPMMIBNi1BBj2lR99jpeh4hbNW4x4tA2dCubiA1ifT4k8VocHLb8BM8rCvhhpr
	 CywYPIx2SgEmaS7gXZX0p3u5XeqIAOu4aeFmXxDBiY+NO+JA4tp1C9DhKzbITelvD5
	 3FDKOv+DAyR+yU+rHKZQ7q1Y0xRomXPksvZDCzAVk83KDJdhPhQI7DyhO03qXkIcU/
	 iQ8K6j70RDX7nCcNSKfyIMLyPoUBtuoEgIBlexX0hrp7KXx3n0+RrMR0wdnFqza+VB
	 McqlsAfmUuGtg==
Message-ID: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
Date: Mon, 17 Aug 2026 15:17:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Chao Shi <coshi036@gmail.com>, kbusch@kernel.org
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
References: <20260816191729.2865523-1-coshi036@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260816191729.2865523-1-coshi036@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/17/26 04:17, Chao Shi wrote:
> nvme_query_zone_info() returns either a negative errno or a positive
> NVMe status code, but nvme_update_ns_info_block() only tests for the

That seems like a bad design of nvme_query_zone_info(). Why not fix it so that
on error it returns either negative values OR NVMe status code? That would
avoid the pitfall of the error check that you found.

> negative case:
> 
> 	ret = nvme_query_zone_info(ns, lbaf, &zi);
> 	if (ret < 0)
> 		goto out;
> 
> If the device fails the Identify Namespace (I/O Command Set specific)
> command, or the Identify Controller command issued by
> nvme_set_max_append(), the positive status falls through and setup
> continues with the zero-initialized zone info.  nvme_update_zone_info()
> then marks the queue zoned with chunk_sectors and ns->head->zsze set to
> zero.
> 
> blk_validate_zoned_limits() does not check chunk_sectors, so the limits
> commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
> size, but by then the limits are live and nothing rolls them back, so
> I/O keeps being submitted to a zoned queue with a zero zone size and
> disk_zone_no() shifts by ilog2(0):
> 
>   nvme0n1: Invalid non power of two zone size (0)
>   UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
>   shift exponent -1 is negative
>    disk_zone_no include/linux/blkdev.h:747 [inline]
>    bio_straddles_zones include/linux/blkdev.h:1058 [inline]
>    blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
>    blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
>    blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
>    submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
>    __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933
> 
> Any device, firmware or NVMe-oF target that fails this one command
> reaches this.
> 
> Skip the zoned limits update in that case.  The namespace stays
> registered and usable for admin commands, but the queue is not
> configured from zone info that was never read.
> 
> zi.zone_size is an exact indicator: every path that returns a positive
> status returns before it is assigned, and after that the only failure
> left is -ENODEV, which the caller already handles.
> 
> Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
> Cc: stable@vger.kernel.org
> Cc: Weidong Zhu <weizhu@fiu.edu>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Found by FuzzNvme.
> 
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
> Changes since v1:
> - Only skip the zoned limits instead of failing the update, as
>   suggested by Keith.
> - Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal
>   (reasoning in my reply on v1).
> - Drop the "malicious device" wording.
> 
> v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/
> 
>  drivers/nvme/host/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..87e0534cde1c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2447,8 +2447,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (!nvme_update_disk_info(ns, id, nvm, &lim))
>  		capacity = 0;
>  
> +	/*
> +	 * A failed zone info query leaves zi zero-initialized.  Leave the
> +	 * namespace registered so that it can still be used as a device
> +	 * handle, but do not configure the zoned limits from it.
> +	 */
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS)
> +	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
>  		nvme_update_zone_info(ns, &lim, &zi);
>  
>  	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)


-- 
Damien Le Moal
Western Digital Research

