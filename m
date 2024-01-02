Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08CC47074
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 02:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3lTMXA03nSu4yo3xReFwF1f2oZIojPSlYANbhRqs7bA=; b=1t3g0twI9HE9UcCZ2RQ5O6K1tm
	ZO6OrFruxCYsiM3WVWOod/G6G0bS/pdIgHYVDATkh1swkmtNxAZhmU9jxPEqRxb8wR7a5WmiKcCuM
	0X7CYcAkvjNiSBf4/d/vThLxh4C5nGdJ3sSRrifXRvLtB4d8L1aMwNb2oj08f9KLg79DeLjabr/Dk
	y3eeSCLF3sDuxeplLCWrDSLyAvNDEin8um7TJu+iBOuwHuz1++b35/dA6rSYVj2+GGZO+k6awyOTd
	0LtH6p6ZKhesEcRxzxSqxwFEEpljq1RE6dUqghwfLp5QIqBbEQ7I1B/kOIAYrZB4Ntmld9of+tmFm
	quTdIPfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKUC0-006xZ6-13;
	Tue, 02 Jan 2024 02:07:44 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKUBx-006xXq-0D
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 02:07:43 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VziwHGJ_1704161246;
Received: from 30.178.83.69(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VziwHGJ_1704161246)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 10:07:27 +0800
Message-ID: <2bd8a6db-43de-4e2b-8ac2-2af1732ab50b@linux.alibaba.com>
Date: Tue, 2 Jan 2024 10:07:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet: introduce new max queue size configuration
 entry
Content-Language: en-GB
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-10-mgurtovoy@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20231231005249.18294-10-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_180741_264064_FE1E42A1 
X-CRM114-Status: GOOD (  22.67  )
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

lol, I have made this configurable too,

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

在 2023/12/31 08:52, Max Gurtovoy 写道:
> Using this port configuration, one will be able to set the maximal queue
> size to be used for any controller that will be associated to the
> configured port.
>
> The default value stayed 1024 but each transport will be able to set the
> its own values before enabling the port.
>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/target/configfs.c | 28 ++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c     | 16 ++++++++++++++--
>   drivers/nvme/target/nvmet.h    |  1 +
>   3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index bd514d4c4a5b..f8df2ef715ba 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -272,6 +272,32 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_, param_inline_data_size);
>   
> +static ssize_t nvmet_param_max_queue_size_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%d\n", port->max_queue_size);
> +}
> +
> +static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	int ret;
> +
> +	if (nvmet_is_port_enabled(port, __func__))
> +		return -EACCES;
> +	ret = kstrtoint(page, 0, &port->max_queue_size);
> +	if (ret) {
> +		pr_err("Invalid value '%s' for max_queue_size\n", page);
> +		return -EINVAL;
> +	}
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(nvmet_, param_max_queue_size);
> +
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   static ssize_t nvmet_param_pi_enable_show(struct config_item *item,
>   		char *page)
> @@ -1856,6 +1882,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>   	&nvmet_attr_addr_trtype,
>   	&nvmet_attr_addr_tsas,
>   	&nvmet_attr_param_inline_data_size,
> +	&nvmet_attr_param_max_queue_size,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_attr_param_pi_enable,
>   #endif
> @@ -1914,6 +1941,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   	INIT_LIST_HEAD(&port->subsystems);
>   	INIT_LIST_HEAD(&port->referrals);
>   	port->inline_data_size = -1;	/* < 0 == let the transport choose */
> +	port->max_queue_size = -1;	/* < 0 == let the transport choose */
>   
>   	port->disc_addr.portid = cpu_to_le16(portid);
>   	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index f08997f58101..f7d82da4c1bc 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -358,6 +358,17 @@ int nvmet_enable_port(struct nvmet_port *port)
>   	if (port->inline_data_size < 0)
>   		port->inline_data_size = 0;
>   
> +	/*
> +	 * If the transport didn't set the max_queue_size properly, then clamp
> +	 * it to the global fabrics limits.
> +	 */
> +	if (port->max_queue_size < 0)
> +		port->max_queue_size = NVMF_MAX_QUEUE_SIZE;
> +	else
> +		port->max_queue_size = clamp_t(int, port->max_queue_size,
> +					       NVMF_MIN_QUEUE_SIZE,
> +					       NVMF_MAX_QUEUE_SIZE);
> +
>   	port->enabled = true;
>   	port->tr_ops = ops;
>   	return 0;
> @@ -1223,9 +1234,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>   	ctrl->cap |= (15ULL << 24);
>   	/* maximum queue entries supported: */
>   	if (ctrl->ops->get_max_queue_size)
> -		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
> +		ctrl->cap |= min_t(u16 , ctrl->ops->get_max_queue_size(ctrl),
> +				   ctrl->port->max_queue_size) - 1;
>   	else
> -		ctrl->cap |= NVMF_MAX_QUEUE_SIZE - 1;
> +		ctrl->cap |= ctrl->port->max_queue_size - 1;
>   
>   	if (nvmet_is_passthru_subsys(ctrl->subsys))
>   		nvmet_passthrough_override_cap(ctrl);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index a76f816edf1d..ab6459441376 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -163,6 +163,7 @@ struct nvmet_port {
>   	void				*priv;
>   	bool				enabled;
>   	int				inline_data_size;
> +	int				max_queue_size;
>   	const struct nvmet_fabrics_ops	*tr_ops;
>   	bool				pi_enable;
>   };

