Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5079C35FFC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7yqrhHZTGUxiP8MQjhrU4C425Xc214NfxfGBLNI0xc=; b=oM3Bucboq9Kat/welXhTHesdnZ
	Rn+C82DTD5dIHxw5ZWIymXGCzbJLopHJ9dXBuYUUuhHu2nFIPPhsItfAIXok/HjuRP6+svqjUI/Sp
	juMBQFYF1Jc3H+AdPDouNl4mO9ym3CdcEI1tuHmsetn7j9X2LY/mn3uybx3BNN0CMd4rh9AginNNb
	nzLTS6RTSR8LrZGB2KGnuJO3kp//haA0K0JRgeDkcg2d/HMGkRNB3f68OfeTUHAANcPDf+ydS04TO
	p0X0AjYAmVGs4sqDsCNNNi14lVjanTYnubP4rROTxZq1MS9vaM2k/5ZQkRDG1KTjpk2JjZwRNiKe0
	TSvhletA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx61K-00000006JLj-3uhc;
	Tue, 25 Mar 2025 15:16:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx5wA-00000006Ib1-1KiI
	for linux-nvme@bombadil.infradead.org;
	Tue, 25 Mar 2025 15:11:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=s7yqrhHZTGUxiP8MQjhrU4C425Xc214NfxfGBLNI0xc=; b=p7yYCxOVCv0wgtCi3a/wJf4k/n
	09mUINKXEhCjSYl58vV76UJy2Fzp6FYpBYczgPfYtpWY6JBUPl7XrDpTsEA5aGvL6Fu4v02kg4QkG
	xo0pjC2sW3GI5w6olmgpr9W+0VXwEXU86/oQnOrRTQ2tC4lC74DnwEgElc4SzBqEsUlBCMEtmmKdY
	ab08LlBgEQFuoAdd+fetIgTDS0kzLVGRbzcUStggdYrhw35ZCgFNRwq3lxbf7LnudjkfcJvnHl9v4
	/JV7Be+WA1CHVXABFvybPMEx/dBczfrg8BFiF9TSMtfHwh4VFdCUA/08o9hXC+g2I5furIZ/IU8iI
	KwJduViw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tx5vg-00000005XuB-2BsM
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 15:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742915454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7yqrhHZTGUxiP8MQjhrU4C425Xc214NfxfGBLNI0xc=;
	b=aBkoL64CBo573Vva9qrC1NHfqZHhjm4l/DZzwPkR2YvzaurEbJeRbiqlvkLtS/8pJHTdaV
	OtXEcOeSKPHgnf0lLivN4ZxcSt62A0bgtnh7SyIp2ky/+l3mG2C8Uk6FJOm9agcx0X+pg8
	mzcY8nh9sWIjA4Qe8s7O92YjVSodC/Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742915455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7yqrhHZTGUxiP8MQjhrU4C425Xc214NfxfGBLNI0xc=;
	b=bx1gTHeNk4wRCVZHlH+bgKXPVHL6F2BsKw759ljFCcdZJCKjiWBCppJeou0drNq4VdOpCZ
	6ND1JVzgzcXcYEVnjuL0xzBoMqtN0n4IBmnkITBtDkBFVAvC22FKbrTuNkGstNh2ULIyrE
	xC/m3V2sgOGkwCHbk2of1nFOSoT6dew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-RCx-TV8iOl2-QXzBJOO7vg-1; Tue,
 25 Mar 2025 11:09:16 -0400
X-MC-Unique: RCx-TV8iOl2-QXzBJOO7vg-1
X-Mimecast-MFC-AGG-ID: RCx-TV8iOl2-QXzBJOO7vg_1742915353
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BC031955D81;
	Tue, 25 Mar 2025 15:09:13 +0000 (UTC)
Received: from [10.22.88.188] (unknown [10.22.88.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10D911801751;
	Tue, 25 Mar 2025 15:09:10 +0000 (UTC)
Message-ID: <4cf17460-bcde-456d-8343-a2a624adb6e7@redhat.com>
Date: Tue, 25 Mar 2025 11:09:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
 axboe@kernel.dk, gjoyce@ibm.com, jmeneghi@redhat.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-3-nilay@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250321063901.747605-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_151105_428126_D83C5A5F 
X-CRM114-Status: GOOD (  25.54  )
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


On 3/21/25 2:37 AM, Nilay Shroff wrote:
> Remove the multipath module parameter from nvme-core and make native
> NVMe multipath support explicit. Since we now always create a multipath
> head disk node, even for single-port NVMe disks, when CONFIG_NVME_
> MULTIPATH is enabled, this module parameter is no longer needed to
> toggle the behavior.
> 
> Users who prefer non-native multipath must disable CONFIG_NVME_MULTIPATH
> at compile time.

This patch is not needed if you use my patch at:

https://lore.kernel.org/linux-nvme/20250322232848.225140-1-jmeneghi@redhat.com/T/#m7a6ea63be64731f19df4e17fda7db2b18d8551c7
  
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      | 18 +++++++-----------
>   drivers/nvme/host/multipath.c | 17 ++---------------
>   drivers/nvme/host/nvme.h      |  1 -
>   3 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e798809a8325..50c170425141 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3823,14 +3823,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
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
> +#ifndef CONFIG_NVME_MULTIPATH
> +		dev_warn(ctrl->device,
> +			"Found shared namespace %d, but multipathing not supported.\n",
> +			info->nsid);
> +		dev_warn_once(ctrl->device,
> +			"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");

I think this message needs to change.  See my patch at:

https://lore.kernel.org/linux-nvme/20250322232848.225140-1-jmeneghi@redhat.com/T/#md2f1d9706f4cbeb8bd53e562d1036195c0599fe1

> +#endif
>   	}
>   
>   	list_add_tail_rcu(&ns->siblings, &head->list);
> @@ -3929,9 +3928,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
>   			ctrl->instance, ns->head->instance);
>   		disk->flags |= GENHD_FL_HIDDEN;
> -	} else if (multipath) {
> -		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
> -			ns->head->instance);

I don't think we should remove the 'multipath' variable here we just need to control the users ability
to change it.

>   	} else {
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>   			ns->head->instance);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0f54889bd483..84211f64d178 100644
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
> @@ -671,14 +666,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
>   	head->delayed_shutdown_sec = 0;
>   
> -	/*
> -	 * A head disk node is always created for all types of NVMe disks
> -	 * (single-ported and multi-ported), unless the multipath module
> -	 * parameter is explicitly set to false.
> -	 */
> -	if (!multipath)
> -		return 0;
> -
>   	blk_set_stacking_limits(&lim);
>   	lim.dma_alignment = 3;
>   	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> @@ -1262,8 +1249,8 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	size_t ana_log_size;
>   	int error = 0;
>   
> -	/* check if multipath is enabled and we have the capability */
> -	if (!multipath || !ctrl->subsys ||
> +	/* check if controller has ANA capability */
> +	if (!ctrl->subsys ||
>   	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>   		return 0;
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 4375357b8cd7..fba686b91976 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -997,7 +997,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   	return disk->fops == &nvme_ns_head_ops;
>   }
>   #else
> -#define multipath false
>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>   {
>   	return false;


