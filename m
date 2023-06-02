Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085ECC7EE24
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 05:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWe6gwbqxPjfTbnExKDdrCq/Dh9dMlRNTjmUBSaebQQ=; b=cWvl2a92ubERDBsTdmHfqUlo5+
	y6qLCb1YitKProEswUgoGxSljFNhBLQe/wMjmpLDztyS4Qvu6BHtQorBtjzEcTv88FN/6zivekn0B
	00Ph6wGV2u3JjrVhHnjW95KRVDr6GvOO8/qOEgtL1xM0VGLwcItfw4RTjsNrc4o3B4AYO4OxXxJBa
	zktwKvSq+v5LH2K3GD5/jGT2VWt4geHiSHGRjcgVGAZtPlNv10kpV8O8JFKLLlI+qhZRd/Cf25UUH
	mq2Lo7XCqHOKHm8DGVy2KSTbthECtHk5EyQI7Ds973udDha2dFGe3lbbpSsIJkAdt59WvSZ3GzmSe
	EzkQv/kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xYU-005oI3-1D;
	Fri, 02 Jun 2023 05:42:30 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4xYR-005oH0-1o
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 05:42:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HWe6gwbqxPjfTbnExKDdrCq/Dh9dMlRNTjmUBSaebQQ=;
  b=pLSrc1FRbOhkhpqUGbl2UqQEPtTK12GnwdtW3C0LfielUXnXBmY432S0
   XaMx3eIBmrWtjGvkQM6hK4P+mfvLNIF5yDVLto7e7XgkQw6EOQhidULLB
   ShBBhEY609mn2V36LiOsZN+9CceWkoz1anqqaLSHVs0KpBiebYLrUuWGX
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.00,212,1681164000"; 
   d="scan'208";a="110834168"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:42:25 +0200
Date: Fri, 2 Jun 2023 07:42:24 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Chaitanya Kulkarni <kch@nvidia.com>
cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk, 
    hch@lst.de, sagi@grimberg.me, kernel test robot <lkp@intel.com>, 
    Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] nvme-fabrics: error out to unlock the mutex
In-Reply-To: <20230602053713.43006-1-kch@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2306020741550.2925@hadrien>
References: <20230602053713.43006-1-kch@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_224227_869778_A9C49CAD 
X-CRM114-Status: GOOD (  19.32  )
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



On Thu, 1 Jun 2023, Chaitanya Kulkarni wrote:

> Currently, in the nvmf_host_add() function, if the nvmf_host_alloc()
> call failed to allocate memory for the host, the code would directly
> return -ENOMEM without unlocking the nvmf_hosts_mutex. This could
> lead to potential issues with mutex synchronization.
>
> Fix that error handling mechanism by jumping to the out_unlock label
> when nvmf_host_alloc() fails. This ensures that the mutex is unlocked
> before returning the error code. The updated code enhances avoids
> possible deadlocks.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202306020909.MTUEBeIa-lkp@intel.com/
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/fabrics.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index b1fa27b60917..c4345d1d98aa 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -92,8 +92,10 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn, uuid_t *id)
>  	}
>
>  	host = nvmf_host_alloc(hostnqn, id);
> -	if (!host)
> -		return ERR_PTR(-ENOMEM);
> +	if (!host) {
> +		host = ERR_PTR(-ENOMEM);
> +		goto out_unlock;
> +	}
>
>  	list_add_tail(&host->list, &nvmf_hosts);
>  out_unlock:

Looks good, thanks.

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>



> --
> 2.40.0
>
>

