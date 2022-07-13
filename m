Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2CDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtlOadBoX7giHbrFldWFx6mFu9CKFbuysndEmy++rVQ=; b=1MxnfHYnm0prLev7v3pKFyB2aa
	ho4C6QsKLaWNmMfDuqgjHopEazGOBRAtsYLjmNORaN7HPM7nSPkQn4T7j/SnpPqM0nJUdDk4wjquu
	nTbYib8tEMZ6lLZdpawq7hgVganvabPVxK52gfYupcUG2HmsuZT3A34zu5BeeKx3uMMu+jdMEiy/S
	NMqWMeyBFu5xs+lF7SSxfyFwMEzqUIgVCjmnItpPSjA2z5XX3MmUQct9BBVKzP3xFCM8XZJnf+h40
	jwo1f4+lFE6juqRYpM+cxNjHMug6y/DOh6yqTWUJZJxQXsnItZZDbyObyLgrk/b1OM7z8h0aZpUKB
	CVjvJeyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYcq-002FUz-R9; Wed, 13 Jul 2022 09:25:44 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYco-002FSQ-O6
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:25:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id v16so14589249wrd.13
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CtlOadBoX7giHbrFldWFx6mFu9CKFbuysndEmy++rVQ=;
        b=Rx02LltWU+iIwGAbgTWZgNZz82vF4uipT1emAIriRN3vMcm/pKmjRFt9dMrXyX/mER
         8cKR9a/CaJclz6PFTRxykiJUGGCWen69kcgVb/dauhKeES4ht+6v+4utloiLTaqM4h/g
         Qx9mV+budnzKi9t6yRLawFqJ7oil/nRVSVOjTxlfUHZUrAUVe6u5OFe3Hg3hvTGRCguY
         jX0+8xeKOwRzdictJcNYOeXGa4cgAGK/khMeaC+qY1Uzrt9HjS1S6OhDoqz4Gs547/er
         x7C0WuKJkZ/UwUHZT1rrUr8AxzQI1AvPcGFVVex94mTaz3VjkTvQCaVpCpmjDcQ/gCbg
         zOGA==
X-Gm-Message-State: AJIora/FnmQrxUIJdqj4X2Nnl4k9imBtGi5RUJROGVf6ieWiVQ+zRqLy
	tbIpP3VU8GxzSLIYqffJChaRT/oF8Nw=
X-Google-Smtp-Source: AGRyM1tbEKsZ2tBOQLcvtDeVvsTQpHU3gIkZhnmQtkwODpty0LOhfHFTcS06KihsVBx0hUjsnADVFA==
X-Received: by 2002:a5d:5986:0:b0:21d:8779:8220 with SMTP id n6-20020a5d5986000000b0021d87798220mr2235758wri.165.1657704340677;
        Wed, 13 Jul 2022 02:25:40 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003a2e1883a27sm1939906wmb.18.2022.07.13.02.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:25:40 -0700 (PDT)
Message-ID: <7ca70ac5-db80-eb0d-5678-18bc1902a072@grimberg.me>
Date: Wed, 13 Jul 2022 12:25:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Joel Granados <j.granados@samsung.com>,
 kbusch@kernel.org
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713054914.1888305-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_022542_816751_5D98BC10 
X-CRM114-Status: GOOD (  25.34  )
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



On 7/13/22 08:49, Christoph Hellwig wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> Extend nvme_alloc_ns() and nvme_validate_ns() for unknown command-set as
> well. Both are made to use a new helper (nvme_update_ns_info_cs_indep)
> which is similar to nvme_update_ns_info but performs fewer operations
> to get the generic interface up.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> [hch: rebased on other refactoring patches]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dca7580f785a8..f865d0b185c32 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1954,6 +1954,31 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	blk_queue_chunk_sectors(ns->queue, iob);
>   }
>   
> +static int nvme_update_ns_info_generic(struct nvme_ns *ns,
> +		struct nvme_ns_info *info)
> +{
> +	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_set_queue_limits(ns->ctrl, ns->queue);
> +	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +
> +	if (nvme_ns_head_multipath(ns->head)) {
> +		blk_mq_freeze_queue(ns->head->disk->queue);
> +		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> +		nvme_mpath_revalidate_paths(ns);
> +		blk_stack_limits(&ns->head->disk->queue->limits,
> +				 &ns->queue->limits, 0);
> +		ns->head->disk->flags |= GENHD_FL_HIDDEN;
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
> +	}
> +
> +	/* Hide the block-interface for these devices */
> +	ns->disk->flags |= GENHD_FL_HIDDEN;
> +	set_bit(NVME_NS_READY, &ns->flags);
> +
> +	return 0;
> +}
> +
>   static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   		struct nvme_ns_info *info)
>   {
> @@ -2024,17 +2049,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	case NVME_CSI_ZNS:
>   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>   			dev_warn(ns->ctrl->device,
> -	"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
> +	"block device for nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
>   				info->nsid);
> -			return -ENODEV;
> +			return nvme_update_ns_info_generic(ns, info);
>   		}
>   		return nvme_update_ns_info_block(ns, info);
>   	case NVME_CSI_NVM:
>   		return nvme_update_ns_info_block(ns, info);
>   	default:
> -		dev_warn(ns->ctrl->device, "unknown csi %u for nsid %u\n",
> -			info->ids.csi, info->nsid);
> -		return -ENODEV;

Maybe we want to keep the log? can be converted to dev_info/dev_dbg, but
seems useful to have.

> +		return nvme_update_ns_info_generic(ns, info);
>   	}
>   }
>   
> @@ -4341,7 +4364,8 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	 * data structure to find all the generic information that is needed to
>   	 * set up a namespace.  If not fall back to the legacy version.
>   	 */
> -	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
> +	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS)) {
>   		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
>   			return;
>   	} else {

