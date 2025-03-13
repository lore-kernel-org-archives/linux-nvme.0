Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1853C28B2E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Rj5ZebWcZVxq90mO5jqohhLKksdBqtVjXZktH6rQg8=; b=rdYBQgBRLxJKbc0hetxwHuk2c5
	IqEwghSf9HYJ93lc49rhBkuk3eSN7KNYpuEnSmKeOFUIPbVlmhK2gz6h7YHTNm7X7AAydE3E9UWKI
	ljq/mgwhZRU4/QCTsbTmTmPm9eLPkqriWR2bOamh+2DpHM3YV94X7d9VOx2gV/CqsnP4kEn1HNP5n
	YTb2u3qYAmYVsWg08zoKfXqlNhedb8hr4tbsZshR7A/cAkQassgBMz4IfD2aBK4HX161z52oI2dbT
	D3ayY7yMlvoCOQU0DaRNnkHAaAmuN4avIfK4PQvrPp7pnGWWSl+WgWmc/O0u3DEQKPmGii7lwihbo
	p6ilhrOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tseUi-0000000Aeu1-18Hj;
	Thu, 13 Mar 2025 09:04:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tseSX-0000000AeTP-35aS
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:02:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DE536A46521;
	Thu, 13 Mar 2025 08:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA9C4CEDD;
	Thu, 13 Mar 2025 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856552;
	bh=ngIjLNejv6KmigNprK/9mbpgD6OCwOaupkoclqpOGEk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=P7Tl4hWTdQTxFQfJ8kWyhhDcYVNz6HnIO7VijTGn2IsTV/A2HICy0VH7dhB++9ARv
	 irBJ7Xa49EozuiTA3uR2B5vL6xrOvGfQHGoWaXunTQIV2TZMhij7FcEamPSz4fIw+P
	 nCONXOlgb+OOTvmJYRA9uEpsuOKZTKj2JWw8Ef+fN0Cywag2aAEGljnB1nwjEjcRak
	 wa+L/tT+EU8TmScoskdCd2XSBTuG/SGDh7Bc3euP1JMEgo10QJZVYnV55WmGSsgzhK
	 VVQBLWyvdfyLpSEaZHTQuZFsOCNvsfbTC9HZIqDS2V/Q8fxTGaLa91tPBoD61Z+HFR
	 PR4eAGGuQ5MnQ==
Message-ID: <970e0d79-f338-4803-92c4-255156a8257e@kernel.org>
Date: Thu, 13 Mar 2025 18:02:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/11] nvmet: Add nvmet_fabrics_ops flag to indicate
 SGLs not supported
To: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, joao.m.martins@oracle.com,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, kwankhede@nvidia.com,
 alex.williamson@redhat.com, mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313052222.178524-4-michael.christie@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313052222.178524-4-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_020233_949729_697E6E1B 
X-CRM114-Status: GOOD (  18.60  )
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
> The nvmet_mdev_pci driver does not initially support SGLs. In some
> prelim testing I don't think there will be a perf gain (the virt related
> interface may be the major bottleneck so I may not notice) so I wasn't
> sure if they will be required/needed. This adds a nvmet_fabrics_ops flag
> so we can tell nvmet core to tell the host we do not supports SGLS.

That is a major spec violation as NVMe fabrics mandates SGL support.
So at the very least, this needs a big fat warning comment explaining what this
is about.

> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 13 +++++++------
>  drivers/nvme/target/nvmet.h     |  1 +
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index acc138bbf8f2..486ed6f7b717 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -755,12 +755,13 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  	id->awun = 0;
>  	id->awupf = 0;
>  
> -	/* we always support SGLs */
> -	id->sgls = cpu_to_le32(NVME_CTRL_SGLS_BYTE_ALIGNED);
> -	if (ctrl->ops->flags & NVMF_KEYED_SGLS)
> -		id->sgls |= cpu_to_le32(NVME_CTRL_SGLS_KSDBDS);
> -	if (req->port->inline_data_size)
> -		id->sgls |= cpu_to_le32(NVME_CTRL_SGLS_SAOS);
> +	if (!(ctrl->ops->flags & NVMF_SGLS_NOT_SUPP)) {
> +		id->sgls = cpu_to_le32(NVME_CTRL_SGLS_BYTE_ALIGNED);
> +		if (ctrl->ops->flags & NVMF_KEYED_SGLS)
> +			id->sgls |= cpu_to_le32(NVME_CTRL_SGLS_KSDBDS);
> +		if (req->port->inline_data_size)
> +			id->sgls |= cpu_to_le32(NVME_CTRL_SGLS_SAOS);
> +	}
>  
>  	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
>  
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index fcf4f460dc9a..ec3d10eb316a 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -403,6 +403,7 @@ struct nvmet_fabrics_ops {
>  	unsigned int flags;
>  #define NVMF_KEYED_SGLS			(1 << 0)
>  #define NVMF_METADATA_SUPPORTED		(1 << 1)
> +#define NVMF_SGLS_NOT_SUPP		(1 << 2)
>  	void (*queue_response)(struct nvmet_req *req);
>  	int (*add_port)(struct nvmet_port *port);
>  	void (*remove_port)(struct nvmet_port *port);


-- 
Damien Le Moal
Western Digital Research

