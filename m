Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C34C48BC2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 18:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E9C606A5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 18:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E9C606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UfynUZmOkCNyic1LodH3da15z7UA7XsVS1aSBxZJz4=; b=u4EekoMfRG+4WKUhKftOW3MC+l
	2IZtkFL/khoKtXXGPIwlS1pko7WRf1k+aIXZf7sjEbvLXhuMZo+i6hX6ZSrbq9MBT89oPi09pJ56j
	jF/9bhlpXwJKm4plX4KIEyJDc+aSKTYq0rqTKTn1dSBHpTuN+zAzmiP3OVaszp7uCLcUVTsznx5oE
	Im0FhEg4uF5Xz6IjT0aCAfHd+0gVD/oFD2aygObk71gSxHCtdEVc7ani4ZxCYQZokqxwqNNxJtS/P
	7jx6/OdjczQ7Vdwow7ya0xIAn4fvYF4GJodAlATZPHaM6tszaRyo2+B6g3fIasHJlNBAXyk0avK42
	qsPCUHTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvOW2-004XZY-17; Mon, 21 Jun 2021 18:19:22 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvOQo-004VD6-Nh
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 18:14:00 +0000
Received: by mail-wr1-f43.google.com with SMTP id j2so10164826wrs.12
 for <linux-nvme@lists.infradead.org>; Mon, 21 Jun 2021 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ph2HswF0YHZxTMEFtAUMSOHAJP/8CXKpwdbKAdYMiHU=;
 b=Bfy15271JsGEcEj93DyhEc0qG/gjCYMpHmGqeDG51ufW+lX/AJuROtE0m7JIomxkEH
 eymrf0sP9gwsZlnjKuZrL44t/G7msuvTTWtN6sqocRUDn8AERlLqV1LqMAWvdI5n6+9m
 Tc2bCvIRiZRzJqHm1yJJsGJm1UUCq+bTbziIq7JBL3mHIeOkfvsCaEISdQFcpETMMJI7
 i+j/J+IqkmbMqH7djl7DmUeAb9KEofjCnKBsoLSwUsceUXAVI5qzFABql8sHGfIgBuwp
 quka3O9v83PHmUFtcvDw+FylMY44OnVpAuhoUKjlooRZubX+94SFlgd68sT6ER2kvzjO
 1X5w==
X-Gm-Message-State: AOAM530uduyDsu0n9QlTQZSIWXK65rYCNFkWalxaQgJ01FE80/oMpurK
 4tFLDdxQaloT4Qvk6VhdGSfNmMMKV3o=
X-Google-Smtp-Source: ABdhPJxd29d+PICynygL9TzG1Xf5/s11dmoLrDyDIf93qeGjr4DCSwELGzEX94NgZcvQ273Rf+7Zvw==
X-Received: by 2002:a05:6000:1c5:: with SMTP id
 t5mr10104906wrx.71.1624299235853; 
 Mon, 21 Jun 2021 11:13:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e3ea:3939:da4c:986e?
 ([2601:647:4802:9070:e3ea:3939:da4c:986e])
 by smtp.gmail.com with ESMTPSA id f5sm21345624wrf.22.2021.06.21.11.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 11:13:55 -0700 (PDT)
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths are
 down
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210609150118.130650-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4903ef70-ed16-4b81-3570-60e9fcc5ecb0@grimberg.me>
Date: Mon, 21 Jun 2021 11:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609150118.130650-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_111358_860630_B598734C 
X-CRM114-Status: GOOD (  30.48  )
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



On 6/9/21 8:01 AM, Hannes Reinecke wrote:
> We should only remove the ns head from the list of heads per
> subsystem if the reference count drops to zero. That cleans up
> reference counting, and allows us to call del_gendisk() once the last
> path is removed (as then the ns_head should be removed anyway).
> As this introduces a (theoretical) race condition where I/O might have
> been requeued before the last path went down we also should be checking
> if the gendisk is still present in nvme_ns_head_submit_bio(),
> and failing I/O if so.
> 
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
>   drivers/nvme/host/core.c      |  9 ++++-----
>   drivers/nvme/host/multipath.c | 30 +++++++++++++++++++++++++-----
>   drivers/nvme/host/nvme.h      | 11 ++---------
>   3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 177cae44b612..6d7c2958b3e2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -566,6 +566,9 @@ static void nvme_free_ns_head(struct kref *ref)
>   	struct nvme_ns_head *head =
>   		container_of(ref, struct nvme_ns_head, ref);
>   
> +	mutex_lock(&head->subsys->lock);
> +	list_del_init(&head->entry);
> +	mutex_unlock(&head->subsys->lock);
>   	nvme_mpath_remove_disk(head);
>   	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>   	cleanup_srcu_struct(&head->srcu);
> @@ -3806,8 +3809,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>    out_unlink_ns:
>   	mutex_lock(&ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>   	mutex_unlock(&ctrl->subsys->lock);
>   	nvme_put_ns_head(ns->head);
>    out_free_queue:
> @@ -3828,8 +3829,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>   	mutex_unlock(&ns->ctrl->subsys->lock);
>   
>   	synchronize_rcu(); /* guarantee not available in head->list */
> @@ -3849,7 +3848,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	list_del_init(&ns->list);
>   	up_write(&ns->ctrl->namespaces_rwsem);
>   
> -	nvme_mpath_check_last_path(ns);
> +	nvme_mpath_check_last_path(ns->head);
>   	nvme_put_ns(ns);
>   }
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 23573fe3fc7d..31153f6ec582 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -266,6 +266,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   	int node = numa_node_id();
>   	struct nvme_ns *ns;
>   
> +	if (!(head->disk->flags & GENHD_FL_UP))
> +		return NULL;
>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
>   	if (unlikely(!ns))
>   		return __nvme_find_path(head, node);
> @@ -281,6 +283,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns;
>   
> +	if (!(head->disk->flags & GENHD_FL_UP))
> +		return false;

nvme_available_path should have no business looking at the head gendisk,
it should just understand if a PATH (a.k.a a controller) exists.

IMO, the fact that it does should tell that we should take a step back
and think about this. We are trying to keep an zombie nshead around
just for the possibility the host will reconnect (not as part of
error recovery, but as a brand new connect). Why shouldn't we just
remove it and restore it as a brand new nshead when the host attaches
again?

And IMO for queue_if_no_path, we should add a special handling such that
nvme_ns_head_submit_bio would do something explicit that is a special
case like the following:
--
         ns = nvme_find_path(head);
         if (likely(ns)) {
		/* submit */
         } else if (nvme_available_path(head)) {
		/* requeue */
	} else if (nvme_queue_if_no_path(head) &&
		   nvme_zombie_head(head))
		/* requeue */
         } else {
                 /* fail */
         }
--

And it should hopefully make it easier to debug.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
