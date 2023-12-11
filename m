Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BBDC10F05
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92yOTtIWSiuO5GjYl8OhndPI60c1XT8wi+EoHUgOj2I=; b=jxKQKTvjMfKnYBt+wnplgXyYPR
	1guMOaJxE8Yn2QIny5ygSMnbsrXPRLIXlPsUXPr3kt8CwbUhSetIsSka0F+Y22jRar+EMFUsJ+/xl
	wEpIcqjEC3bz8nH8tkgxYxiY7tdtykN5EAw1+yvSsr7+PJQ0gHWna55M7ybWbU/SFHfrYThddx+o0
	KwKYM5J//zjNxyZ++o4M5OHUu0Zaib1e9nOVIr2+QWaBjEHbw6Hz4aqIYoXIqwP2dJ9eDXq70Vlkr
	Pg4Pm+zWTcKgaV1OQ28Oqf3kjGGj2/xoAdaPHPcGzAfE2wY90PYjIA4CILsOBsX3ljbQzoWemxKi/
	b3tX0/1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCh4D-0058sU-1g;
	Mon, 11 Dec 2023 14:15:30 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCh43-0058pI-0B
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:15:21 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54cd1274c42so1270377a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 11 Dec 2023 06:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304117; x=1702908917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92yOTtIWSiuO5GjYl8OhndPI60c1XT8wi+EoHUgOj2I=;
        b=e8i60Lde0l8nxljayc/FbyO3DRHi8xflmZUYwDOMUBHwkgeyBJIN7Qn9a+Lrds5GBC
         3nzaZ++lH3yNXR8HBvqBiTI0tQBA8lqF4KZR/87LO7U2AtuCpXhwxUQeV1ELVBQQYd3w
         augnpbTknn4zjyLBd1ymYllhDe1Ju2xdZ92J3pkTowvf1vZ46rNvNOHpbdFBSWFBeJ7b
         yOE29Fu8VVw/VuFCVsFuhGUVRghSagadP9SY5l9LR2uHCPyxyr3wKx2y1geb84U9mokQ
         pfoBSPmk/nSgPZj/YCGhGjl4SzNPP/pQcO0lsvTMYnFtfErj899KaHMmxvWGvJNEqBoT
         cfDw==
X-Gm-Message-State: AOJu0Yzvq4DYvIh5NjL8cgr3F7y6cQB2ZFpE+NWjFzHf0gkBsS/GBed5
	aOVzT7+5MWlnMiee0DNzky/aGD+v0o4=
X-Google-Smtp-Source: AGHT+IFwKfwhm355JqjXM2hf5vCtQHvlxPuL4epwVL51iclj/OIfi/ihp+R7owVfr0Sj8hhkWrRFcA==
X-Received: by 2002:a17:907:d404:b0:a01:b8e5:d4b7 with SMTP id vi4-20020a170907d40400b00a01b8e5d4b7mr3928384ejc.1.1702304116940;
        Mon, 11 Dec 2023 06:15:16 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id vb2-20020a170907d04200b00a1f72df5617sm4444504ejc.141.2023.12.11.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 06:15:16 -0800 (PST)
Message-ID: <f7a25a88-a928-40f2-ba52-3c74356e58cd@grimberg.me>
Date: Mon, 11 Dec 2023 16:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: implement unique discovery NQN
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20231211081033.14529-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231211081033.14529-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

So it also responds for the default discovery-nqn?

On 12/11/23 10:10, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
> directory to specify the unique discovery NQN.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 45 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c     |  7 ++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index d937fe05129e..88911d0cd057 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1587,6 +1587,11 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> +	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
> +		pr_err("can't create subsystem using unique discovery NQN\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
>   	if (IS_ERR(subsys))
>   		return ERR_CAST(subsys);
> @@ -2131,7 +2136,47 @@ static const struct config_item_type nvmet_hosts_type = {
>   
>   static struct config_group nvmet_hosts_group;
>   
> +static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
> +					     char *page)
> +{
> +	return sprintf(page, "%s\n", nvmet_disc_subsys->subsysnqn);
> +}
> +
> +static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	size_t len;
> +	struct list_head *entry;
> +
> +	len = strcspn(page, "\n");
> +	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
> +		struct config_item *item = container_of(entry, struct config_item, ci_entry);
> +		if (!strncmp(config_item_name(item), page, len)) {
> +			pr_err("duplicate NQN %s\n", config_item_name(item));
> +			up_write(&nvmet_config_sem);
> +			return -EINVAL;
> +		}
> +	}
> +	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
> +	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
> +	up_write(&nvmet_config_sem);
> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR(nvmet_root_, discovery_nqn);
> +
> +static struct configfs_attribute *nvmet_root_attrs[] = {
> +	&nvmet_root_attr_discovery_nqn,
> +	NULL,
> +};
> +
>   static const struct config_item_type nvmet_root_type = {
> +	.ct_attrs		= nvmet_root_attrs,
>   	.ct_owner		= THIS_MODULE,
>   };
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..9c028bbedb45 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1530,6 +1530,13 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>   	}
>   
>   	down_read(&nvmet_config_sem);
> +	if (!strncmp(nvmet_disc_subsys->subsysnqn, subsysnqn,
> +				NVMF_NQN_SIZE)) {
> +		if (kref_get_unless_zero(&nvmet_disc_subsys->ref)) {
> +			up_read(&nvmet_config_sem);
> +			return nvmet_disc_subsys;
> +		}
> +	}
>   	list_for_each_entry(p, &port->subsystems, entry) {
>   		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
>   				NVMF_NQN_SIZE)) {

