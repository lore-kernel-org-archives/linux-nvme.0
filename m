Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D017CC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGXwSfFSNgvLrJkj6RKuqw4rnFDvPVNmYpZaqgw3taU=; b=DuYkfYhu7KFafhdkNioytIh2Zd
	FTvkJFJNAEOcmi+uwlp9DS1Z1Bg10gWvIdWzjinpEipwVOtUGMd8i7GBvN7NGhjo0SE9/3VTkfNoc
	afEhDCzrXaTV5nVwe2/fwsK7Zpz/coCkq4iCqhTlSy9Ok2dEGNPyBCwE1xcVqa6OCyH01UmiQ6gFG
	ikoLqxcQyejrOIEnmUwS6kPI9Kgy/ibTXHmJGEoXyNHl+vCwsVbDpv7qT66x4FoTzpbfW7B1x1oJ7
	pwMj1r7y2Jcz7r0Av7T89+WVT9HQk5cf5vxJSi/LFBqzeacVWSYOuQpaO3oLtNdueO2I7sMHNKnqr
	frT8h3cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFk3-0000000AkQR-3yKs;
	Thu, 03 Jul 2025 08:56:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFig-0000000Ak9s-2m7J
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 08:55:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C035A1F786;
	Thu,  3 Jul 2025 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751532900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGXwSfFSNgvLrJkj6RKuqw4rnFDvPVNmYpZaqgw3taU=;
	b=GWTK72wtNFswiBm1KL1ILP7GtHplB0TRkHnHp7E7MqH2y5oPw0Vckn7KUD5Lo82MtHOsrP
	y2T1PJH0P9HXJJipkmA4THl2bZ9zDJHwCU3SOMeX2siwWYUDKn9feQe4CUeWaHWjSlumBx
	d9qYJFjNsz1mV3/4wVNqFmM5D1QjwKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751532900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGXwSfFSNgvLrJkj6RKuqw4rnFDvPVNmYpZaqgw3taU=;
	b=MgBgredCc5sks1rrW8D0gfIA9mC4H8ekCrtBU8JA4zfYwMnD9x4nDEY3iCiUfr2V79nt8I
	JpjV7vab/4rya0BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751532900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGXwSfFSNgvLrJkj6RKuqw4rnFDvPVNmYpZaqgw3taU=;
	b=GWTK72wtNFswiBm1KL1ILP7GtHplB0TRkHnHp7E7MqH2y5oPw0Vckn7KUD5Lo82MtHOsrP
	y2T1PJH0P9HXJJipkmA4THl2bZ9zDJHwCU3SOMeX2siwWYUDKn9feQe4CUeWaHWjSlumBx
	d9qYJFjNsz1mV3/4wVNqFmM5D1QjwKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751532900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGXwSfFSNgvLrJkj6RKuqw4rnFDvPVNmYpZaqgw3taU=;
	b=MgBgredCc5sks1rrW8D0gfIA9mC4H8ekCrtBU8JA4zfYwMnD9x4nDEY3iCiUfr2V79nt8I
	JpjV7vab/4rya0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19FC1368E;
	Thu,  3 Jul 2025 08:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SzQGJ2RFZmiydQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 08:55:00 +0000
Message-ID: <d19a0776-5c3c-46f8-82ad-a1a83d5af884@suse.de>
Date: Thu, 3 Jul 2025 10:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nvme: add capability to connect to an admin
 controller
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250702005830.889217-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_015502_850293_F00CF326 
X-CRM114-Status: GOOD (  21.71  )
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

On 7/2/25 02:58, Kamaljit Singh wrote:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 
> Add capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.
> 
> * Add helper nvme_admin_ctrl() to check for an administrative controller
> * Add helper nvme_override_prohibited_io_queues() to override
>    queue_count in nvme_ctrl
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>   drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c |  2 ++
>   drivers/nvme/host/tcp.c  |  2 ++
>   4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e533d791955d..a1155fb8d5be 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3149,6 +3149,22 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
>   	return ctrl->opts && ctrl->opts->discovery_nqn;
>   }
>   
> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->cntrltype == NVME_CTRL_ADMIN);
> +}
> +
> +/*
> + * An admin controller has one admin queue, but no I/O queues.
> + * Override queue_count so it only creates an admin queue.
> + */
> +void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_admin_ctrl(ctrl))
> +		ctrl->queue_count = 1;
> +}
> +EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);
> +
>   static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>   		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   {
> @@ -3215,6 +3231,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		kfree(subsys);
>   		return -EINVAL;
>   	}
> +	if (nvme_admin_ctrl(ctrl))
> +		dev_info(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			subsys->subnqn);
> +

Bzzt. A subsystem is a subsystem, a controller is a controller.
Better issue a message when connecting the controller.

>   	nvme_mpath_default_iopolicy(subsys);
>   
>   	subsys->dev.class = &nvme_subsys_class;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7df2ea21851f..5e07ba634e97 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1212,6 +1212,7 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
>   struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
>   bool nvme_get_ns(struct nvme_ns *ns);
>   void nvme_put_ns(struct nvme_ns *ns);
> +void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl);
>   
>   static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
>   {
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9bd3646568d0..7d50a2f31c3a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1026,6 +1026,8 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   		goto destroy_admin;
>   	}
>   
> +	nvme_override_prohibited_io_queues(&ctrl->ctrl);
> +
>   	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
>   		dev_warn(ctrl->ctrl.device,
>   			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d924008c3949..bfb52a487c45 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2381,6 +2381,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		goto destroy_admin;
>   	}
>   
> +	nvme_override_prohibited_io_queues(ctrl);
> +
>   	if (opts->queue_size > ctrl->sqsize + 1)
>   		dev_warn(ctrl->device,
>   			"queue_size %zu > ctrl sqsize %u, clamping down\n",

And that is a bit convoluted.

Why not add a check in 'nvme_set_queue_count' and reduce the number of
queues to '1' there?

(Then you also have a place to put your message about the admin
controller ...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

