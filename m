Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9745C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsBFZO9gUMjujKyIpbcl/nfZjpRqdfVRNblGeulVP8Q=; b=OpfwaGTymhhtELpHRYJ2zQDPuV
	k1j+DOACUbdt/htDtRXOWwNEA9XDCVINOLH7iJuTHVKG5BmjcXULgua0Ssu3LWLE4bwve1OIA7ZjD
	k83MKYmr9GZ63eTsq1raD2gG/4o+IQz3i8hjEdo/orh8W3EqsGYvR2FbXIt5Zq/3GHpel+RWTXTmV
	kCHwHzOiVtO5G57VuRlCJOtDR9DdW5+2huHudBYshXtDQIXh7IfOCq65z0hVxBs0EDasgJD2Qz7as
	7vsipeGfUsp/QUfqXvrylrDQeJkw952YTdGO+Vnlwe6ueffg06eoXzPmnRilfJ1gaOCf5sshmzjF2
	qKUJLZ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Shn-00C2bg-Iq; Sun, 26 Jun 2022 13:53:39 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Shk-00C2a3-VQ
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 13:53:38 +0000
Received: by mail-wr1-f50.google.com with SMTP id s1so9463554wra.9
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 06:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qsBFZO9gUMjujKyIpbcl/nfZjpRqdfVRNblGeulVP8Q=;
        b=Brm0DmUJMIGVWcATnpinXAONN3IOoAJIhzTehHhYRrc0tH4YSVTgAF7LpfyBHZcHdp
         I1WpToQRuV2F1BZZbS7g6JkM4CzrsetzaengZrTp+U8FnCuPlXK4jK7uQqPpxARbaGgl
         SfCmo5Y2FUmCPGBud9weXwqVDjj6muHynUIvTcLuWNMkLtICEDz1e3jocTs9BKhtXZ62
         u7I0yxGHsrSLd/R+b4S1iUIcSk0u5knBz9l1ceF+5EL9FAhdYGS8MjjSOIUKTnAZ5gCU
         wIo+6QKNlJO7A50zgGmzCpJQjmo8rZWtJEJI/tH7+3DF8Qp0JNHMhi1TVJqOfOaUG5HZ
         QeEQ==
X-Gm-Message-State: AJIora+n+HCEQucAfEqkudVUT6g8Sulfyr6sImG1nXzAalboLqR7Mvtx
	2D3goGj9U3t+IPaudqHr8T4=
X-Google-Smtp-Source: AGRyM1s6GGYf453bl1qIQD0BFbOxhNayGEQY16RhQ0TsGWzRIuDwFBaAVS5O0o+3qm/8JbqId4QAuQ==
X-Received: by 2002:adf:eb84:0:b0:21b:84dd:4d86 with SMTP id t4-20020adfeb84000000b0021b84dd4d86mr7839526wrn.288.1656251615080;
        Sun, 26 Jun 2022 06:53:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003a04912351fsm1485296wmb.17.2022.06.26.06.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:53:34 -0700 (PDT)
Message-ID: <87909773-4430-e44f-bd8e-81d4c32b8704@grimberg.me>
Date: Sun, 26 Jun 2022 16:53:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, joshi.k@samsung.com,
 gost.dev@samsung.com, k.jensen@samsung.com
References: <20220622135556.2185991-1-j.granados@samsung.com>
 <CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
 <20220622135556.2185991-3-j.granados@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220622135556.2185991-3-j.granados@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_065337_068220_E7383DC7 
X-CRM114-Status: GOOD (  28.28  )
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



On 6/22/22 16:55, Joel Granados wrote:
> Extend nvme_alloc_ns() and nvme_validate_ns() for unknown command-set as
> well. Both are made to use a new helper (nvme_update_ns_info_cs_indep)
> which is similar to nvme_update_ns_info but performs fewer operations
> to get the generic interface up.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>   drivers/nvme/host/core.c | 132 +++++++++++++++++++++++++++------------
>   1 file changed, 93 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0fd6127da8d1..03ba3d0f4d3a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1908,6 +1908,34 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	blk_queue_chunk_sectors(ns->queue, iob);
>   }
>   
> +static int nvme_update_ns_info_cs_indep(struct nvme_ns *ns,
> +					struct nvme_id_ns_cs_indep *id)
> +{
> +	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_set_queue_limits(ns->ctrl, ns->queue);
> +	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> +		test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +
> +	if (nvme_ns_head_multipath(ns->head)) {
> +		blk_mq_freeze_queue(ns->head->disk->queue);
> +		set_disk_ro(ns->head->disk,
> +			    (id->nsattr & NVME_NS_ATTR_RO) ||
> +				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
> +		nvme_mpath_revalidate_paths(ns);
> +		blk_stack_limits(&ns->head->disk->queue->limits,
> +				 &ns->queue->limits, 0);
> +		ns->head->disk->flags |= GENHD_FL_HIDDEN;
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
> +	}

We can probably share this code with the existing update_ns_info ?

> +
> +	/* Hide the block-interface for these devices */
> +	ns->disk->flags |= GENHD_FL_HIDDEN;
> +	set_bit(NVME_NS_READY, &ns->flags);
> +
> +	return 0;
> +}
> +
>   static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   {
>   	unsigned lbaf = nvme_lbaf_index(id->flbas);
> @@ -3951,15 +3979,29 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
>   }
>   
>   static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> -		struct nvme_ns_ids *ids)
> +		struct nvme_ns_ids *ids, struct nvme_id_ns_cs_indep *indep_id)
>   {
> +	int ret = 0;
>   	struct nvme_ns *ns;
>   	struct gendisk *disk;
> -	struct nvme_id_ns *id;
> +	struct nvme_id_ns *id = NULL;
>   	int node = ctrl->numa_node;
> +	__u8 *nmic;
> +	__le32 *anagrpid;
>   
> -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> -		return;
> +	switch (ids->csi) {
> +	case NVME_CSI_NVM:
> +	case NVME_CSI_ZNS:
> +		if (nvme_identify_ns(ctrl, nsid, ids, &id))
> +			return;
> +		nmic = &id->nmic;
> +		anagrpid = &id->anagrpid;
> +		break;
> +	default:
> +		nmic = &indep_id->nmic;
> +		anagrpid = &indep_id->anagrpid;
> +		break;
> +	}
>   
>   	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>   	if (!ns)
> @@ -3984,7 +4026,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   	ns->ctrl = ctrl;
>   	kref_init(&ns->kref);
>   
> -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> +	if (nvme_init_ns_head(ns, nsid, ids, *nmic & NVME_NS_NMIC_SHARED))
>   		goto out_cleanup_disk;
>   
>   	/*
> @@ -4010,7 +4052,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   			ns->head->instance);
>   	}
>   
> -	if (nvme_update_ns_info(ns, id))
> +	switch (ids->csi) {
> +	case NVME_CSI_NVM:
> +	case NVME_CSI_ZNS:
> +		ret = nvme_update_ns_info(ns, id);
> +		break;
> +	default:
> +		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
> +		break;
> +	}
> +	if (ret)
>   		goto out_unlink_ns;
>   
>   	down_write(&ctrl->namespaces_rwsem);
> @@ -4024,11 +4075,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   	if (!nvme_ns_head_multipath(ns->head))
>   		nvme_add_ns_cdev(ns);
>   
> -	nvme_mpath_add_disk(ns, id->anagrpid);
> +	nvme_mpath_add_disk(ns, *anagrpid);
>   	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> -	kfree(id);
>   
> -	return;
> +	goto out_free_id;
>   
>    out_cleanup_ns_from_list:
>   	nvme_put_ctrl(ctrl);
> @@ -4106,29 +4156,32 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>   	}
>   }
>   
> -static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> +static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids,
> +			     struct nvme_id_ns_cs_indep *indep_id)
>   {
> -	struct nvme_id_ns *id;
> +	struct nvme_id_ns *id = NULL;
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
>   	if (test_bit(NVME_NS_DEAD, &ns->flags))
>   		goto out;
>   
> -	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
> -	if (ret)
> -		goto out;
> -
> -	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
> -	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
> -		dev_err(ns->ctrl->device,
> -			"identifiers changed for nsid %d\n", ns->head->ns_id);
> -		goto out_free_id;
> +	switch (ids->csi) {
> +	case NVME_CSI_NVM:
> +	case NVME_CSI_ZNS:
> +		if (nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id))
> +			goto out;
> +		if (!nvme_ns_ids_equal(&ns->head->ids, ids))
> +			dev_err(ns->ctrl->device,
> +				"identifiers changed for nsid %d\n", ns->head->ns_id);
> +		else
> +			ret = nvme_update_ns_info(ns, id);
> +		kfree(id);
> +		break;
> +	default:
> +		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
> +		break;
>   	}
>   
> -	ret = nvme_update_ns_info(ns, id);
> -
> -out_free_id:
> -	kfree(id);
>   out:
>   	/*
>   	 * Only remove the namespace if we got a fatal error back from the
> @@ -4143,36 +4196,34 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   {
>   	struct nvme_ns_ids ids = { };
> -	struct nvme_id_ns_cs_indep *id;
> +	struct nvme_id_ns_cs_indep *id_indep;
>   	struct nvme_ns *ns;
> -	bool ready = true;
>   
>   	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
>   		return;
>   
> +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> +		return;
> +

Is it ok to issue this without checking that the namespace is ready?

>   	/*
>   	 * Check if the namespace is ready.  If not ignore it, we will get an
>   	 * AEN once it becomes ready and restart the scan.
>   	 */
> -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
> -	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
> -		ready = id->nstat & NVME_NSTAT_NRDY;
> -		kfree(id);
> +	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +		if (!(id_indep->nstat & NVME_NSTAT_NRDY))
> +			goto free_id_indep;
>   	}
>   
> -	if (!ready)
> -		return;
> -
>   	ns = nvme_find_get_ns(ctrl, nsid);
>   	if (ns) {
> -		nvme_validate_ns(ns, &ids);
> +		nvme_validate_ns(ns, &ids, id_indep);
>   		nvme_put_ns(ns);
> -		return;
> +		goto free_id_indep;
>   	}
>   
>   	switch (ids.csi) {
>   	case NVME_CSI_NVM:
> -		nvme_alloc_ns(ctrl, nsid, &ids);
> +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
>   		break;
>   	case NVME_CSI_ZNS:
>   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> @@ -4187,13 +4238,16 @@ static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   				nsid);
>   			break;
>   		}
> -		nvme_alloc_ns(ctrl, nsid, &ids);
> +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
>   		break;
>   	default:
> -		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
> -			ids.csi, nsid);
> +		/* required to enable char-interface for unknown command sets*/
> +		nvme_alloc_ns(ctrl, nsid, &ids, id_indep);
>   		break;
>   	}
> +
> +free_id_indep:
> +	kfree(id_indep);
>   }
>   
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,

