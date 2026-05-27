Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F63CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJHbxhlxPwPODEX2eTchbzxQm7hEfMNr0UyQ1OiMBsI=; b=AG0M6motNHztJ/BL8+DcMXVyba
	6WMWy2hxGCcVFUueCQzl0loml15XnV27N4DbDoP3Ms+llPagfQeg/l6NbXgktgDM/nDqIgw0vVz3B
	NcRqdnMWZf+VN+dacdxa5UF1VmL0k0b+3BknKKsnmSAtuRi37RhC8HnEcjzHdH2TFgP9/+E9vRu+7
	bIWOiv28vjTRQI/ABA7IVmzc165WYA9HrYhByQd6hKvoccAhzIipB/pqVv4diZl8dco4CzNjx8/Bm
	p8tdu2/8ugni1uVYRj8/LHvvn73Bqy4HKzX9PwGW545C+hsLpOI1wCjZh4skO8+Er1e9uTFmIiCwJ
	3NaMLx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEPu-00000004CkP-1nPM;
	Wed, 27 May 2026 13:35:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEPq-00000004CjP-2W9s
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:35:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B96D68BEB; Wed, 27 May 2026 15:35:18 +0200 (CEST)
Date: Wed, 27 May 2026 15:35:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3] nvme: refresh multipath head zoned limits from path
 limits
Message-ID: <20260527133518.GA12167@lst.de>
References: <20260526072529.1086128-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526072529.1086128-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_063524_486198_885685DD 
X-CRM114-Status: GOOD (  14.39  )
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

Hi Yao,

thanks for the patch.

On Tue, May 26, 2026 at 03:25:29PM +0800, Yao Sang wrote:
> +		if (lim.features & BLK_FEAT_ZONED) {
> +			lim.max_open_zones = min_not_zero(lim.max_open_zones,
> +							  ns_lim->max_open_zones);
> +			lim.max_active_zones = min_not_zero(lim.max_active_zones,
> +							    ns_lim->max_active_zones);

A bunch for overly long lines here.  And I think this would become a lot
more readable by factoring it into a little helper:

static void nvme_stack_zone_resources(struct queue_limits *t,
		const struct queue_limits *b)
{
	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
	t->max_active_zones =
		min_not_zero(t->max_active_zones, b->max_active_zones);
}

and then call that.

> +		} else {
> +			lim.max_open_zones = 0;
> +			lim.max_active_zones = 0;
> +		}

and we should not need this, as the values should already be zeroed
when BLK_FEAT_ZONED is not set.


