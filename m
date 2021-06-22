Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177AC2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 08:52:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420BD61042
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 08:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420BD61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/3oP5sWWj4GS2aCpVivWO1zlgHvlbB++BgKnf6n3+0=; b=xZLU1c+IS6SQjqQcBq/gEw947/
	/rASGZ96fE2VTHPr086FmZ80sX/alKQMswberWF/6FbEnE8fz7Ou62zs1VHsnZlIULbZbqOxN+x0g
	2siuVaGyafTvwxdaHYNObZ7zpRkjx4npaLis6fGbrjgkeEwe8jDNaLLKEr4yo40APNy+XvObJq+XB
	ftFuMX3x1bdMNvYFwxPJokV11NSFLGnCUwpD2WH+6WU/yr9CKLgKUaAN6V3PqhywnFn9S/A6of0UM
	4KUr0R4xR2EWlnCE0XGcBW/ZkgvfUtE8L9KX9+SpE4Y6K8kXgvHGmpjBQlE4X8fat4cnQaJFUmYdI
	kUAZ2L5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvc8t-006IyC-Ro; Tue, 22 Jun 2021 08:52:23 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvc8r-006IxZ-8H
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 08:52:22 +0000
Received: by mail-wr1-f49.google.com with SMTP id h11so5178291wrx.5
 for <linux-nvme@lists.infradead.org>; Tue, 22 Jun 2021 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=80Cx+4vqZbL9frbTRjoYsx7ojp33ieuY1NtaHm/ymCw=;
 b=eRi4irM6oIdUls/D1dESEAsNudFp/DTUnfIor+P2QDw+ii4b6elNiExOR9AKN0JTur
 JyGBKmqJq4C3Vk67kHPofZ4bSp4hpAe2BtNXG7N+4LS0zZ7keQPOLwq+ArMuvDJQV/7K
 DmIpzASFXsqpxm+gZ3i8mpCu2mwOZuN4VPVebRO3ScJcVrApVF67N4UWU2WGtyBIIe40
 FoZLe79Wgc7TVORc22OrY6WXuPe2hA/WdzmOjgxNX7fipXbey1qxW1j/WrW1nSdjoEfc
 sL/SlhaONbZMhNud2HE97jZi9V31QfL3/N5asqXVeMI8URZKowy2SKfZhvJbzg9jO9SH
 XHIg==
X-Gm-Message-State: AOAM531NzT7cfGP23Ua7nyj2n3gLTp3L69y5FifpuSaNnZbYHa06YvpA
 HC9Bt+nU/mJVkX6o6wjs1j245Z9YlQg=
X-Google-Smtp-Source: ABdhPJyBaK344FNFwqR2L+J9SHzsfVXzYswQMWRCZzRX0pECB5nqNsSV8Cgnuw9K9TKDhIVk4dMPBQ==
X-Received: by 2002:a05:6000:246:: with SMTP id
 m6mr849798wrz.116.1624351939632; 
 Tue, 22 Jun 2021 01:52:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a450:8917:2b92:33b7?
 ([2601:647:4802:9070:a450:8917:2b92:33b7])
 by smtp.gmail.com with ESMTPSA id 61sm21881314wrp.4.2021.06.22.01.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 01:52:19 -0700 (PDT)
Subject: Re: [PATCHv7] nvme: fix refcounting imbalance when all paths are down
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210622070140.22488-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6679737f-1af8-bc9e-5af1-ce3fac5b4d01@grimberg.me>
Date: Tue, 22 Jun 2021 01:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622070140.22488-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_015221_351031_9E4B484F 
X-CRM114-Status: GOOD (  28.64  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/22/21 12:01 AM, Hannes Reinecke wrote:
> When the last path to a ns_head drops the current code
> removes the ns_head from the subsystem list, but will only
> delete the disk itself if the last reference to the ns_head
> drops. This is causing an refcounting imbalance eg when
> applications have a reference to the disk, as then they'll
> never get notified that the disk is in fact dead.
> With this patch we are calling 'del_gendisk' and remove it
> from the list of ns_heads at the same time, ensuring that
> the disk can be properly removed and applications get the
> appropriate notifications.
> 
> Changes to v6:
> - Move the list_del() into nvme_mpath_check_last_path()
> - Drop the tests for GENHD_FL_UP
> Changes to v5:
> - Synchronize between nvme_init_ns_head() and nvme_mpath_check_last_path()
> - Check for removed gendisk in nvme_ns_head_submit_bio()
> Changes to v4:
> - Call del_gendisk() in nvme_mpath_check_last_path() to avoid deadlock
> Changes to v3:
> - Simplify if() clause to detect duplicate namespaces
> Changes to v2:
> - Drop memcpy() statement
> Changes to v1:
> - Always check NSIDs after reattach
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c      |  6 +-----
>   drivers/nvme/host/multipath.c | 28 +++++++++++++++++++++++-----
>   drivers/nvme/host/nvme.h      | 11 ++---------
>   3 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c7ef0b6684b5..106322dafe45 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3799,8 +3799,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>    out_unlink_ns:
>   	mutex_lock(&ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>   	mutex_unlock(&ctrl->subsys->lock);
>   	nvme_put_ns_head(ns->head);
>    out_free_queue:
> @@ -3821,8 +3819,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>   	mutex_unlock(&ns->ctrl->subsys->lock);
>   
>   	synchronize_rcu(); /* guarantee not available in head->list */
> @@ -3842,7 +3838,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	list_del_init(&ns->list);
>   	up_write(&ns->ctrl->namespaces_rwsem);
>   
> -	nvme_mpath_check_last_path(ns);
> +	nvme_mpath_check_last_path(ns->head);
>   	nvme_put_ns(ns);
>   }
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 23573fe3fc7d..bf9dfaefa77d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -771,20 +771,38 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>   #endif
>   }
>   
> -void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +void nvme_mpath_check_last_path(struct nvme_ns_head *head)
>   {
> +	bool last_path = false;
>   	if (!head->disk)
>   		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> -		nvme_cdev_del(&head->cdev, &head->cdev_device);
> -		del_gendisk(head->disk); > +
> +	/* Synchronize with nvme_init_ns_head() */
> +	mutex_lock(&head->subsys->lock);
> +	if (list_empty(&head->list)) {
> +		list_del_init(&head->entry);
> +		last_path = true;
>   	}

What happens now if CONFIG_NVME_MULTIPATH is not set? I'm not sure this
should be done here...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
