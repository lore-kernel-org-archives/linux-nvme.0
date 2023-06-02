Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F72C7EE29
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BZQFYsv4YoYOwh5o08F/V9C+L+0z5WXfJPCNTA21D0=; b=4gDwGgpMLhxfW1yvqrpskqYXAR
	ycitvyAo5KS0Uf/IJbyvOsgYdcPm0DS8QubdZkDZp5PewoSbFs3y3lmeVthYkoSKgE3xXDIHMS8SS
	scITM8NQpx84XmcKDgZezkxgN2O0zfS7NVD5cuzj4d/IuzY3mM/MQJUiglUtsYJ7j72pqRmZ2Ni8K
	zqKmSx8dWyHJ6iRMydEhJzYV8G+22d2CSc7oz1uLnBu0kaU8ec5znpMIXiVeCDqdDRNxtFhnvVL12
	BluwmtIa+Frgs4tyCFuZIprvGQdFwp91K61qNuxg/CSxnW7SP4/8mxxVUyOgXhs84ayLyQU7S/xyu
	/ucN2xdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q56JO-007Bu5-0i;
	Fri, 02 Jun 2023 15:03:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q56JI-007Bri-06
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 15:03:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 617AA68AA6; Fri,  2 Jun 2023 17:03:15 +0200 (CEST)
Date: Fri, 2 Jun 2023 17:03:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] nvme-fabrics: error out to unlock the mutex
Message-ID: <20230602150315.GA25353@lst.de>
References: <20230602053713.43006-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602053713.43006-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_080324_229164_12B6BB51 
X-CRM114-Status: GOOD (  12.14  )
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

On Thu, Jun 01, 2023 at 10:37:13PM -0700, Chaitanya Kulkarni wrote:
>  	host = nvmf_host_alloc(hostnqn, id);
> -	if (!host)
> -		return ERR_PTR(-ENOMEM);
> +	if (!host) {
> +		host = ERR_PTR(-ENOMEM);
> +		goto out_unlock;
> +	}

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

