Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE0C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:26:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C649F21655
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JFrpvFpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C649F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3SZWd1woRcXgcY/RUg1XtqnO0Ohi7FyuU1+o8ABHSTs=; b=JFrpvFpuTkn3u3
	TNDxzrTWJNCXLdgviiP0Djnjtyo8gAphsPhgv/A2GMA3XCpszIxBaAQaqf4gtLwRqhJbIS3SeghzS
	AOSz+M2nL8FG6qaSz8ABBbWE+UEgHXRfc0PfidWEBTvGYljoISlKC1CTBmkAw9vetwiGxVINeWf/i
	Vb3KEVj5J9SmWaGvsXDXKjqIW7dRJz6d2MO/8/69+LPVzcGH89gs8Y7ZmW2da+uvNCSuHQr7gYUHj
	8J4ju7HpiSfVcS98iL83umaswofo25Pq4FrXvDTqZj3cT6wrkrf4cvsfHmKkVxbs6u7mNkrSaEhPZ
	SzREaEGiA5xJty2NA7LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKje-0003M8-GF; Thu, 12 Dec 2019 09:26:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifKjb-0003Ln-4i
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:26:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D1CE068B05; Thu, 12 Dec 2019 10:26:08 +0100 (CET)
Date: Thu, 12 Dec 2019 10:26:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 1/3] nvmet: make ctrl-id configurable
Message-ID: <20191212092608.GH2399@lst.de>
References: <20191127094034.12334-1-chaitanya.kulkarni@wdc.com>
 <20191127094034.12334-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191127094034.12334-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_012611_335301_33E17217 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 27, 2019 at 01:40:32AM -0800, Chaitanya Kulkarni wrote:
> +	int ret = -EINVAL;
> +	u16 cntlid_min;
> +
> +	if (sscanf(page, "%hu\n", &cntlid_min) != 1)
> +		return ret;
> +
> +	if (cntlid_min == 0) {
> +		pr_info("specified cntlid_min = 0 is not allowed\n");
> +		return ret;
> +	}
> +
> +	down_write(&nvmet_config_sem);
> +	if (cntlid_min >= to_subsys(item)->cntlid_max) {
> +		pr_info("specified cntlid_min is >= current cntlid_max\n");
> +		goto out;

I'm not sure we need the pr_info calls here.  The error conditions
are pretty clear when we get an -EINVAL from the write.

> +	}
> +
> +	ret = 0;
> +	to_subsys(item)->cntlid_min = cntlid_min;
> +out:
> +	up_write(&nvmet_config_sem);
> +
> +	return ret ? ret : cnt;

The tail of the function could be simplified by avoid the ret variable.
the ret variable:

	down_write(&nvmet_config_sem);
	if (cntlid_min >= to_subsys(item)->cntlid_max)
		goto out_unlock;
	to_subsys(item)->cntlid_min = cntlid_min;
	up_write(&nvmet_config_sem);
	return cnt;

out_unlock:
	up_write(&nvmet_config_sem);
	return -EINVAL;


> +	if (cntlid_max == 0) {
> +		pr_info("specified cntlid_max = 0 is not allowed\n");
> +		return ret;
> +	}
> +
> +	down_write(&nvmet_config_sem);
> +	if (cntlid_max <= to_subsys(item)->cntlid_min) {
> +		pr_info("specified cntlid_max is <= current cntlid_min\n");
> +		goto out;
> +	}
> +
> +	ret = 0;
> +	to_subsys(item)->cntlid_max = cntlid_max;
> +out:
> +	up_write(&nvmet_config_sem);
> +
> +	return ret ? ret : cnt;

Same comments here.

>  	}
> -
> +	subsys->cntlid_min = NVME_CNTLID_MIN;
> +	subsys->cntlid_max = NVME_CNTLID_MAX;
>  	kref_init(&subsys->ref);
>  
>  	mutex_init(&subsys->lock);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 46df45e837c9..6492d12e626a 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -211,6 +211,8 @@ struct nvmet_subsys {
>  	struct list_head	namespaces;
>  	unsigned int		nr_namespaces;
>  	unsigned int		max_nsid;
> +	u16			cntlid_min;
> +	u16			cntlid_max;
>  
>  	struct list_head	ctrls;
>  
> -- 
> 2.22.1
---end quoted text---

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
