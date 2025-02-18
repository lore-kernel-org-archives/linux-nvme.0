Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B4C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9YdB2lf/xAULty1c3rpqiX1ztJ6KQXsmrrMcR64c6s=; b=F9M7nJipvm5FlmUSzq8l5DRzYW
	mDvtTNZw1+ip0TZtGHLs+kqPEaLazt0Mlb4CckEstyUFKi70aiIi46hLacIZbP/mJAqfLyVXPBYe0
	j+hYMWlkfnOXOLu+MQQHIYaKG+RLQl50Gqw0SUxX4GDrClBMhG9LbPqx0IvH5JJhSkIvn2dgqQsga
	UdBrdh8E3qR3vnGTJo6z4bvp10ZJrKnCw4r5C3QrBIVzAks7h7pRVRaA1rMfvR/vsq+yYbZgT0RJf
	kCxq7X18MeQymjyxRupNJbdoodwhAIlk4Vx7EUM77QmTLWPCVg8eg6Ng5Be0koI1ovhu7USPmt4T7
	8cEJz0Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkOZG-00000008Wvt-1E0V;
	Tue, 18 Feb 2025 14:27:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkOYq-00000008W6b-0cdm
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 14:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739888814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9YdB2lf/xAULty1c3rpqiX1ztJ6KQXsmrrMcR64c6s=;
	b=fPgUQtPhcR8Eg4O5wMdxOzMa5I5mEJnG9Lz1q3kw10Bwgq2+HVCRMPfZUEerd/a1UyylQO
	GFlJXUkBYUfYdlpzgDBK1pGJsR5lPVmc5zYDeRuYILvk9dZYBR+pxNLUs6C2X17eUExWN0
	ISH/ogt9MGYLa9Y44Mist1Z6dO53DYs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-ONeTPkMZNVmZOCsw6QROjg-1; Tue,
 18 Feb 2025 09:26:51 -0500
X-MC-Unique: ONeTPkMZNVmZOCsw6QROjg-1
X-Mimecast-MFC-AGG-ID: ONeTPkMZNVmZOCsw6QROjg_1739888810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A79C219030AC;
	Tue, 18 Feb 2025 14:26:49 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA5F19560A3;
	Tue, 18 Feb 2025 14:26:47 +0000 (UTC)
Message-ID: <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Date: Tue, 18 Feb 2025 09:26:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: bmarzins@redhat.com
References: <20250204211158.43126-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250204211158.43126-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_062656_324528_FF18F027 
X-CRM114-Status: GOOD (  15.51  )
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

Bryan, since we are re-spinning this patch please make the changes below.

On 2/4/25 4:11 PM, Bryan Gurney wrote:
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

I think we want to keep a similar warning like the above, only move it down below.

Let's wait for Sagi's approval of the exact message.

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

You don't need the this #ifdef conditional statement because the nvme_ns_head_multipath() function checks CONFIG_NVME_MULTIPATH
for you and the sprintf(disk->disk_name, "nvme%dn%d" statement is kind of redundant.


>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>   			ns->head->instance);
> +#endif
>   	}
>   
>   	if (nvme_update_ns_info(ns, info))

Thanks,

/John


