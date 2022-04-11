Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA573C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gOjvtph7GqO22uqTjEYojWyb15BMfJwEColw6H2t1wA=; b=lVOHxRFTM6TvnRvPn3Dt3Vt73a
	mfpRUzp78q8dNaMMmkvNz77ogfPE8LrGCVW0KGl3VW4vIfbP2v/29Y+7cGVAnOMlOtKoddaDdhxg8
	989T1a3bE213nLAHgYLorjRyESc7S9F/e8wHKX1+cNCeKwtgrwKbmFGjBXzCnu/P+bT45xELh/5C4
	EOsdvdJWuGVb0DRCXIPWf2FkFdn9Cj/4OXU/hByDBhPf1AWaKniapIpnSgFqnCSDPtgTbL0zDRDj6
	qvutjZCYKWyjYl3TMb8g/eKQw0B4MMs9cwpxxRn/atCorct5zdvARYwbVdcPDzUXT0W90xxxH/aUS
	FXtwcVaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrYT-008T2v-U3; Mon, 11 Apr 2022 10:45:58 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrXw-008SeC-4g
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:45:26 +0000
Received: by mail-wr1-f52.google.com with SMTP id i20so9258419wrb.13
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gOjvtph7GqO22uqTjEYojWyb15BMfJwEColw6H2t1wA=;
 b=Y7Hbl87jDh2D+9uwnHOCsRxQFTCH6zNohXXZqGVq3QV041F/0DHPRzAB0gnvZHPXmD
 wdJ1OE+4H6ztlF4Bvii37ELlzigfsEvr6+ncepn6rrvXQ6DaPTR5iaZAfMnhSW+pOR7k
 l2Ipitsw2cEYSjtIMxL8cQGDcOOHawxt7GHbES0jpHEYgsjk4t/OxVaUew5NEKRwLTS6
 /wzrgLhqaZc9Dp13qW5W+IxzXqAVQJbsKRchTEVfgWhGv1kd/MiBrszK6tAPrErp4zvX
 cQCvYCPV72w8/LyyC3m/SyKg9S678S0iGvhSDjg60yo/Eqs2Mn/Awof6iMYQEAo4XKOe
 /LpQ==
X-Gm-Message-State: AOAM530bUKvuCF4DScmLUAiLSWbcoxLvL7auep5aaeulJgRXTp/Sw+1y
 R2AMvftE3tbQ3VvwoKQhpI6Z9xdcaFM=
X-Google-Smtp-Source: ABdhPJxtGY6FwvtrrXktNWQJ8P4l/UFR5IXjhUM9bxlnzSYpNw5a+E4ZW8fE1FQ9sGNDHM1y+fTTVw==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id
 a3-20020a056000188300b00205c0cb33c6mr25235202wri.39.1649673921237; 
 Mon, 11 Apr 2022 03:45:21 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r12-20020a5d6c6c000000b00203ec2b1255sm32634709wrz.60.2022.04.11.03.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:45:20 -0700 (PDT)
Message-ID: <4a9ccecc-a382-e467-30d9-c06adf0e5329@grimberg.me>
Date: Mon, 11 Apr 2022 13:45:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvmet: per-port discovery subsystem
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220408065930.123015-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_034524_282138_944273CA 
X-CRM114-Status: GOOD (  28.32  )
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


> Add a 'disc_subsys' pointer to each port to specify which discovery
> subsystem to use.
> The pointer is set when a discovery subsystem is linked into a port,
> and reset if that link is removed.

Why not make discovery_subsystems/ subdir in a port? We can restrict
it to have only one element if needed.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c  | 10 +++++++++
>   drivers/nvme/target/core.c      | 15 ++++++++++---
>   drivers/nvme/target/discovery.c | 39 ++++++++++++++++++++++-----------
>   drivers/nvme/target/nvmet.h     |  1 +
>   4 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 38b0ab9fb721..44573fe0dfe4 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   	link->subsys = subsys;
>   
>   	down_write(&nvmet_config_sem);
> +	if (subsys->type == NVME_NQN_CURR &&
> +	    port->disc_subsys) {

The CURR is really confusing to me...
Can you explain the NQN types mapping here?

> +		pr_err("discovery subsystem already present\n");
> +		ret = -EAGAIN;
> +		goto out_free_link;
> +	}
>   	ret = -EEXIST;
>   	list_for_each_entry(p, &port->subsystems, entry) {
>   		if (p->subsys == subsys)
> @@ -835,6 +841,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
>   
>   	list_add_tail(&link->entry, &port->subsystems);
>   	subsys->port_count++;
> +	if (subsys->type == NVME_NQN_CURR)
> +		port->disc_subsys = subsys;
>   	nvmet_port_disc_changed(port, subsys);
>   
>   	up_write(&nvmet_config_sem);
> @@ -866,6 +874,8 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
>   	subsys->port_count--;
>   	nvmet_port_del_ctrls(port, subsys);
>   	nvmet_port_disc_changed(port, subsys);
> +	if (port->disc_subsys == subsys)
> +		port->disc_subsys = NULL;
>   
>   	if (list_empty(&port->subsystems))
>   		nvmet_disable_port(port);
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 90e75324dae0..afd80999a335 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1495,10 +1495,19 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>   	if (!port)
>   		return NULL;
>   
> +	/*
> +	 * As per spec discovery subsystems with a unique NQN
> +	 * have to respond to both NQNs, the unique NQN and the
> +	 * standard discovery NQN.
> +	 */
>   	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
> -		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
> -			return NULL;
> -		return nvmet_disc_subsys;
> +		struct nvmet_subsys *disc_subsys;
> +
> +		disc_subsys = port->disc_subsys ?
> +			port->disc_subsys : nvmet_disc_subsys;
> +		if (!kref_get_unless_zero(&disc_subsys->ref))
> +				return NULL;
> +		return disc_subsys;
>   	}

Why use the port discovery subsys? why not just use the standard
discovery subsys?

>   
>   	down_read(&nvmet_config_sem);
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index b5012df790d5..6b8aa6c4e752 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -29,18 +29,22 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>   			     struct nvmet_subsys *subsys)
>   {
>   	struct nvmet_ctrl *ctrl;
> +	struct nvmet_subsys *disc_subsys;
>   
>   	lockdep_assert_held(&nvmet_config_sem);
>   	nvmet_genctr++;
>   
> -	mutex_lock(&nvmet_disc_subsys->lock);
> -	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
> +	disc_subsys = port->disc_subsys ?
> +		port->disc_subsys : nvmet_disc_subsys;
> +
> +	mutex_lock(&disc_subsys->lock);
> +	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>   		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
>   			continue;
>   
>   		__nvmet_disc_changed(port, ctrl);
>   	}
> -	mutex_unlock(&nvmet_disc_subsys->lock);
> +	mutex_unlock(&disc_subsys->lock);
>   
>   	/* If transport can signal change, notify transport */
>   	if (port->tr_ops && port->tr_ops->discovery_chg)
> @@ -48,19 +52,23 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>   }
>   
>   static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
> -					struct nvmet_subsys *subsys,
>   					struct nvmet_host *host)
>   {
>   	struct nvmet_ctrl *ctrl;
> +	struct nvmet_subsys *disc_subsys;
> +
> +	disc_subsys = port->disc_subsys ?
> +		port->disc_subsys : nvmet_disc_subsys;
>   
> -	mutex_lock(&nvmet_disc_subsys->lock);
> -	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
> +	mutex_lock(&disc_subsys->lock);
> +
> +	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
>   		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
>   			continue;
>   
>   		__nvmet_disc_changed(port, ctrl);
>   	}
> -	mutex_unlock(&nvmet_disc_subsys->lock);
> +	mutex_unlock(&disc_subsys->lock);

Why remove the subsys argument from this function?

>   }
>   
>   void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
> @@ -76,7 +84,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>   		list_for_each_entry(s, &port->subsystems, entry) {
>   			if (s->subsys != subsys)
>   				continue;
> -			__nvmet_subsys_disc_changed(port, subsys, host);
> +			__nvmet_subsys_disc_changed(port, host);
>   		}
>   }
>   
> @@ -146,7 +154,10 @@ static size_t discovery_log_entries(struct nvmet_req *req)
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	struct nvmet_subsys_link *p;
>   	struct nvmet_port *r;
> -	size_t entries = 1;
> +	size_t entries = 0;
> +
> +	if (!req->port->disc_subsys)
> +		entries++;
>   
>   	list_for_each_entry(p, &req->port->subsystems, entry) {
>   		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> @@ -208,10 +219,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
>   
>   	nvmet_set_disc_traddr(req, req->port, traddr);
>   
> -	nvmet_format_discovery_entry(hdr, req->port,
> -				     nvmet_disc_subsys->subsysnqn,
> -				     traddr, NVME_NQN_CURR, numrec);
> -	numrec++;
> +	if (!req->port->disc_subsys) {
> +		nvmet_format_discovery_entry(hdr, req->port,
> +				nvmet_disc_subsys->subsysnqn,
> +				traddr, NVME_NQN_CURR, numrec);
> +		numrec++;
> +	}

For the unique discovery you don't need this?

>   
>   	list_for_each_entry(p, &req->port->subsystems, entry) {
>   		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index ecba3890ce65..8df297a190bf 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -144,6 +144,7 @@ struct nvmet_port {
>   	struct list_head		global_entry;
>   	struct config_group		ana_groups_group;
>   	struct nvmet_ana_group		ana_default_group;
> +	struct nvmet_subsys		*disc_subsys;
>   	enum nvme_ana_state		*ana_state;
>   	void				*priv;
>   	bool				enabled;

