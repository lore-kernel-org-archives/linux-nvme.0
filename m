Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E3C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444DF6152A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 444DF6152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZR24WDtWzTdl0dz9WLuhCFRBo8xH/iLDxJeeFyokPZY=; b=LcQMQej/1Rr7H13NVCwRQQfCT6
	AG5CUomGowiPoLmqTgfXWeKqHsHwuJN+JFEVx+0suOes3FLqQwVyyBCzUtERLPgt2cJ8O1GabPsqI
	063zyO2hWGqQxNTEz0Lg8SRcYOS2kIoe3kJkQfF+tKD3tvRW6SLZ9K6f26aty0ncpxZDXLQvnOP4u
	jrvjNeIzFNyyIQMLI2ak0KxmkmxBm3HeY8wu8i+IJ1JSH6nq2jPePXYAFmTNV5bArYCUFKCQxUlgG
	9JPcPjxjNs2FEHIqOE99zpPDTUj9/th13OPmXMgp06g1+5K7Gm1OqWRLA9DsYq53/QcOp1pfqZ04y
	Rjuyb15Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDZ4-0007Aw-FY; Mon, 23 Aug 2021 17:16:50 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDYf-00074D-Cw
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:16:28 +0000
Received: by mail-ed1-f47.google.com with SMTP id s25so14589589edw.0
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qUCyu2M+XnnIg56S9qGvy39oPESzj10FdrNHnuAxzuc=;
 b=tsNHuROpYDAFRSC9D/IUWKYXx1HXTotqtQLJDuB8S31y6XSlOaHcW5rlItXAjQc0zB
 r/hZzaPQyuB4SEBs0Zmc7xRTH0J52N5zYLG85FNYGpHuuejO76HaZnLaPfH4xnh0xMQ9
 0EI6NjHCFhnTqGbWloFE34WxoQ3pdIMjaOpv1EbovM7rx/jUrK+pNMp9wX3Z3ZNnGgX1
 YZaRKJ80s32EljqDgtx6sHwhiZqcCdbaO+wg+tb0TCuDYEfzD7M9g95wYq6cC/WOsmoj
 QLfWZ5DftWM0RizfJzOrmPN0wXZ4dr50fh1RmK0uus0ri0ykNCTTcqsrov/DQNs5p+Jb
 tdOg==
X-Gm-Message-State: AOAM530gWbdR25QuvCgsH1l63pRzgrRwW0nEC1udblEK9anNPTmWNkUD
 svlsykKKK1q3VMWve3JnPqQ=
X-Google-Smtp-Source: ABdhPJxpOT0fUPynmkj7Rh5qMyesz4W8uSAmXQbwc6w3wKCGF0XA4fj5COiSd9dyemeGW4TdxVP3rw==
X-Received: by 2002:a05:6402:1c03:: with SMTP id
 ck3mr38504746edb.312.1629738983576; 
 Mon, 23 Aug 2021 10:16:23 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id v12sm9885549ede.16.2021.08.23.10.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:16:23 -0700 (PDT)
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20210811152803.30017-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
Date: Mon, 23 Aug 2021 10:16:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_101625_469069_DDB79F7A 
X-CRM114-Status: GOOD (  28.49  )
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



On 8/11/21 8:28 AM, Daniel Wagner wrote:
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
> [dwagner: - introduce NVME_NS_READY flag instead of NVME_NS_INVALIDATE
>            - use 'revalidate' instead of 'invalidate' which
> 	    follows the zoned device code path.]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v3:
>    - Renamed nvme_mpath_invalidated_paths to nvme_mpath_revalidate_paths()
>    - Replaced NVME_NS_INVALIDATE with NVME_NS_READY
> v2:
>    - https://lore.kernel.org/linux-nvme/20210730071059.124347-1-dwagner@suse.de/
>    - removed churn from failed rebase.
> v1:
>    - https://lore.kernel.org/linux-nvme/20210729194630.i5mhvvgb73duojqq@beryllium.lan/
> 
> drivers/nvme/host/core.c      |  3 +++
>   drivers/nvme/host/multipath.c | 17 ++++++++++++++++-
>   drivers/nvme/host/nvme.h      |  5 +++++
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2f0cbaba12ac..54aafde4f556 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1878,6 +1878,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   			goto out_unfreeze;
>   	}
>   
> +	set_bit(NVME_NS_READY, &ns->flags);
>   	blk_mq_unfreeze_queue(ns->disk->queue);
>   
>   	if (blk_queue_is_zoned(ns->queue)) {
> @@ -1889,6 +1890,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>   	if (nvme_ns_head_multipath(ns->head)) {
>   		blk_mq_freeze_queue(ns->head->disk->queue);
>   		nvme_update_disk_info(ns->head->disk, ns, id);
> +		nvme_mpath_revalidate_paths(ns);
>   		blk_stack_limits(&ns->head->disk->queue->limits,
>   				 &ns->queue->limits, 0);
>   		blk_queue_update_readahead(ns->head->disk->queue);
> @@ -3816,6 +3818,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>   		return;
>   
> +	clear_bit(NVME_NS_READY, &ns->flags);
>   	set_capacity(ns->disk, 0);
>   	nvme_fault_inject_fini(&ns->fault_inject);
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3f32c5e86bfc..d390f14b8bb6 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -147,6 +147,21 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   	mutex_unlock(&ctrl->scan_lock);
>   }
>   
> +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> +{
> +	struct nvme_ns_head *head = ns->head;
> +	sector_t capacity = get_capacity(head->disk);
> +	int node;
> +
> +	for_each_node(node)
> +		rcu_assign_pointer(head->current_path[node], NULL);
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (capacity != get_capacity(ns->disk))
> +			clear_bit(NVME_NS_READY, &ns->flags);
> +	}

Shouldn't the null setting to current_path come after
we clear NVME_NS_READY on the ns? Otherwise we may still
submit and current_path will be populated with the ns
again...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
