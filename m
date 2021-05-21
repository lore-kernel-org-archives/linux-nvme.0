Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25CC04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:32:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F9E613AF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F9E613AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZoGTflFlL8Iy47M9EnIFeI8vS3foAUhMBMA4FLi/PM=; b=TVRit2dap71betiBdkPGyVXr/k
	5kXRfE/NF5HJm909HLMnpaLu9YE1MyNYZQvBopLfJqa3Z/6xKfcKYe19UIpe2LlQ7f5hmScttfnSJ
	gqpMpqT2dI5mrtI0pEusxUd4S/qmLy+k/oK6Zt55PZSFMkkOVxHrq9I1yYzWXLnvO8YL7pbDhRAHc
	amiXqRmTVuDq1vApH8y0jl0en0Y1bW6FzcSHPaGiLx6jogrXIqalKUhBchPgyI/Pf3exthotSrfjD
	zg04auXTQ33cZWImSX9P8hSn5XJZxaxkCBb0HCAv5rlhXpZ9diz/B4jSFoD8CxNXseh+MUHQDoKEW
	TWqqQVTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDgd-001FYU-PA; Fri, 21 May 2021 22:32:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDga-001FUv-1q
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=7D7hAyxd+YgPQsreLV/ZcejVxxxPZotMk7g86Afma6s=; b=ttpu9lx9OVzvEHEKxpn/79UPVE
 TvTpaenmb9cWsgx1F42PxWRIHm2+2CmVfPeSErEuUTZvByaXOTgEreh9oVBXuf5wx6Y5Cn1gw7jV0
 ObYmuBoQO/T3w74sBOSCylbCxStrubFaSP49t9ooPYxhJkdx0GsUiho8O9+wll89hIdABUgAlI1O6
 lVslLFQd6Pg2sZsEEFtl6v7//iKXXURDC4bjRmEdxDJqmJ+4XB2cbNeAwFQiQsAW8QyDNoZ4DbvoS
 FWmC8jEm6hkJfjxsgvsWm87k1qUnhSp7KZU6Wq4N7/CR8yrSNEW6Ou4mZ+k2PzOpNUGwiLrI3C6iQ
 z703RAQw==;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDgW-00HTP7-8A
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:32:02 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso8193254wmm.3
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 15:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7D7hAyxd+YgPQsreLV/ZcejVxxxPZotMk7g86Afma6s=;
 b=s7hnlkcLJs8oTNfHklLuAc8kdvkpG/kJ2fJXr2EwzEbujc8ELXstzv2qJxNs9WMBnS
 9wh8yJcAXm4TFjsf0Mtq5LzVhfo3KUP04YIemwjoJfXr4SRHvSpH0zF/Dx+btTCtP+0C
 MfM+wToaSUCRsC7QI1GroViffy24/G2WIuTWYg1HgeCDMiLi5oeEAJ6qZMJu+qNM9ZqD
 5/looRRLBzCS4gAMQwUugzre0ag+ZC0O44ZUwfAiMsso5xij5tUIFatqgHttOFZpPjpK
 Dz6IbN7crjYS7jwe2XVDbz3OvjQP0LZcEu5bqtlaG0uFnP0ZvtARZKCm54FEcDJ3vtJL
 2fQw==
X-Gm-Message-State: AOAM532huFHrSnjrwMgIB3REzS9Oir22b3G+BJtdHilvz9RXzbgtQmsB
 I92ZUx5o++f86xEan1vKB2g=
X-Google-Smtp-Source: ABdhPJw0Qw90RHsra77qOThFhq+JiKQvFKYLW5H2QcBtWsVG/ypJPoIXAoHuqgy7xnqKm9e8R+82gw==
X-Received: by 2002:a05:600c:221a:: with SMTP id
 z26mr11123746wml.122.1621636318323; 
 Fri, 21 May 2021 15:31:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id r2sm3612703wrv.39.2021.05.21.15.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 15:31:57 -0700 (PDT)
Subject: Re: [RFC PATCH v5 04/27] nvme-tcp-offload: Add controller level
 implementation
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-5-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4b24aac6-fcce-4d7c-6cf4-17a52f1bf6f0@grimberg.me>
Date: Fri, 21 May 2021 15:31:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519111340.20613-5-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_153200_345263_6162AD95 
X-CRM114-Status: GOOD (  37.19  )
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



On 5/19/21 4:13 AM, Shai Malin wrote:
> From: Arie Gershberg <agershberg@marvell.com>
> 
> In this patch we implement controller level functionality including:
> - create_ctrl.
> - delete_ctrl.
> - free_ctrl.
> 
> The implementation is similar to other nvme fabrics modules, the main
> difference being that the nvme-tcp-offload ULP calls the vendor specific
> claim_dev() op with the given TCP/IP parameters to determine which device
> will be used for this controller.
> Once found, the vendor specific device and controller will be paired and
> kept in a controller list managed by the ULP.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Arie Gershberg <agershberg@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> ---
>   drivers/nvme/host/tcp-offload.c | 475 +++++++++++++++++++++++++++++++-
>   1 file changed, 467 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
> index aa7cc239abf2..f7e0dc79bedd 100644
> --- a/drivers/nvme/host/tcp-offload.c
> +++ b/drivers/nvme/host/tcp-offload.c
> @@ -12,6 +12,10 @@
>   
>   static LIST_HEAD(nvme_tcp_ofld_devices);
>   static DECLARE_RWSEM(nvme_tcp_ofld_devices_rwsem);
> +static LIST_HEAD(nvme_tcp_ofld_ctrl_list);
> +static DECLARE_RWSEM(nvme_tcp_ofld_ctrl_rwsem);
> +static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops;
> +static struct blk_mq_ops nvme_tcp_ofld_mq_ops;
>   
>   static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
>   {
> @@ -128,28 +132,435 @@ nvme_tcp_ofld_lookup_dev(struct nvme_tcp_ofld_ctrl *ctrl)
>   	return dev;
>   }
>   
> +static struct blk_mq_tag_set *
> +nvme_tcp_ofld_alloc_tagset(struct nvme_ctrl *nctrl, bool admin)
> +{
> +	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
> +	struct blk_mq_tag_set *set;
> +	int rc;
> +
> +	if (admin) {
> +		set = &ctrl->admin_tag_set;
> +		memset(set, 0, sizeof(*set));
> +		set->ops = &nvme_tcp_ofld_admin_mq_ops;
> +		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
> +		set->reserved_tags = NVMF_RESERVED_TAGS;
> +		set->numa_node = nctrl->numa_node;
> +		set->flags = BLK_MQ_F_BLOCKING;
> +		set->cmd_size = sizeof(struct nvme_tcp_ofld_req);
> +		set->driver_data = ctrl;
> +		set->nr_hw_queues = 1;
> +		set->timeout = NVME_ADMIN_TIMEOUT;
> +	} else {
> +		set = &ctrl->tag_set;
> +		memset(set, 0, sizeof(*set));
> +		set->ops = &nvme_tcp_ofld_mq_ops;
> +		set->queue_depth = nctrl->sqsize + 1;
> +		set->reserved_tags = NVMF_RESERVED_TAGS;
> +		set->numa_node = nctrl->numa_node;
> +		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;

Why do you set BLK_MQ_F_BLOCKING? do you schedule in the submission path?

> +		set->cmd_size = sizeof(struct nvme_tcp_ofld_req);
> +		set->driver_data = ctrl;
> +		set->nr_hw_queues = nctrl->queue_count - 1;
> +		set->timeout = NVME_IO_TIMEOUT;
> +		set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
> +	}
> +
> +	rc = blk_mq_alloc_tag_set(set);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return set;
> +}
> +
> +static int nvme_tcp_ofld_configure_admin_queue(struct nvme_ctrl *nctrl,
> +					       bool new)
> +{
> +	int rc;
> +
> +	/* Placeholder - alloc_admin_queue */
> +	if (new) {
> +		nctrl->admin_tagset =
> +				nvme_tcp_ofld_alloc_tagset(nctrl, true);
> +		if (IS_ERR(nctrl->admin_tagset)) {
> +			rc = PTR_ERR(nctrl->admin_tagset);
> +			nctrl->admin_tagset = NULL;
> +			goto out_free_queue;
> +		}
> +
> +		nctrl->fabrics_q = blk_mq_init_queue(nctrl->admin_tagset);
> +		if (IS_ERR(nctrl->fabrics_q)) {
> +			rc = PTR_ERR(nctrl->fabrics_q);
> +			nctrl->fabrics_q = NULL;
> +			goto out_free_tagset;
> +		}
> +
> +		nctrl->admin_q = blk_mq_init_queue(nctrl->admin_tagset);
> +		if (IS_ERR(nctrl->admin_q)) {
> +			rc = PTR_ERR(nctrl->admin_q);
> +			nctrl->admin_q = NULL;
> +			goto out_cleanup_fabrics_q;
> +		}
> +	}
> +
> +	/* Placeholder - nvme_tcp_ofld_start_queue */
> +
> +	rc = nvme_enable_ctrl(nctrl);
> +	if (rc)
> +		goto out_stop_queue;
> +
> +	blk_mq_unquiesce_queue(nctrl->admin_q);
> +
> +	rc = nvme_init_ctrl_finish(nctrl);
> +	if (rc)
> +		goto out_quiesce_queue;
> +
> +	return 0;
> +
> +out_quiesce_queue:
> +	blk_mq_quiesce_queue(nctrl->admin_q);
> +	blk_sync_queue(nctrl->admin_q);
> +
> +out_stop_queue:
> +	/* Placeholder - stop offload queue */
> +	nvme_cancel_admin_tagset(nctrl);
> +
> +out_cleanup_fabrics_q:
> +	if (new)
> +		blk_cleanup_queue(nctrl->fabrics_q);
> +out_free_tagset:
> +	if (new)
> +		blk_mq_free_tag_set(nctrl->admin_tagset);
> +out_free_queue:
> +	/* Placeholder - free admin queue */
> +
> +	return rc;
> +}
> +
> +static int
> +nvme_tcp_ofld_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
> +{
> +	int rc;
> +
> +	/* Placeholder - alloc_io_queues */
> +
> +	if (new) {
> +		nctrl->tagset = nvme_tcp_ofld_alloc_tagset(nctrl, false);
> +		if (IS_ERR(nctrl->tagset)) {
> +			rc = PTR_ERR(nctrl->tagset);
> +			nctrl->tagset = NULL;
> +			goto out_free_io_queues;
> +		}
> +
> +		nctrl->connect_q = blk_mq_init_queue(nctrl->tagset);
> +		if (IS_ERR(nctrl->connect_q)) {
> +			rc = PTR_ERR(nctrl->connect_q);
> +			nctrl->connect_q = NULL;
> +			goto out_free_tag_set;
> +		}
> +	}
> +
> +	/* Placeholder - start_io_queues */
> +
> +	if (!new) {
> +		nvme_start_queues(nctrl);
> +		if (!nvme_wait_freeze_timeout(nctrl, NVME_IO_TIMEOUT)) {
> +			/*
> +			 * If we timed out waiting for freeze we are likely to
> +			 * be stuck.  Fail the controller initialization just
> +			 * to be safe.
> +			 */
> +			rc = -ENODEV;
> +			goto out_wait_freeze_timed_out;
> +		}
> +		blk_mq_update_nr_hw_queues(nctrl->tagset, nctrl->queue_count - 1);
> +		nvme_unfreeze(nctrl);
> +	}
> +
> +	return 0;
> +
> +out_wait_freeze_timed_out:
> +	nvme_stop_queues(nctrl);
> +	nvme_sync_io_queues(nctrl);
> +
> +	/* Placeholder - Stop IO queues */
> +
> +	if (new)
> +		blk_cleanup_queue(nctrl->connect_q);
> +out_free_tag_set:
> +	if (new)
> +		blk_mq_free_tag_set(nctrl->tagset);
> +out_free_io_queues:
> +	/* Placeholder - free_io_queues */
> +
> +	return rc;
> +}
> +
>   static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
>   {
> -	/* Placeholder - validates inputs and creates admin and IO queues */
> +	struct nvmf_ctrl_options *opts = nctrl->opts;
> +	int rc;
> +
> +	rc = nvme_tcp_ofld_configure_admin_queue(nctrl, new);
> +	if (rc)
> +		return rc;
> +
> +	if (nctrl->icdoff) {
> +		dev_err(nctrl->device, "icdoff is not supported!\n");
> +		rc = -EINVAL;
> +		goto destroy_admin;
> +	}
> +
> +	if (!(nctrl->sgls & ((1 << 0) | (1 << 1)))) {
> +		dev_err(nctrl->device, "Mandatory sgls are not supported!\n");
> +		goto destroy_admin;
> +	}
> +
> +	if (opts->queue_size > nctrl->sqsize + 1)
> +		dev_warn(nctrl->device,
> +			 "queue_size %zu > ctrl sqsize %u, clamping down\n",
> +			 opts->queue_size, nctrl->sqsize + 1);
> +
> +	if (nctrl->sqsize + 1 > nctrl->maxcmd) {
> +		dev_warn(nctrl->device,
> +			 "sqsize %u > ctrl maxcmd %u, clamping down\n",
> +			 nctrl->sqsize + 1, nctrl->maxcmd);
> +		nctrl->sqsize = nctrl->maxcmd - 1;
> +	}
> +
> +	if (nctrl->queue_count > 1) {
> +		rc = nvme_tcp_ofld_configure_io_queues(nctrl, new);
> +		if (rc)
> +			goto destroy_admin;
> +	}
> +
> +	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_LIVE)) {
> +		/*
> +		 * state change failure is ok if we started ctrl delete,
> +		 * unless we're during creation of a new controller to
> +		 * avoid races with teardown flow.
> +		 */
> +		WARN_ON_ONCE(nctrl->state != NVME_CTRL_DELETING &&
> +			     nctrl->state != NVME_CTRL_DELETING_NOIO);
> +		WARN_ON_ONCE(new);
> +		rc = -EINVAL;
> +		goto destroy_io;
> +	}
> +
> +	nvme_start_ctrl(nctrl);
> +
> +	return 0;
> +
> +destroy_io:
> +	/* Placeholder - stop and destroy io queues*/
> +destroy_admin:
> +	/* Placeholder - stop and destroy admin queue*/
> +
> +	return rc;
> +}
> +
> +static int
> +nvme_tcp_ofld_check_dev_opts(struct nvmf_ctrl_options *opts,
> +			     struct nvme_tcp_ofld_ops *ofld_ops)
> +{
> +	unsigned int nvme_tcp_ofld_opt_mask = NVMF_ALLOWED_OPTS |
> +			ofld_ops->allowed_opts | ofld_ops->required_opts;
> +	if (opts->mask & ~nvme_tcp_ofld_opt_mask) {
> +		pr_warn("One or more of the nvmf options isn't supported by %s.\n",
> +			ofld_ops->name);

Which one(s)?

> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvme_tcp_ofld_free_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	struct nvme_tcp_ofld_ctrl *ctrl = to_tcp_ofld_ctrl(nctrl);
> +	struct nvme_tcp_ofld_dev *dev = ctrl->dev;
> +
> +	if (list_empty(&ctrl->list))
> +		goto free_ctrl;
> +
> +	down_write(&nvme_tcp_ofld_ctrl_rwsem);
> +	ctrl->dev->ops->release_ctrl(ctrl);

Why is release called under the lock? specific reason?

> +	list_del(&ctrl->list);
> +	up_write(&nvme_tcp_ofld_ctrl_rwsem);
> +
> +	nvmf_free_options(nctrl->opts);
> +free_ctrl:
> +	module_put(dev->ops->module);
> +	kfree(ctrl->queues);
> +	kfree(ctrl);
> +}
> +
> +static void nvme_tcp_ofld_submit_async_event(struct nvme_ctrl *arg)
> +{
> +	/* Placeholder - submit_async_event */
> +}
> +
> +static void
> +nvme_tcp_ofld_teardown_admin_queue(struct nvme_ctrl *ctrl, bool remove)
> +{
> +	/* Placeholder - teardown_admin_queue */
> +}
> +
> +static void
> +nvme_tcp_ofld_teardown_io_queues(struct nvme_ctrl *nctrl, bool remove)
> +{
> +	/* Placeholder - teardown_io_queues */
> +}
> +
> +static void
> +nvme_tcp_ofld_teardown_ctrl(struct nvme_ctrl *nctrl, bool shutdown)
> +{
> +	/* Placeholder - err_work and connect_work */
> +	nvme_tcp_ofld_teardown_io_queues(nctrl, shutdown);
> +	blk_mq_quiesce_queue(nctrl->admin_q);
> +	if (shutdown)
> +		nvme_shutdown_ctrl(nctrl);
> +	else
> +		nvme_disable_ctrl(nctrl);
> +	nvme_tcp_ofld_teardown_admin_queue(nctrl, shutdown);
> +}
> +
> +static void nvme_tcp_ofld_delete_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	nvme_tcp_ofld_teardown_ctrl(nctrl, true);
> +}
> +
> +static int
> +nvme_tcp_ofld_init_request(struct blk_mq_tag_set *set,
> +			   struct request *rq,
> +			   unsigned int hctx_idx,
> +			   unsigned int numa_node)
> +{
> +	struct nvme_tcp_ofld_req *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_ofld_ctrl *ctrl = set->driver_data;
> +
> +	/* Placeholder - init request */
> +
> +	req->done = nvme_tcp_ofld_req_done;
> +	ctrl->dev->ops->init_req(req);
>   
>   	return 0;
>   }
>   
> +static blk_status_t
> +nvme_tcp_ofld_queue_rq(struct blk_mq_hw_ctx *hctx,
> +		       const struct blk_mq_queue_data *bd)
> +{
> +	/* Call nvme_setup_cmd(...) */
> +
> +	/* Call ops->send_req(...) */
> +
> +	return BLK_STS_OK;
> +}
> +
> +static struct blk_mq_ops nvme_tcp_ofld_mq_ops = {
> +	.queue_rq	= nvme_tcp_ofld_queue_rq,
> +	.init_request	= nvme_tcp_ofld_init_request,
> +	/*
> +	 * All additional ops will be also implemented and registered similar to
> +	 * tcp.c
> +	 */
> +};
> +
> +static struct blk_mq_ops nvme_tcp_ofld_admin_mq_ops = {
> +	.queue_rq	= nvme_tcp_ofld_queue_rq,
> +	.init_request	= nvme_tcp_ofld_init_request,
> +	/*
> +	 * All additional ops will be also implemented and registered similar to
> +	 * tcp.c
> +	 */
> +};
> +
> +static const struct nvme_ctrl_ops nvme_tcp_ofld_ctrl_ops = {
> +	.name			= "tcp_offload",
> +	.module			= THIS_MODULE,
> +	.flags			= NVME_F_FABRICS,
> +	.reg_read32		= nvmf_reg_read32,
> +	.reg_read64		= nvmf_reg_read64,
> +	.reg_write32		= nvmf_reg_write32,
> +	.free_ctrl		= nvme_tcp_ofld_free_ctrl,
> +	.submit_async_event	= nvme_tcp_ofld_submit_async_event,

Its pretty difficult to review when you have declarations of functions
that don't exist yet. It also hurts bisectability.

> +	.delete_ctrl		= nvme_tcp_ofld_delete_ctrl,
> +	.get_address		= nvmf_get_address,
> +};
> +
> +static bool
> +nvme_tcp_ofld_existing_controller(struct nvmf_ctrl_options *opts)
> +{
> +	struct nvme_tcp_ofld_ctrl *ctrl;
> +	bool found = false;
> +
> +	down_read(&nvme_tcp_ofld_ctrl_rwsem);
> +	list_for_each_entry(ctrl, &nvme_tcp_ofld_ctrl_list, list) {
> +		found = nvmf_ip_options_match(&ctrl->nctrl, opts);
> +		if (found)
> +			break;
> +	}
> +	up_read(&nvme_tcp_ofld_ctrl_rwsem);
> +
> +	return found;
> +}
> +
>   static struct nvme_ctrl *
>   nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
>   {
> +	struct nvme_tcp_ofld_queue *queue;
>   	struct nvme_tcp_ofld_ctrl *ctrl;
>   	struct nvme_tcp_ofld_dev *dev;
>   	struct nvme_ctrl *nctrl;
> -	int rc = 0;
> +	int i, rc = 0;
>   
>   	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
>   	if (!ctrl)
>   		return ERR_PTR(-ENOMEM);
>   
> +	INIT_LIST_HEAD(&ctrl->list);
>   	nctrl = &ctrl->nctrl;
> +	nctrl->opts = opts;
> +	nctrl->queue_count = opts->nr_io_queues + opts->nr_write_queues +
> +			     opts->nr_poll_queues + 1;
> +	nctrl->sqsize = opts->queue_size - 1;
> +	nctrl->kato = opts->kato;
> +	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
> +		opts->trsvcid =
> +			kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
> +		if (!opts->trsvcid) {
> +			rc = -ENOMEM;
> +			goto out_free_ctrl;
> +		}
> +		opts->mask |= NVMF_OPT_TRSVCID;
> +	}
>   
> -	/* Init nvme_tcp_ofld_ctrl and nvme_ctrl params based on received opts */
> +	rc = inet_pton_with_scope(&init_net, AF_UNSPEC, opts->traddr,
> +				  opts->trsvcid,
> +				  &ctrl->conn_params.remote_ip_addr);
> +	if (rc) {
> +		pr_err("malformed address passed: %s:%s\n",
> +		       opts->traddr, opts->trsvcid);
> +		goto out_free_ctrl;
> +	}
> +
> +	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
> +		rc = inet_pton_with_scope(&init_net, AF_UNSPEC,
> +					  opts->host_traddr, NULL,
> +					  &ctrl->conn_params.local_ip_addr);
> +		if (rc) {
> +			pr_err("malformed src address passed: %s\n",
> +			       opts->host_traddr);
> +			goto out_free_ctrl;
> +		}
> +	}
> +
> +	if (!opts->duplicate_connect &&
> +	    nvme_tcp_ofld_existing_controller(opts)) {
> +		rc = -EALREADY;
> +		goto out_free_ctrl;
> +	}
>   
>   	/* Find device that can reach the dest addr */
>   	dev = nvme_tcp_ofld_lookup_dev(ctrl);
> @@ -160,6 +571,10 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
>   		goto out_free_ctrl;
>   	}
>   
> +	rc = nvme_tcp_ofld_check_dev_opts(opts, dev->ops);
> +	if (rc)
> +		goto out_module_put;
> +
>   	ctrl->dev = dev;
>   
>   	if (ctrl->dev->ops->max_hw_sectors)
> @@ -167,22 +582,58 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
>   	if (ctrl->dev->ops->max_segments)
>   		nctrl->max_segments = ctrl->dev->ops->max_segments;
>   
> -	/* Init queues */
> +	ctrl->queues = kcalloc(nctrl->queue_count,
> +			       sizeof(struct nvme_tcp_ofld_queue),
> +			       GFP_KERNEL);
> +	if (!ctrl->queues) {
> +		rc = -ENOMEM;
> +		goto out_module_put;
> +	}
> +
> +	for (i = 0; i < nctrl->queue_count; ++i) {
> +		queue = &ctrl->queues[i];
> +		queue->ctrl = ctrl;
> +		queue->dev = dev;
> +		queue->report_err = nvme_tcp_ofld_report_queue_err;
> +		queue->hdr_digest = nctrl->opts->hdr_digest;
> +		queue->data_digest = nctrl->opts->data_digest;
> +		queue->tos = nctrl->opts->tos;

Why is this here and not in the queue initialization?

> +	}
> +
> +	rc = nvme_init_ctrl(nctrl, ndev, &nvme_tcp_ofld_ctrl_ops, 0);
> +	if (rc)
> +		goto out_free_queues;
>   
> -	/* Call nvme_init_ctrl */
> +	if (!nvme_change_ctrl_state(nctrl, NVME_CTRL_CONNECTING)) {
> +		WARN_ON_ONCE(1);
> +		rc = -EINTR;
> +		goto out_uninit_ctrl;
> +	}
>   
>   	rc = ctrl->dev->ops->setup_ctrl(ctrl, true);
>   	if (rc)
> -		goto out_module_put;
> +		goto out_uninit_ctrl;
>   
>   	rc = nvme_tcp_ofld_setup_ctrl(nctrl, true);
>   	if (rc)
> -		goto out_uninit_ctrl;
> +		goto out_release_ctrl;

Its kinda confusing that a patch series adds code that is
replaced later in the series...

> +
> +	dev_info(nctrl->device, "new ctrl: NQN \"%s\", addr %pISp\n",
> +		 opts->subsysnqn, &ctrl->conn_params.remote_ip_addr);
> +
> +	down_write(&nvme_tcp_ofld_ctrl_rwsem);
> +	list_add_tail(&ctrl->list, &nvme_tcp_ofld_ctrl_list);
> +	up_write(&nvme_tcp_ofld_ctrl_rwsem);
>   
>   	return nctrl;
>   
> -out_uninit_ctrl:
> +out_release_ctrl:
>   	ctrl->dev->ops->release_ctrl(ctrl);
> +out_uninit_ctrl:
> +	nvme_uninit_ctrl(nctrl);
> +	nvme_put_ctrl(nctrl);
> +out_free_queues:
> +	kfree(ctrl->queues);
>   out_module_put:
>   	module_put(dev->ops->module);
>   out_free_ctrl:
> @@ -212,7 +663,15 @@ static int __init nvme_tcp_ofld_init_module(void)
>   
>   static void __exit nvme_tcp_ofld_cleanup_module(void)
>   {
> +	struct nvme_tcp_ofld_ctrl *ctrl;
> +
>   	nvmf_unregister_transport(&nvme_tcp_ofld_transport);
> +
> +	down_write(&nvme_tcp_ofld_ctrl_rwsem);
> +	list_for_each_entry(ctrl, &nvme_tcp_ofld_ctrl_list, list)
> +		nvme_delete_ctrl(&ctrl->nctrl);
> +	up_write(&nvme_tcp_ofld_ctrl_rwsem);
> +	flush_workqueue(nvme_delete_wq);
>   }
>   
>   module_init(nvme_tcp_ofld_init_module);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
