Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E670C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xWEjigGs5wR27M2jJfq1ZTHnii5PNzptot/fvkr9nDA=; b=EdqpTnayRLZIgkTrKr3oB7t9E/
	GneId1TQCAadewbLEi7IbKkfkhEhwTJefpW6UzFKjQBIvFt6nAJMiJUh/xz0rKMiLD73RVqAqVp/e
	1fxD8dzFA9HOqZnd2vKjulnY3FmfPWrnatGUIA2dWZU9xOnkyjlqEhkw0cKIm8mKRNHIc3ckIAuiM
	sQ7jWk0rE/mQmvLhVPB6jvPe1BUnKjeD8KmBXGESKoKn+jWMwCNhZJZi4G7TnWNBCmSmFSE7cC/NF
	MYcnmDFRVMnAMM+1pqb+YLdABCudmuMppc7OpuQ3TxrZua3A+hl7VVVnGE19Q2SVXLMe8XDWiRYSZ
	G++ECjqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDKA-0000000F8iR-3TA5;
	Wed, 17 Jul 2024 22:40:38 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDK8-0000000F8hx-2Drl
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:40:37 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4279dadb7b1so260525e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256035; x=1721860835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWEjigGs5wR27M2jJfq1ZTHnii5PNzptot/fvkr9nDA=;
        b=gLRO0KRLG2Zfc1Hku8wcTOjzHBQJeU1ihNnsqWZXzWakEXHKoqPLe4YKH68zkc2xR9
         fU9kIgNRqWVKOZfKdqowud74qMBIAMZydQ7aKM6frz+HP2oxE3cxJFJu6mOxZ8qLUqTG
         eRpqd1RmqdIEQBcrTiUm5bIMy/tXuQbp36Qho0FevW377szY5ZvjiWS/+6c2e3fWlBjs
         w6l22S/cU52Dd6eCwqIIc+6IHyJL/u/b9/jpx3CRN+bKPI2w+VCLzOa9DtKlNNk/V5MI
         Q4tZ2ztiePhRgEDbbA/U3xYuhSFB7lD8yFx42Ru8ISV7gcgFimNlUBEVfynDArjHDHNM
         C/pw==
X-Forwarded-Encrypted: i=1; AJvYcCVDw10sg29hd8y8poQ6IO4/kEqh+s3NHZvrf2OMzG/PCuvXRh4Epks0CrP/Vdg6dRIsv+huDQrOaomvaj9EO1OYfi/6k/oj+1ZuSUIy5Ws=
X-Gm-Message-State: AOJu0Yy/q26U10ZxP39HH6iLekLBablXV9FEEf0OGlye9CjKrRR0sb/h
	WjLaJKM4QAHRcOcu4rGLJnaXWyuHOMH6OACQIwJfjubsv1VdV3EL
X-Google-Smtp-Source: AGHT+IH/v1iZpOqnCfGFMDVChSWKdsA7FPQgtI90y6xYItK8p41F9L1wB/ofA9Ay/uXa26mxY4/iNw==
X-Received: by 2002:a05:6000:1543:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-368315f93cfmr1507332f8f.2.1721256034806;
        Wed, 17 Jul 2024 15:40:34 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db048a8sm12671833f8f.111.2024.07.17.15.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:40:34 -0700 (PDT)
Message-ID: <1b59c7c9-5d20-4d96-b844-88014cdaa14e@grimberg.me>
Date: Thu, 18 Jul 2024 01:40:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: Implement 'admin_only' authentication
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240717110338.27332-1-hare@kernel.org>
 <20240717110338.27332-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717110338.27332-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_154036_613325_3CEE9B80 
X-CRM114-Status: GOOD (  23.96  )
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



On 17/07/2024 14:03, Hannes Reinecke wrote:
> It might be sufficient to run authentication on the admin queue only,
> as this speeds up reconnection quite significantly.

By how much?

>   So add a configfs
> attribute 'dhchap_admin_only' for the 'host' configfs entry to enable
> this mode.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/target/auth.c             | 11 +++++++----
>   drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
>   drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
>   drivers/nvme/target/fabrics-cmd.c      |  7 +++++--
>   drivers/nvme/target/nvmet.h            |  2 ++
>   5 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 560321df5bf6..d5aae8d8cc92 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -189,6 +189,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   		ctrl->shash_id = host->dhchap_hash_id;
>   	}
>   
> +	ctrl->dh_admin_only = host->dhchap_admin_only;
> +
>   	/* Skip the 'DHHC-1:XX:' prefix */
>   	nvme_auth_free_key(ctrl->host_key);
>   	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
> @@ -279,10 +281,11 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
>   
>   bool nvmet_check_auth_status(struct nvmet_req *req)
>   {
> -	if (req->sq->ctrl->host_key &&
> -	    !req->sq->authenticated)
> -		return false;
> -	return true;
> +	if (!req->sq->ctrl->host_key)
> +		return true;
> +	if (req->sq->qid && req->sq->ctrl->dh_admin_only)
> +		return true;
> +	return req->sq->authenticated;
>   }
>   
>   int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index bd87dfd173a4..807b0904ea88 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2134,11 +2134,34 @@ static ssize_t nvmet_host_dhchap_dhgroup_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
>   
> +static ssize_t nvmet_host_dhchap_admin_only_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_host *host = to_host(item);
> +
> +	return sprintf(page, "%d\n", host->dhchap_admin_only);
> +}
> +
> +static ssize_t nvmet_host_dhchap_admin_only_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_host *host = to_host(item);
> +	bool val;
> +
> +	if (kstrtobool(page, &val))
> +		return -EINVAL;
> +	host->dhchap_admin_only = val;
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(nvmet_host_, dhchap_admin_only);
> +
>   static struct configfs_attribute *nvmet_host_attrs[] = {
>   	&nvmet_host_attr_dhchap_key,
>   	&nvmet_host_attr_dhchap_ctrl_key,
>   	&nvmet_host_attr_dhchap_hash,
>   	&nvmet_host_attr_dhchap_dhgroup,
> +	&nvmet_host_attr_dhchap_admin_only,
>   	NULL,
>   };
>   #endif /* CONFIG_NVME_TARGET_AUTH */
> @@ -2178,6 +2201,7 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
>   #ifdef CONFIG_NVME_TARGET_AUTH
>   	/* Default to SHA256 */
>   	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
> +	host->dhchap_admin_only = false;
>   #endif
>   
>   	config_group_init_type_name(&host->group, name, &nvmet_host_type);
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 4c392488c451..4af10a78ce69 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -62,6 +62,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
>   			return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
>   		}
>   		ctrl->concat = true;
> +		ctrl->dh_admin_only = true;
>   	}
>   
>   	if (data->napd != 1)
> @@ -248,6 +249,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   			offsetof(struct nvmf_auth_send_command, tl);
>   		goto done;
>   	}
> +	if (req->sq->qid && ctrl->dh_admin_only) {
> +		pr_debug("%s: ctrl %d qid %d reject authentication on I/O queues\n",
> +			 __func__, ctrl->cntlid, req->sq->qid);
> +		status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
> +		goto done;
> +	}
>   	if (!nvmet_check_transfer_len(req, tl)) {
>   		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
>   		return;
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 1aabf55ef0a8..212fe271c8a4 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -203,8 +203,11 @@ static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   {
>   	bool needs_auth = nvmet_has_auth(ctrl, req);
>   
> -	/* Do not authenticate I/O queues for secure concatenation */
> -	if (ctrl->concat && req->sq->qid)
> +	/*
> +	 * Do not request authentication for I/O queues for secure concatenation
> +	 * or when only the admin queue should be authenticated.
> +	 */
> +	if (req->sq->qid && (ctrl->concat || ctrl->dh_admin_only))
>   		needs_auth = false;
>   
>   	pr_debug("%s: ctrl %d qid %d should %sauthenticate, tls psk %08x\n",
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 9486b43ab822..129b1cb8a4d1 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -249,6 +249,7 @@ struct nvmet_ctrl {
>   	u8			dh_gid;
>   	u8			*dh_key;
>   	size_t			dh_keysize;
> +	bool			dh_admin_only;
>   #endif
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>   	struct key		*tls_key;
> @@ -325,6 +326,7 @@ struct nvmet_host {
>   	u8			dhchap_ctrl_key_hash;
>   	u8			dhchap_hash_id;
>   	u8			dhchap_dhgroup_id;
> +	bool			dhchap_admin_only;
>   };
>   
>   static inline struct nvmet_host *to_host(struct config_item *item)


