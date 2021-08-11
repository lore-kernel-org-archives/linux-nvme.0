Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35169C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFEE60EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAFEE60EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOQ1aR9jos5PcZeRBDrsPNPP0nNxg1b0TrzTz3DvncE=; b=cXkD8pdvU2zxisxaWMQ0hRpgOY
	l93nqbNKaUJx31V++Of4EeoPrnKIwpYBkajPrM6wPAE6Ak7tht4AFtmQ5ao6BvZRHqg4LUc9pVD7y
	H9ihlOF7MT/mtFb3c388/LRGUGfVJ2J5Byly/2eq1BF/oWU9AYLBgAqhYz1RisudbU0wPPUegFiQm
	4OsrE460KL4zQJawP84XiNGwuCztsaq6qOhSWFbuUFyQeRylX3ITI/OHvIBU/T+Uwh96vHBp+XlSQ
	1PJk9KyacSpefNLbnA+YBA+7quVcY1MUGrc0EgiqcHadic2lx/2+qxn/yrTcKcE8ojHyKW7uILuNo
	a77j21HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDcsi-0059hR-Jn; Wed, 11 Aug 2021 01:18:08 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDcsf-0059gt-2X
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:18:06 +0000
Received: by mail-pl1-f181.google.com with SMTP id j3so509877plx.4
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nNOvvnq6GKhyUiK5iH8PidPtYqBBSGx7k5tk4GsNLjk=;
 b=mXZLyCLRWb+hWkX85Hj43aSzH41/qO5riGBu6c49RH71JnsYEIhdrB6mUZTgoUfmyS
 CvD+2luQ7Vq/8FtKqgUICmVXFRJS1E8V1D5F1vNzxjXFMwk1X/H5omo1WB0M6+Fipljr
 XcwqtZhwEM6dO/yUBch4rp+rRqXsxVNl0qUxsoVIs+5c7OHX3x4MEF4+yANDgK7gmWrd
 18iatFukOD9vuxn7BUye55DoxyPfVmq31B5nS1RDbPjgpJsDNs4YYXLylm14QoFkI54P
 EThngkLp6Flaa8f9rw5+gKDkJ4hkKQWoHa/LY8OPkgMct8gY31lBMvePPnjiOi92Z4X8
 Lnsw==
X-Gm-Message-State: AOAM533bQVW4SOdkxUguloE65hOtFddn/ALMv2KwlAtR3pm2YnoQLAU+
 YkmxLLQqoBZi+cMwCp/NWCk=
X-Google-Smtp-Source: ABdhPJwEAnvqi38BNjsbUXtGOsEATImPik4+1FzdaFxV9Ab7RfivuvnrfoekYOGwrBNoF6KOpQ+ogg==
X-Received: by 2002:a17:90a:9b13:: with SMTP id
 f19mr7632111pjp.224.1628644684256; 
 Tue, 10 Aug 2021 18:18:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id 37sm28552608pgt.28.2021.08.10.18.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:18:03 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: invalidate paths during rescan
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
References: <20210730071059.124347-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8718c238-de35-ad35-898d-e6620446276f@grimberg.me>
Date: Tue, 10 Aug 2021 18:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730071059.124347-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_181805_177195_2524A6C2 
X-CRM114-Status: GOOD (  26.93  )
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



On 7/30/21 12:10 AM, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When triggering a rescan due to a namespace resize we will be
> receiving AENs on every controller, triggering a rescan of all
> attached namespaces. If multipath is active only the current path and
> the ns_head disk will be updated, the other paths will still refer to
> the old size until AENs for the remaining controllers are received.
> 
> If I/O comes in before that it might be routed to one of the old
> paths, triggering an I/O failure with 'access beyond end of device'.
> With this patch the old paths are skipped from multipath path
> selection until the controller serving these paths has been rescanned.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v2:
>    - removed churn from failed rebase.
> v1:
>    - https://lore.kernel.org/linux-nvme/20210729194630.i5mhvvgb73duojqq@beryllium.lan/
> 
>   drivers/nvme/host/core.c      |  2 ++
>   drivers/nvme/host/multipath.c | 16 ++++++++++++++++
>   drivers/nvme/host/nvme.h      |  5 +++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..20a079083129 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1877,6 +1877,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   			goto out_unfreeze;
>   	}
>   
> +	clear_bit(NVME_NS_INVALIDATED, &ns->flags);
>   	blk_mq_unfreeze_queue(ns->disk->queue);
>   
>   	if (blk_queue_is_zoned(ns->queue)) {
> @@ -1888,6 +1889,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	if (nvme_ns_head_multipath(ns->head)) {
>   		blk_mq_freeze_queue(ns->head->disk->queue);
>   		nvme_update_disk_info(ns->head->disk, ns, id);
> +		nvme_mpath_invalidate_paths(ns);
>   		blk_stack_limits(&ns->head->disk->queue->limits,
>   				 &ns->queue->limits, 0);
>   		blk_queue_update_readahead(ns->head->disk->queue);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3f32c5e86bfc..579020ae058d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -147,6 +147,21 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   	mutex_unlock(&ctrl->scan_lock);
>   }
>   
> +void nvme_mpath_invalidate_paths(struct nvme_ns *ns)

invalidate is not a great name for this very specific case here.

> +{
> +	struct nvme_ns_head *head = ns->head;
> +	sector_t capacity = get_capacity(head->disk);
> +	int node;
> +
> +	for_each_node(node)
> +		rcu_assign_pointer(head->current_path[node], NULL);

Here the ns can get re-selected as the current path.

> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (capacity != get_capacity(ns->disk))
> +			set_bit(NVME_NS_INVALIDATED, &ns->flags);

maybe instead of invalidated reverse the polarity with
NVME_NS_READY? clear it here and set it in update_ns_info?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
