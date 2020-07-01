Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88491C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 06:08:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310E2070C
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 06:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asQxzGHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310E2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/e59fOYJUEaycF3PkyUEHmYcyP52oLuU0+6ak4mjaLA=; b=asQxzGHqx3n1LbV+gI92RZPmU
	AAekFDrwIj3tcuv9LOmU7OLT9jW+Zo3mckBQAfVVjdGsjE19JIoE+aA+LZy0x9NyN3wkYvV+Dyxol
	YqyikAbh7zvFWnBJilJYpa2Kt769IOHiGUMMWqJc596gBPXWTgKnKYchYzfyTvjEduoN84skqr5HS
	O31+lQR8Lfa/tMB12ZTaau9VjEV7rnYZxmdZ69CopmXUYqXGBl4JwH8P6J1SQ++2e2AQvGcY4iX/Y
	Lfyt5hRKR4Xq/cXQCBiggJ9vR1HJVflfgamdolLu5A1AL5VJr/wdSAzy6qZEVi9BaFx2gC0fuQzjT
	xaUi5UELw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqVv8-00029L-F9; Wed, 01 Jul 2020 06:08:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqVuw-00028t-Pi
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 06:08:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1AE668B02; Wed,  1 Jul 2020 08:08:20 +0200 (CEST)
Date: Wed, 1 Jul 2020 08:08:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvmet: use xarray for ctrl ns storing
Message-ID: <20200701060820.GA28214@lst.de>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701022517.6738-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_020822_977862_D1A9967D 
X-CRM114-Status: GOOD (  18.43  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ok, for the target I can see how this makes sense unlike the host.
Comments below:

> -	u64 host_reads = 0, host_writes = 0;
>  	u64 data_units_read = 0, data_units_written = 0;
> -	struct nvmet_ns *ns;
> +	u64 host_reads = 0, host_writes = 0;
>  	struct nvmet_ctrl *ctrl;
> +	struct nvmet_ns *ns;
> +	unsigned long idx;

Please don't randomly reorder the variable declarations.  Same for
later function.

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index cea7c3834021..d14edaa22ad5 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -10,6 +10,9 @@
>  #include <linux/pci-p2pdma.h>
>  #include <linux/scatterlist.h>
>  
> +#include "../host/nvme.h"
> +#undef CREATE_TRACE_POINTS

We really shoud not include the host nvme.h in the target code.  What
are you trying to get from it?

>  static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
>  {
> -	struct nvmet_ns *ns;
> +	struct nvmet_ns *cur;
> +	unsigned long idx;
> +	unsigned long nsid;
>  
> -	if (list_empty(&subsys->namespaces))
> +	if (xa_empty(&subsys->namespaces))
>  		return 0;
>  
> -	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
> -	return ns->nsid;
> +	xa_for_each(&subsys->namespaces, idx, cur)
> +		nsid = cur->nsid;
> +
> +	return nsid;

No need for the xa_empty here.  I also forwarded a question to Matthew
if there is a better way to find the highest index.

>  struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
>  {
> +	XA_STATE(xas, &ctrl->subsys->namespaces, le32_to_cpu(nsid));
> +	struct nvmet_ns *ns = NULL;
>  
>  	rcu_read_lock();
> +	do {
> +		ns = xas_load(&xas);
> +		if (xa_is_zero(ns))
> +			ns = NULL;
> +	} while (xas_retry(&xas, ns));
>  	if (ns)
>  		percpu_ref_get(&ns->ref);
>  	rcu_read_unlock();

Why doesn't this use xa_load?

> +	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
> +	if (ret) {
> +		switch (ret) {
> +		case -ENOMEM:
> +			pr_err("xa insert memory allocation\n");
> +			goto out_unlock;
> +		case -EBUSY:
> +			pr_err("xa insert entry already present\n");
> +			goto out_unlock;
> +		default:
> +			goto out_unlock;
>  		}
>  	}
> +

I don't think we need the switch statement, just return any error
encountered.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
