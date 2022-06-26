Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A81C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TLOBy0iHKC3PO6DmR2qk5dstsSApsjEGSG0uD7xmXE=; b=UWHkr5stx+62W51Lyo48cxywww
	yU8KliCIeXM4ioBhTwYGmWqCSyQmWLGPr5gkDdXAjiprvdxBqt33z/LQgW0CJ+D8XKgCy3zohKrAC
	HgJrwZPLshdjTn7g194uDnD3ZEb3h72qbMzyDcLmmBrIWeNWc/TrRKTmIjDmMCEdvUEQoA6oq1pC5
	lY/MwfY6KtZXVf09xwZpkevAdvrJ/ionyY8WdS9z86XKiAAxSLdJEcOqr5vMFqNzSlid2uB9JJx6P
	niOiKJplswmgSCMvM+n6PMMoCiENomfEu0M8A001FtUQD4dLEWlwwgR8JDwlkobyxdoxbHrU5fQHb
	HRiQ4rig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5STV-00BzGh-82; Sun, 26 Jun 2022 13:38:53 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5STS-00BzFc-31
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 13:38:51 +0000
Received: by mail-wr1-f43.google.com with SMTP id w17so9452823wrg.7
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 06:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5TLOBy0iHKC3PO6DmR2qk5dstsSApsjEGSG0uD7xmXE=;
        b=ig0dJRKf9JNccAqJzCzkqZnldAmhp9Cxyo82N06J0xh5SccLJwAbfzCqeN7guldjd1
         UQGSF95BSVSUwA/qYJopypYQ4o9+VzYrcOrPIogm7pJjWHzpSLKoOfHQwpUuJaIMrtzR
         7d+0DrnvV3HMK54jzJ4Doo22kfYmD3hly/H0aNmMXK86NvcKZmK4/tp5l4wAxpGWj5T8
         nQtEss81oqzc1huKc/sqwPFrIS9M5HM9ljG4VoLoq5t+IX/ys4cCKuQ/dDCW28h3k/8r
         tP7fMTAUk/lKkzENty3Syim/V++wo1JLX9msLr6j5mHpcU6wU9Yle2CZ5+0LkGaYbBK/
         Cv/Q==
X-Gm-Message-State: AJIora8M50ZvNw8x7JAvw838rknqSKGEHbZD3XJtoz/OY1DlNVLlPqRi
	eWK9E1EPsWxEgHsZDedXg1s=
X-Google-Smtp-Source: AGRyM1uAaSrPBE7gIYv3RbtkrkEx773XqI1hI/FqkHXpnTwSW5Qklt73eBfYTjw4yqYdTxxrABKxSw==
X-Received: by 2002:a05:6000:1f19:b0:21b:98d6:3532 with SMTP id bv25-20020a0560001f1900b0021b98d63532mr8123644wrb.45.1656250728210;
        Sun, 26 Jun 2022 06:38:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003a046549a85sm3008696wmb.37.2022.06.26.06.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:38:47 -0700 (PDT)
Message-ID: <fc55e51a-7c08-4747-3bd2-857569831390@grimberg.me>
Date: Sun, 26 Jun 2022 16:38:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Add new clear_ids attribute for passthru targets
Content-Language: en-US
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20220622224724.19623-1-alan.adamson@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220622224724.19623-1-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_063850_185090_A5AD7CD6 
X-CRM114-Status: GOOD (  27.06  )
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



On 6/23/22 01:47, Alan Adamson wrote:
> If the clear_ids attribute is set to true, the EUI/GUID/UUID is
> cleared for the passthru target.  By default, loop targets will
> set clear_ids to true.
> 
> This resolves an issue where a connect to a passthru target fails
> when using a trtype of 'loop' because EUI/GUID/UUID is not unique.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>   drivers/nvme/target/configfs.c | 20 ++++++++++++
>   drivers/nvme/target/core.c     |  4 +++
>   drivers/nvme/target/nvmet.h    |  1 +
>   drivers/nvme/target/passthru.c | 58 ++++++++++++++++++++++++++++++++++
>   4 files changed, 83 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e44b2988759e..ff77c3d2354f 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -773,11 +773,31 @@ static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
>   
> +static ssize_t nvmet_passthru_clear_ids_show(struct config_item *item,
> +		char *page)
> +{
> +	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->clear_ids);
> +}
> +
> +static ssize_t nvmet_passthru_clear_ids_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
> +	unsigned int clear_ids;
> +
> +	if (kstrtouint(page, 0, &clear_ids))
> +		return -EINVAL;
> +	subsys->clear_ids = clear_ids;
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_passthru_, clear_ids);
> +
>   static struct configfs_attribute *nvmet_passthru_attrs[] = {
>   	&nvmet_passthru_attr_device_path,
>   	&nvmet_passthru_attr_enable,
>   	&nvmet_passthru_attr_admin_timeout,
>   	&nvmet_passthru_attr_io_timeout,
> +	&nvmet_passthru_attr_clear_ids,
>   	NULL,
>   };
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 90e75324dae0..d4203d582343 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1374,6 +1374,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	ctrl->port = req->port;
>   	ctrl->ops = req->ops;
>   
> +	/* By default, set loop targets to clear IDS by default */
> +	if (ctrl->port->disc_addr.trtype == NVMF_TRTYPE_LOOP)
> +		subsys->clear_ids = 1;
> +
>   	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
>   	INIT_LIST_HEAD(&ctrl->async_events);
>   	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 69818752a33a..2b3e5719f24e 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -249,6 +249,7 @@ struct nvmet_subsys {
>   	struct config_group	passthru_group;
>   	unsigned int		admin_timeout;
>   	unsigned int		io_timeout;
> +	unsigned int		clear_ids;
>   #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index b1f7efab3918..e8c033fbdb5c 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -30,6 +30,55 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
>   		ctrl->cap &= ~(1ULL << 43);
>   }
>   
> +static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	void *data;
> +	struct nvme_ns_id_desc *cur;
> +	u16 status = NVME_SC_SUCCESS;
> +	u8 csi;
> +	int pos, len;
> +	bool csi_seen;
> +
> +	if (!ctrl->subsys->clear_ids)
> +		return status;
> +
> +	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!data)
> +		return NVME_SC_INTERNAL;
> +
> +	status = nvmet_copy_from_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> +	if (status)
> +		goto out_free;
> +
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> +		cur = data + pos;
> +
> +		if (cur->nidl == 0)
> +			break;
> +		len = cur->nidl;
> +		if (cur->nidt == NVME_NIDT_CSI) {
> +			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc),
> +			       NVME_NIDT_CSI_LEN);
> +			csi_seen = 1;
> +			break;
> +		}
> +		len += sizeof(struct nvme_ns_id_desc);
> +	}
> +
> +	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
> +	if (csi_seen) {
> +		cur = data;
> +		cur->nidt = NVME_NIDT_CSI;
> +		cur->nidl = NVME_NIDT_CSI_LEN;
> +		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN);
> +	}
> +	status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> +out_free:
> +	kfree(data);
> +	return status;
> +}

I can't understand what this function does...

> +
>   static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> @@ -127,6 +176,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>   
>   static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
>   {
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	u16 status = NVME_SC_SUCCESS;
>   	struct nvme_id_ns *id;
>   	int i;
> @@ -152,6 +202,11 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
>   	 */
>   	id->mc = 0;
>   
> +	if (ctrl->subsys->clear_ids) {
> +		memset(id->nguid, 0, NVME_NIDT_NGUID_LEN);
> +		memset(id->eui64, 0, NVME_NIDT_EUI64_LEN);

What about uuid?

> +	}
> +
>   	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>   
>   out_free:
> @@ -176,6 +231,9 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>   		case NVME_ID_CNS_NS:
>   			nvmet_passthru_override_id_ns(req);
>   			break;
> +		case NVME_ID_CNS_NS_DESC_LIST:
> +			nvmet_passthru_override_id_descs(req);
> +			break;
>   		}
>   	} else if (status < 0)
>   		status = NVME_SC_INTERNAL;

