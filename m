Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DDAC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6730920734
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tFDCtRJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6730920734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lEg6GHCyTQGiwUD1H8KDgksewaiNnuIwMlhIr/JapZc=; b=tFDCtRJ71wtMSA6D98XCclLMO
	YVTJNF4AdTPmHQ3go+P/ZiPqRHoQVp+qFm1SoE8QNlQcSywV+0udx5Qhtk2x4HdGKWwj9HB/xS7xc
	JDz8JRG63cTQnV2c2VRY2lqTs1nGm1eNaNjBiRUuv283lBDpo+77haQeTqyQAOJkOoFgnPVNFxTFE
	TEsk0L1q7YdU1W/1m9kWc581YnPFbqF0r7EJMaa0mVKJktkPmOHDfgNVeuou9mefDC6j337dEEGDJ
	lBOp3Dc+o2qU3HuIgad1quI9lg5emF32L2R61Yk7vw81Tk6247pK/eY4yZrUXyybUMS3kN6uT16sr
	acYhwdmyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgami-0007nS-2w; Wed, 03 Jun 2020 21:18:52 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgame-0007mv-FJ
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 21:18:50 +0000
Received: by mail-pg1-f195.google.com with SMTP id d10so2544109pgn.4
 for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2020 14:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9LPjHSXhrGrJOG+fhiLiRJE+eM++yxRg1OoQJoN01OQ=;
 b=LGj8JUavGxRmDv2usC2oOF3VtKsZdMTSAr8ylXvdQeJaB5UMPvFyvzZ0zb6t78uF4F
 rD4SnOTeAbmL7bg2PxkZb+8qikoqdXg2kUuZh5amW2YB2c4/johMCu0m/7yBFZEn0Ldg
 ym8RpMkIEN5mh0QpAQgVoMhonrppi3NaV4rjhR4VngTRMfEwXCHfFkwaGiP1oCF8TPTW
 rV6TefRF+/GhA8pJvqblxb/vWnp+cdmdoeC5jIxvRgaOyQJxpcXxUKXPdRz+ROoXm41g
 mJP5yCO9eI6gWiLAoC2vWJ0SQc1q9qSSs3ggeZBLK1WK7ycCK6kZ3PHAdw77PUkwroH0
 81DQ==
X-Gm-Message-State: AOAM5336s6s3o16w+MAO4uta8iLqo8mxOj2eF/vdjBBVG/fDHg4uDAoW
 jJwZERh2vvIEy6Ps5NxeMOs=
X-Google-Smtp-Source: ABdhPJzUpnJ4sFe6B9DufLrWT9MXoIVZPfHA8QFNOKi5jYLmtgcebkK9X5OiVD3GTofEh9m5ntgqTQ==
X-Received: by 2002:a63:725d:: with SMTP id c29mr1223336pgn.243.1591219127731; 
 Wed, 03 Jun 2020 14:18:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5409:1488:6d95:bdff?
 ([2601:647:4802:9070:5409:1488:6d95:bdff])
 by smtp.gmail.com with ESMTPSA id q44sm3418372pja.29.2020.06.03.14.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 14:18:46 -0700 (PDT)
Subject: Re: [PATCH 1/5] nvme: introduce nvme-types header file
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com,
 chaitanya.kulkarni@wdc.com
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200602131546.51903-2-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fe6b0f20-6fc9-9e77-b943-6f122bed9870@grimberg.me>
Date: Wed, 3 Jun 2020 14:18:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602131546.51903-2-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_141848_518716_F4447944 
X-CRM114-Status: GOOD (  21.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 6/2/20 6:15 AM, Max Gurtovoy wrote:
> Centralize the mapping between name and type to a common header file
> instead of duplicating logic in both NVMe host and target drivers.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> ---
>   drivers/nvme/target/configfs.c | 92 ++++++++--------------------------------
>   drivers/nvme/target/nvmet.h    |  1 +
>   include/linux/nvme-types.h     | 95 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 113 insertions(+), 75 deletions(-)
>   create mode 100644 include/linux/nvme-types.h
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 419e0d4..daeb17e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -20,27 +20,6 @@
>   static LIST_HEAD(nvmet_ports_list);
>   struct list_head *nvmet_ports = &nvmet_ports_list;
>   
> -struct nvmet_type_name_map {
> -	u8		type;
> -	const char	*name;
> -};
> -
> -static struct nvmet_type_name_map nvmet_transport[] = {
> -	{ NVMF_TRTYPE_RDMA,	"rdma" },
> -	{ NVMF_TRTYPE_FC,	"fc" },
> -	{ NVMF_TRTYPE_TCP,	"tcp" },
> -	{ NVMF_TRTYPE_LOOP,	"loop" },
> -};
> -
> -static const struct nvmet_type_name_map nvmet_addr_family[] = {
> -	{ NVMF_ADDR_FAMILY_PCI,		"pcie" },
> -	{ NVMF_ADDR_FAMILY_IP4,		"ipv4" },
> -	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
> -	{ NVMF_ADDR_FAMILY_IB,		"ib" },
> -	{ NVMF_ADDR_FAMILY_FC,		"fc" },
> -	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
> -};
> -
>   static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
>   {
>   	if (p->enabled)
> @@ -56,14 +35,8 @@ static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
>   static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
>   {
>   	u8 adrfam = to_nvmet_port(item)->disc_addr.adrfam;
> -	int i;
> -
> -	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
> -		if (nvmet_addr_family[i].type == adrfam)
> -			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_adrfam_type_to_name(adrfam));
>   }
>   
>   static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
> @@ -75,8 +48,8 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
> -		if (sysfs_streq(page, nvmet_addr_family[i].name))
> +	for (i = 1; i < ARRAY_SIZE(nvme_addr_family); i++) {
> +		if (sysfs_streq(page, nvme_addr_family[i].name))
>   			goto found;
>   	}
>   
> @@ -84,7 +57,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> -	port->disc_addr.adrfam = nvmet_addr_family[i].type;
> +	port->disc_addr.adrfam = nvme_addr_family[i].type;
>   	return count;
>   }
>   
> @@ -148,24 +121,12 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_, addr_traddr);
>   
> -static const struct nvmet_type_name_map nvmet_addr_treq[] = {
> -	{ NVMF_TREQ_NOT_SPECIFIED,	"not specified" },
> -	{ NVMF_TREQ_REQUIRED,		"required" },
> -	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
> -};
> -
>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   {
>   	u8 treq = to_nvmet_port(item)->disc_addr.treq &
>   		NVME_TREQ_SECURE_CHANNEL_MASK;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> -		if (treq == nvmet_addr_treq[i].type)
> -			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_treq_type_to_name(treq));
>   }
>   
>   static ssize_t nvmet_addr_treq_store(struct config_item *item,
> @@ -178,8 +139,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> -		if (sysfs_streq(page, nvmet_addr_treq[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_addr_treq); i++) {
> +		if (sysfs_streq(page, nvme_addr_treq[i].name))
>   			goto found;
>   	}
>   
> @@ -187,7 +148,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> -	treq |= nvmet_addr_treq[i].type;
> +	treq |= nvme_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
>   }
> @@ -282,14 +243,9 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
>   		char *page)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
> -		if (port->disc_addr.trtype == nvmet_transport[i].type)
> -			return sprintf(page, "%s\n", nvmet_transport[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n",
> +		       nvme_trtype_to_name(port->disc_addr.trtype));
>   }
>   
>   static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
> @@ -308,8 +264,8 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   	if (nvmet_is_port_enabled(port, __func__))
>   		return -EACCES;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
> -		if (sysfs_streq(page, nvmet_transport[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
> +		if (sysfs_streq(page, nvme_transport[i].name))
>   			goto found;
>   	}
>   
> @@ -318,7 +274,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   
>   found:
>   	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
> -	port->disc_addr.trtype = nvmet_transport[i].type;
> +	port->disc_addr.trtype = nvme_transport[i].type;
>   	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
>   		nvmet_port_init_tsas_rdma(port);
>   	return count;
> @@ -1227,27 +1183,13 @@ static struct config_group *nvmet_referral_make(
>   	.ct_group_ops	= &nvmet_referral_group_ops,
>   };
>   
> -static struct nvmet_type_name_map nvmet_ana_state[] = {
> -	{ NVME_ANA_OPTIMIZED,		"optimized" },
> -	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
> -	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
> -	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
> -	{ NVME_ANA_CHANGE,		"change" },
> -};
> -
>   static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
>   		char *page)
>   {
>   	struct nvmet_ana_group *grp = to_ana_group(item);
>   	enum nvme_ana_state state = grp->port->ana_state[grp->grpid];
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
> -		if (state == nvmet_ana_state[i].type)
> -			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
> -	}
>   
> -	return sprintf(page, "\n");
> +	return sprintf(page, "%s\n", nvme_ana_type_to_name(state));
>   }
>   
>   static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
> @@ -1257,8 +1199,8 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
>   	enum nvme_ana_state *ana_state = grp->port->ana_state;
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
> -		if (sysfs_streq(page, nvmet_ana_state[i].name))
> +	for (i = 0; i < ARRAY_SIZE(nvme_ana_states); i++) {
> +		if (sysfs_streq(page, nvme_ana_states[i].name))
>   			goto found;
>   	}
>   
> @@ -1267,7 +1209,7 @@ static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
>   
>   found:
>   	down_write(&nvmet_ana_sem);
> -	ana_state[grp->grpid] = (enum nvme_ana_state) nvmet_ana_state[i].type;
> +	ana_state[grp->grpid] = (enum nvme_ana_state) nvme_ana_states[i].type;
>   	nvmet_ana_chgcnt++;
>   	up_write(&nvmet_ana_sem);
>   	nvmet_port_send_ana_event(grp->port);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 8096912..ce57d5f 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -15,6 +15,7 @@
>   #include <linux/mutex.h>
>   #include <linux/uuid.h>
>   #include <linux/nvme.h>
> +#include <linux/nvme-types.h>
>   #include <linux/configfs.h>
>   #include <linux/rcupdate.h>
>   #include <linux/blkdev.h>
> diff --git a/include/linux/nvme-types.h b/include/linux/nvme-types.h
> new file mode 100644
> index 0000000..38ed980
> --- /dev/null
> +++ b/include/linux/nvme-types.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
> + */
> +
> +#ifndef _LINUX_NVME_TYPES_H
> +#define _LINUX_NVME_TYPES_H
> +
> +#include <linux/kernel.h>
> +#include <linux/nvme.h>
> +
> +struct nvme_type_name_map {
> +	u8		type;
> +	const char	*name;
> +};
> +
> +static const struct nvme_type_name_map nvme_transport[] = {
> +	{ NVMF_TRTYPE_RDMA,	"rdma" },
> +	{ NVMF_TRTYPE_FC,	"fc" },
> +	{ NVMF_TRTYPE_TCP,	"tcp" },
> +	{ NVMF_TRTYPE_LOOP,	"loop" },
> +};
> +
> +static inline const char *nvme_trtype_to_name(u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_transport); i++) {
> +		if (type == nvme_transport[i].type)
> +			return nvme_transport[i].name;
> +	}
> +
> +	return "invalid";

Why does this need a loop?

maybe just:
	return (type < ARRAY_SIZE(nvme_transport) && nvme_transport[type]) ? 
nvme_transport[i].name : "invalid";

Same for the rest...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
