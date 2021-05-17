Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF74C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:26:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E886100C
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 15:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E886100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QRT/Soiv0a45k1A9AIaubhwJdUFYiiZnSv4WRh8urrU=; b=MqDaWsLjoSh0Cm7LtZGIZqdBR
	UlYF18BipWBklKi8y5L4GrS7L5Qu+dgEDM306k2j/w2UvL2YtGU3E2rMUtiSGYxrHWJbFI1oIN0/a
	Q2hD+ia5dvG9DyJAvT+HYfGySdKf5ir69sUGp4v2baZva7Lel86nzA/pBrqzbfHGNUp9Btndo7V3X
	Xn3qNS5ItnOPcjQwQoK5sbUeF7rNw1/pttn3HzxKcMmiULos3DjH7oE5mEYUoVYBuowu0uPC2Swb3
	cQQLmfKCS+3b3ZD9glXNwZ7o9KNb2qyK2x7Tg5cy6tZwjC1hYVEgzbEte2mzQ89tehFy4gMgKRlHk
	5WerHn6VA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lif8G-00FOqC-B1; Mon, 17 May 2021 15:26:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lif8D-00FOpt-Dr
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 15:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SeLjjzxBdyNChsm0dLGm4/FKxdBEH6jqeEJZB/CL/zY=; b=n2P3kRBx7uR1cdp/VcUjzr77fS
 9aXRpo1mLjXHa2FL6YyaCK0qqc7ZYHPbwbkHL2t7zzUMUKTLue0yqTwT7CErMkuBskB2IgITVgn/2
 Uoy9XiO0OU39D4lVq7V6o2IaDfsrtHf0op8tRZJRGvGDunfTvhtfDqf/fVnv+s5Y0KrRIoGRKDdK1
 fLZxjFEvdXFbE6X+cFpJkA5rXBrRe5pdKevGSbedNOm6UYBeUl0kCoC/xC8J+7UD0p5utNkeyi765
 G7/h4VXKQ0vv6eVlPC+OKuS8jdMEZAu3+aXs3mRbpMui32AurTYlX8Lu2nS0apw5sab/GS78tqKQD
 iKmjkSog==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lif89-00Dv6v-Co
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 15:26:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 069A36100C;
 Mon, 17 May 2021 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621265164;
 bh=S8wr+Z80MKPZsWbY69SYVz/dJCGN+A7Xu7sGznMK56w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cLH1Skj/cSRLC2tq41uXd4yaac7dRQx1uCfUfI8ACwIeh50G1oYrs6q+Yb83NBTfi
 kA+LfLcdo5G/iIFinyh/Ff85khQC4srWwhjuh8dyF8KZRAfUkTDsN1ydWyzZMtXIUG
 sJZGHhEA71MixdVU/EqAgFXM8zX1TNV924rXPeev5WlgU1c7E7YVumsL4VDqb1MLpU
 LC4zwrhaeTF+UhVbxLVhGBEvPfRENuh+L26SVanM/Jq8iUbzAhzKC08ah9ohZDL1rC
 4cTkw4L/7g631YsET841aNKEtmERtF+7qsdzV+mqqv5GJt9+SHsKYyu0BKDW35zGWD
 mj+bNprtjTkiQ==
Date: Mon, 17 May 2021 08:26:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
References: <20210517081809.104813-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517081809.104813-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_082605_478335_BC1D09FF 
X-CRM114-Status: GOOD (  21.76  )
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

On Mon, May 17, 2021 at 10:18:09AM +0200, Hannes Reinecke wrote:
> We should only remove the ns head from the list of heads per
> subsystem if the reference count drops to zero. Removing it
> at the start of nvme_ns_remove() will prevent us from reattaching
> the namespace to the correct ns head once a path becomes available
> again.

This looks fine to me

Reviewed-by: Keith Busch <kbusch@kernel.org>

There are potential corner cases associated with namespace management
that can cause problems here, but it would certainly be a user error
that needs manual intervention anyway. I suspect those scenarios are
very uncommon too, so I think we can deal with that later if it becomes
a problem.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 522c9b229f80..a60144a4054a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -546,6 +546,9 @@ static void nvme_free_ns_head(struct kref *ref)
>  	struct nvme_ns_head *head =
>  		container_of(ref, struct nvme_ns_head, ref);
>  
> +	mutex_lock(&head->subsys->lock);
> +	list_del_init(&head->entry);
> +	mutex_unlock(&head->subsys->lock);
>  	nvme_mpath_remove_disk(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	cleanup_srcu_struct(&head->srcu);
> @@ -3605,7 +3608,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  		head->shared = is_shared;
>  	} else {
>  		ret = -EINVAL;
> -		if (!is_shared || !head->shared) {
> +		/*
> +		 * If multipath is enabled we might hit an ns head with no
> +		 * paths, but that doesn't indicate it's a shared namespace.
> +		 */
> +		if (!list_empty(&head->list) && (!is_shared || !head->shared)) {
>  			dev_err(ctrl->device,
>  				"Duplicate unshared namespace %d\n", nsid);
>  			goto out_put_ns_head;
> @@ -3764,8 +3771,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>  	mutex_unlock(&ns->ctrl->subsys->lock);
>  
>  	synchronize_rcu(); /* guarantee not available in head->list */
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
