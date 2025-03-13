Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F5C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oaq4eqHtqMbXN9BO9sxV7kp+5HdjiEjA0g66OTKlhf0=; b=Bt/jLtBmV0TImXYjCytrkThkP7
	vw4kKU5QXyZGcTQWFOpixicZUP822kUiDKIW9SJYD9ymi+hirjk2LohnpweK+c5vLPwwdBWhlEnoC
	izuNs8BqmR6XxvHJrhQ1WdUVD1r9U4GZ0B7CfAWRHeJ83qjqOEwTNpsocmeYbxFHuOuZHda8BPnSs
	WEJI4EJL38buddHIz9PdfF+1WnAB5Fx9M48xaNE9UpW2vyhBw9v5KfxT9GZK3XPVlvo/ilmiMoINy
	TVmrU9c/ebjPY2ugbIq8sq4ihWgOwOBKLJ+5WykC9T5v1hIr6HhPtbLHGf3+LzAOxi9TzE5xxaFJ3
	5M8XDgeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tseUi-0000000AeuP-3dua;
	Thu, 13 Mar 2025 09:04:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tseTF-0000000AedX-31eu
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:03:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 496D75C4D68;
	Thu, 13 Mar 2025 09:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15004C4CEDD;
	Thu, 13 Mar 2025 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856596;
	bh=aZDWaOl31agwHSeFtrIfizSaaXAxaHm409w6nhtjL+8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=X8UzyDYTEKdL3S2qnz6m5u7fSPURWkYCQy9eUyHoC9ygq6hDiZobVAVTxtiXU46Mn
	 dT7arCyTfeoiT+4R5U+NKAfe3mxfPJs6TCYNaA+pIZTqRohxwrdsi3U8AxoXfrvsDk
	 xTCBDnc+xuHt6YWaBQYqlP385/oTDGwa61nkoyigSZzJr5d3IUEq9FGo7DwVqSsMUK
	 oyCH7r4GPhcqGs4FG01F+QUIBXpnmMr1T6mFhelNwcdtL6TIhqGUBdxvfNm/Xa8IhA
	 4MQp2T25wvb3DxMZ/Xl/9yvQyMkWTSPOHRiZVMi1wuirYm3i1GwMQTTHh07yoBMBud
	 nUZ1yCqyuwSRg==
Message-ID: <f7e7c4e0-1997-4edd-a0b6-137f5abca3c0@kernel.org>
Date: Thu, 13 Mar 2025 18:03:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/11] nvmet: Add function to get nvmet_fabrics_ops
 from trtype
To: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, joao.m.martins@oracle.com,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, kwankhede@nvidia.com,
 alex.williamson@redhat.com, mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313052222.178524-5-michael.christie@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313052222.178524-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_020317_864179_91EB91A5 
X-CRM114-Status: GOOD (  18.62  )
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

On 3/13/25 14:18, Mike Christie wrote:
> In the next patches we allow users to create static controllers if the
> driver supports it. To get this info we need the nvmet_fabrics_ops
> a little sooner then port enablement so this creates a function to go
> from trtype to nvmet_fabrics_ops.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/target/core.c  | 41 +++++++++++++++++++++++--------------
>  drivers/nvme/target/nvmet.h |  1 +
>  2 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 4de534eafd89..06967c00e9a2 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -306,6 +306,30 @@ void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(nvmet_unregister_transport);
>  
> +const struct nvmet_fabrics_ops *nvmet_get_ops_by_transport(int trtype)
> +{
> +	const struct nvmet_fabrics_ops *ops;
> +
> +	lockdep_assert_held(&nvmet_config_sem);
> +
> +	ops = nvmet_transports[trtype];
> +	if (!ops) {
> +		up_write(&nvmet_config_sem);
> +		request_module("nvmet-transport-%d", trtype);
> +		down_write(&nvmet_config_sem);
> +		ops = nvmet_transports[trtype];
> +		if (!ops) {
> +			pr_err("transport type %d not supported\n", trtype);
> +			return NULL;
> +		}
> +	}
> +
> +	if (!try_module_get(ops->owner))
> +		return NULL;
> +
> +	return ops;
> +}
> +
>  void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *subsys)
>  {
>  	struct nvmet_ctrl *ctrl;
> @@ -325,22 +349,9 @@ int nvmet_enable_port(struct nvmet_port *port)
>  
>  	lockdep_assert_held(&nvmet_config_sem);
>  
> -	ops = nvmet_transports[port->disc_addr.trtype];
> -	if (!ops) {
> -		up_write(&nvmet_config_sem);
> -		request_module("nvmet-transport-%d", port->disc_addr.trtype);
> -		down_write(&nvmet_config_sem);
> -		ops = nvmet_transports[port->disc_addr.trtype];
> -		if (!ops) {
> -			pr_err("transport type %d not supported\n",
> -				port->disc_addr.trtype);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (!try_module_get(ops->owner))
> +	ops = nvmet_get_ops_by_transport(port->disc_addr.trtype);
> +	if (!ops)
>  		return -EINVAL;
> -

whiteline change.

>  	/*
>  	 * If the user requested PI support and the transport isn't pi capable,
>  	 * don't enable the port.
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index ec3d10eb316a..052ea4a105fc 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -622,6 +622,7 @@ void nvmet_port_send_ana_event(struct nvmet_port *port);
>  
>  int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
>  void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
> +const struct nvmet_fabrics_ops *nvmet_get_ops_by_transport(int trtype);
>  
>  void nvmet_port_del_ctrls(struct nvmet_port *port,
>  			  struct nvmet_subsys *subsys);


-- 
Damien Le Moal
Western Digital Research

