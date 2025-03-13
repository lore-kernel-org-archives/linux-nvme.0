Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639AC2BA1B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5lDtB9JckTWPC7WKpDQVjAhFBP5DlwazX8ThbdplM6Q=; b=kfdBHtjGAjf/tSaKJ3RSPcw4hS
	bTsNkeTE/POune/pNalr4wy9Y1m/HE6dgFiMrHraGlOd5scyte2VpFHK8MbuP0qun1FF7BEk5OxkU
	mR0Kr+ps8Ad5VtfH6RS1g9bNmIsjgSzGq/h/mjuNZMd6B/3OkOlX+N8w6RTDhFQ6TCNn4L5vtBG08
	verrjg71ZsvKPmeQpe0wCn9Ao7b1kgx34xrTntyhNKNjGmysIM8BzXniPtrHU6Il7rjC+w2zHePA9
	TboXJdg9ue9dVs1LTVpwo/c7bNNATHrKMbtAqIwOKwlrxg0rTEi5/YMkAoctMTEWObPDI2JhU3lxC
	GqT1F1DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tseRI-0000000AdgE-1f9I;
	Thu, 13 Mar 2025 09:01:16 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsePQ-0000000AdQ9-2tN2
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:59:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CDCC9A4650F;
	Thu, 13 Mar 2025 08:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A845CC4CEDD;
	Thu, 13 Mar 2025 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856359;
	bh=Uih/8Aelm7B5LTifK01VFfHuDsEigWvuf20c48D0JY8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=al3OzBa3ps12oOsGrrshnH5rr6EKHubYU4Fv6nWd5A/4fSBV1UZK94qZalW+SPdTB
	 LRrMzTJfta+lUknPZgCWB7QAo4Kfdn0/PJn86Kk30FuMmh1DUU+F4ppcvxYB7EtW3+
	 EQ9G3xzgew6iX3h/vzPF3aSyRNj9/92u6sI77opcEfWpkuZLVhjXUh1JadFVh1ZXcy
	 LdXOtQXBL9FSLggEZfD2XOWlkrqPng3BaF6aGwHa4eanSrS40JhzyEguTWSZjjn/do
	 H5Pc2eiYy9Yp2W3zz5JemCJeUcdVfDzdH5kaK7OaNLXl69LzGPL+HjmKZ4+G4AoxEH
	 w6McRk3TS4TkQ==
Message-ID: <d59ea1dd-f1f1-4ca7-b666-358354633d9e@kernel.org>
Date: Thu, 13 Mar 2025 17:59:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/11] nvmet: Remove duplicate uuid_copy
To: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, joao.m.martins@oracle.com,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, kwankhede@nvidia.com,
 alex.williamson@redhat.com, mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313052222.178524-2-michael.christie@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313052222.178524-2-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_015920_797680_26D15CB0 
X-CRM114-Status: GOOD (  13.21  )
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
> We do uuid_copy twice in nvmet_alloc_ctrl so this patch deletes one
> of the calls.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/target/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 2e741696f371..f896d1fd3326 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1618,8 +1618,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>  	}
>  	ctrl->cntlid = ret;
>  
> -	uuid_copy(&ctrl->hostid, args->hostid);

Good catch. But it is the other call that should be removed as that will also
remove the if (args->hostid) as that is not needed (the 2 call sites of
nvmet_alloc_ctrl() both set a hostid).

And maybe sned this patch as a real patch as I think it can go upstream now.

> -
>  	/*
>  	 * Discovery controllers may use some arbitrary high value
>  	 * in order to cleanup stale discovery sessions


-- 
Damien Le Moal
Western Digital Research

