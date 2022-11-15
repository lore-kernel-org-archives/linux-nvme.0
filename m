Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE2CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BS3Be73morCICtMa2pivxqZXOf3xamruKDDqQBlnhG4=; b=pHIsxXvrKWcb4q2XrAbXDIEsQ/
	sGOugxxLsd2Ej/DCcVAlDN+bhvGItUZyVn22QATJLMoPIW1tZ8WBw9kQvaAqqyHpNbxThsXMu8JXC
	jOMbyJXrEGISBVxZ1DtU4jAns51Ua+4oyMU0v70juruL27AAHi9ywspmD3hw8KulGsnXs+FCFi5UJ
	Lnlk8vo78TwimRNKaxaS/ru6JbcYaGk3OsKaErm7rxi6dH8Tw+HHtKZaJFgDTsuTFFw+vT8swlBn3
	JnLKdAk/m/99m9DeG+CIUhoLeG/J4v2Qz2dEIIduGduZEw94O0bZ+GeiEClaoAi+E4h9e0FjpbNF3
	JlYKZLXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwZ3-00Bkj7-OG; Tue, 15 Nov 2022 14:05:25 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouwYx-00Bkf6-LW
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 14:05:24 +0000
Received: by mail-wr1-f46.google.com with SMTP id w14so24431857wru.8
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 06:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BS3Be73morCICtMa2pivxqZXOf3xamruKDDqQBlnhG4=;
        b=pOxA1QTosYaIWobl6Did2XEAqEVCnghL72x7osYbdBdyyoSzQyCcIQjnsUJOSYc1N5
         t0VTH16q+jsk0y1sRbfO/DeAGtJ9b9mY8JsZfCaVFWjrw402TFfDxI51BK3uUw8corK7
         BNEtqDe865wp/e9gYedSeGkADglHzpiNppSjOYggaGJp0iFST3Q3odv67nFKCKuBBF1D
         mM6obCe16gY8nB1r8h016EdF4DLQlrJbJ/wWATZg9Xo8wYzv3OzQPKiESp/b+8B3FVww
         Lx9RChlWVjZFaeSebhwycj+8ne2+EK5F2PcAvN1Ba44RfC0VJO5oF/+eWdc3aOsr0XhI
         Bi8A==
X-Gm-Message-State: ANoB5plrJZ5ANFKfAc5LJTZLuNX5zJu21oH9Yaun2qoCdbRRemfkC/id
	6KqgK51Ig74slo/j/nJpZQI=
X-Google-Smtp-Source: AA0mqf5p7w9mJOBoBLjAX+mp10ICRTHu0JYzvJ3FBUsFw/8qR+5YNFzpa4wrwzgBDJ0S1i89VDit7g==
X-Received: by 2002:adf:ee83:0:b0:236:e06b:ec12 with SMTP id b3-20020adfee83000000b00236e06bec12mr10657818wro.69.1668521116658;
        Tue, 15 Nov 2022 06:05:16 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b0022cbf4cda62sm14948805wra.27.2022.11.15.06.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:05:16 -0800 (PST)
Message-ID: <1243d214-e399-237f-e70d-bb4541a66b28@grimberg.me>
Date: Tue, 15 Nov 2022 16:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] nvmet: expose IEEE OUI to configfs
Content-Language: en-US
To: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux@yadro.com,
 Konstantin Shelekhin <k.shelekhin@yadro.com>,
 Dmitriy Bogdanov <d.bogdanov@yadro.com>
References: <20221115115810.75848-1-a.miloserdov@yadro.com>
 <20221115115810.75848-2-a.miloserdov@yadro.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221115115810.75848-2-a.miloserdov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_060519_740668_3B754CB5 
X-CRM114-Status: GOOD (  24.49  )
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


> Allow user to set OUI for the controller vendor.
> 
> Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
> Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
> Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  7 ++---
>   drivers/nvme/target/configfs.c  | 49 +++++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      |  2 ++
>   drivers/nvme/target/nvmet.h     |  1 +
>   4 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index c8a061ce3ee5..48a2f587f38a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -372,6 +372,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	memcpy_and_pad(id->fr, sizeof(id->fr),
>   		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>   
> +	put_unaligned_le24(subsys->ieee_oui, id->ieee);
> +

Any particular reason why it is placed here and not where the comment
was?

>   	id->rab = 6;
>   
>   	if (nvmet_is_disc_subsys(ctrl->subsys))
> @@ -379,11 +381,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	else
>   		id->cntrltype = NVME_CTRL_IO;
>   
> -	/*
> -	 * XXX: figure out how we can assign a IEEE OUI, but until then
> -	 * the safest is to leave it as zeroes.
> -	 */
> -
>   	/* we support multiple ports, multiples hosts and ANA: */
>   	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
>   		NVME_CTRL_CMIC_ANA;
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 89242b0f8614..ad62e36ec997 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1265,6 +1265,54 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_model);
>   
> +static ssize_t nvmet_subsys_attr_ieee_oui_show(struct config_item *item,
> +					    char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return sysfs_emit(page, "0x%06x\n", subsys->ieee_oui);
> +}
> +
> +static ssize_t nvmet_subsys_attr_ieee_oui_store_locked(struct nvmet_subsys *subsys,
> +		const char *page, size_t count)
> +{
> +	uint32_t val = 0;
> +	int ret;
> +
> +	if (subsys->subsys_discovered) {
> +		pr_err("Can't set IEEE OUI. 0x%06x is already assigned\n",
> +		      subsys->ieee_oui);
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtou32(page, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val >= 0x1000000)
> +		return -EINVAL;
> +
> +	subsys->ieee_oui = val;
> +
> +	return count;
> +}
> +
> +static ssize_t nvmet_subsys_attr_ieee_oui_store(struct config_item *item,
> +					     const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	ssize_t ret;
> +
> +	down_write(&nvmet_config_sem);
> +	mutex_lock(&subsys->lock);
> +	ret = nvmet_subsys_attr_ieee_oui_store_locked(subsys, page, count);
> +	mutex_unlock(&subsys->lock);
> +	up_write(&nvmet_config_sem);
> +
> +	return ret;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_ieee_oui);
> +
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
>   						char *page)
> @@ -1323,6 +1371,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_cntlid_max,
>   	&nvmet_subsys_attr_attr_model,
>   	&nvmet_subsys_attr_attr_qid_max,
> +	&nvmet_subsys_attr_attr_ieee_oui,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_subsys_attr_attr_pi_enable,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index aecb5853f8da..ec697ceeac56 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1561,6 +1561,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   		goto free_subsys;
>   	}
>   
> +	subsys->ieee_oui = 0;
> +
>   	switch (type) {
>   	case NVME_NQN_NVME:
>   		subsys->max_qid = NVMET_NR_QUEUES;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dfe3894205aa..1dc0ff8b2f3f 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -264,6 +264,7 @@ struct nvmet_subsys {
>   	struct config_group	allowed_hosts_group;
>   
>   	char			*model_number;
> +	u32			ieee_oui;
>   
>   #ifdef CONFIG_NVME_TARGET_PASSTHRU
>   	struct nvme_ctrl	*passthru_ctrl;

