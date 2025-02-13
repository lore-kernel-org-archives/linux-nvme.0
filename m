Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF76C021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mmfa0Lwrfu2BcZRq9JQarPycpfa4dNJTVenTMpKLc9k=; b=XSQYtUvJjqxMc4CfdH5JifBNGg
	w7/J/+/hGoyzv4AX4T7WdOY4gIom5kDBhkQdWhCKOqJljOGRnyQu+biKbVZktd1iuGLjIH5RUJrYi
	FUkRAsjpucx1nOPZRfyrRW3+Ni1CRgolShTwzz78HlH88UZBmnGlf1ZtK4kh5VFiSd98huKWMKs8D
	vzlc/usb6ALqutE2lAhiNDM6ZDABekQ5atU9Sq8kPqmw4Sil2pWiyskK8aoRLGSP8BUqU3vCeeLcP
	wghQL5wJB3idz15ug1RaTrNocu4zHaLWr/mQyVzY/IFOeR+VW+Z5ausVGZAy+ajke+I7rp8JVkzaN
	Aa+m2JMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tifxu-0000000CYuD-1dtA;
	Thu, 13 Feb 2025 20:37:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tifxr-0000000CYrr-29XG
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 20:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmfa0Lwrfu2BcZRq9JQarPycpfa4dNJTVenTMpKLc9k=;
	b=X+5XUFAEFqEH0hBseGyYs8AA0eTkkLWRtR0AH2Xta1GCgbUj2ZjB66ve5VhEufQTbNjWc4
	XPI3Fh/NTKWPc2HzAaZk+l5Cu1zU2pWvq2igX1ewqiyFf4lmRqAStNywcHA1cD68pOfMnK
	k8+uGvh9xp3AyuRUXaldlRxtZ85kTyo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-vCtkOhd1Mfey-1-7g5rthQ-1; Thu,
 13 Feb 2025 15:37:34 -0500
X-MC-Unique: vCtkOhd1Mfey-1-7g5rthQ-1
X-Mimecast-MFC-AGG-ID: vCtkOhd1Mfey-1-7g5rthQ_1739479052
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 474C918EAB38;
	Thu, 13 Feb 2025 20:37:32 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B3CA300018D;
	Thu, 13 Feb 2025 20:37:29 +0000 (UTC)
Message-ID: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
Date: Thu, 13 Feb 2025 15:37:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
Content-Language: en-US
Organization: RHEL Core Storge Team
In-Reply-To: <20250204211158.43126-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_123739_628257_849749BD 
X-CRM114-Status: GOOD (  30.28  )
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

Keith, Christoph and Sagi,

This patch has been fully tested and analyzed by Red Hat's QA group and no
unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
have been tested. Our QE engineer has asked me to report this upstream.

Tested-by: Marco Patalano <mpatalan@redhat.com>

Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme subsystems")

As discussed in previous email threads, the nvme.core_multipath parameter was included
by Christoph in the original implementation of nvme/host/multipath.c back in 2017
at the request of Red Hat. At that time Red Hat was only supporting DMMP multipath
with NVMe and we needed a way to disable core native nvme multipathing without
reconfiging the kernel.

The nvme.core_multipath parameter has been used by Red Hat, together with some additional
out-of-tree changes to nvme/host/core.c, to support DMMP multipath with NVMe since RHEL-8.
However, the plan all along has been to deprecate and remove support for DMMP multipath with NVMe
in RHEL and to remove this parameter. This change has been advertised and communicated to our
customers and partners, beginning with RHEL-9, through release notes and other communications.

In RHEL-9 we changed the default setting of this parameter from "N" to "Y" to match the upstream
kernel and the move our customers to native nvme multipath. DMMP multipath w/NVMe was deprecated
in RHEL-9 but still supported. Customers were still able to optionally enabled DMMP multipath
with NVMe if they wanted, by changing this parameter, and many of them do.

In the (soon to be released) RHEL-10 release DMMP multipath is longer supported with NVMe and
the out-of-tree patches needed to support DMMP multipath with NVMe have been removed.

Red Hat is proposing this patch to remove nvme.core_multipath parameter from the kernel as we believe
leaving this non-supported parameter in the kernel for future releases will only lead to confusion.

We plan to ship this patch with RHEL-10. So it would be really good if we could get this
change accepted and merged upstream, perhaps into v6.15.

/John

On 2/4/25 4:11 PM, Bryan Gurney wrote:
> Since device-mapper multipath will no longer be operating on NVMe
> devices, there is no longer a need for the "multipath" parameter.
> 
> Note that, when compiled with CONFIG_NVME_MULTIPATH off multi-path
> capable controllers and namespaces will continue to present multiple
> device entries - one for each controller/namespace discovered.  This
> could be confusing, as device-mapper multipath relies upon code in
> nvme/host/multipath.c, and running device-mapper multipath with a
> kernel compiled with CONFIG_NVME_MULTIPATH disabled is not supported.
> 
> Closes: https://lore.kernel.org/linux-nvme/20241121220321.40616-1-bgurney@redhat.com/
> 
> Tested-by: John Meneghini <jmeneghi@redhat.com>
> Reviewed-by: John Meneghini <jmeneghi@redhat.com>
> 
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
>   drivers/nvme/host/core.c      | 14 ++++----------
>   drivers/nvme/host/multipath.c | 14 ++++++--------
>   drivers/nvme/host/nvme.h      |  2 --
>   3 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2bcd9f710cb6..b07cd482fbc1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3809,14 +3809,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   					info->nsid);
>   			goto out_put_ns_head;
>   		}
> -
> -		if (!multipath) {
> -			dev_warn(ctrl->device,
> -				"Found shared namespace %d, but multipathing not supported.\n",
> -				info->nsid);
> -			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> -		}
>   	}
>   
>   	list_add_tail_rcu(&ns->siblings, &head->list);
> @@ -3915,12 +3907,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
>   			ctrl->instance, ns->head->instance);
>   		disk->flags |= GENHD_FL_HIDDEN;
> -	} else if (multipath) {
> +	} else {
> +#ifdef CONFIG_NVME_MULTIPATH
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
>   			ns->head->instance);
> -	} else {
> +#else
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>   			ns->head->instance);
> +#endif
>   	}
>   
>   	if (nvme_update_ns_info(ns, info))
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a85d190942bd..28ab868182b2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -9,11 +9,6 @@
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> -bool multipath = true;
> -module_param(multipath, bool, 0444);
> -MODULE_PARM_DESC(multipath,
> -	"turn on native support for multiple controllers per subsystem");
> -
>   static const char *nvme_iopolicy_names[] = {
>   	[NVME_IOPOLICY_NUMA]	= "numa",
>   	[NVME_IOPOLICY_RR]	= "round-robin",
> @@ -632,9 +627,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	 * We also do this for private namespaces as the namespace sharing flag
>   	 * could change after a rescan.
>   	 */
> +#ifdef CONFIG_NVME_MULTIPATH
>   	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
> -	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
> +	    !nvme_is_unique_nsid(ctrl, head))
>   		return 0;
> +#endif
>   
>   	blk_set_stacking_limits(&lim);
>   	lim.dma_alignment = 3;
> @@ -1038,10 +1035,11 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	size_t ana_log_size;
>   	int error = 0;
>   
> +#ifdef CONFIG_NVME_MULTIPATH
>   	/* check if multipath is enabled and we have the capability */
> -	if (!multipath || !ctrl->subsys ||
> -	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
> +	if (!ctrl->subsys || !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>   		return 0;
> +#endif
>   
>   	/* initialize this in the identify path to cover controller resets */
>   	atomic_set(&ctrl->nr_active, 0);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2c76afd00390..6dea04f05b59 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -972,7 +972,6 @@ static inline void nvme_trace_bio_complete(struct request *req)
>   		trace_block_bio_complete(ns->head->disk->queue, req->bio);
>   }
>   
> -extern bool multipath;
>   extern struct device_attribute dev_attr_ana_grpid;
>   extern struct device_attribute dev_attr_ana_state;
>   extern struct device_attribute subsys_attr_iopolicy;
> @@ -982,7 +981,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   	return disk->fops == &nvme_ns_head_ops;
>   }
>   #else
> -#define multipath false
>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>   {
>   	return false;


