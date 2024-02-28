Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8431C5475B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqPANB60tamBaLK7wA6i4tCJC2BlFdYlQ7XqRdJoxMo=; b=0gNIAtX3AnFgxzsz22Xt8TOT53
	HKgezrEXVi36MfEiNNNsRKLvbZu3L40izCmXuNbPKBzciOWOqSNPT+9k4R7/MX0bkc0UFJIljqhcx
	cPAYZMGN8Z4chhObA88ZGk6eEQadLEuMnMnES/uwO9qkYexz+amLkDRYuy43MrGdTepFDklnEufJm
	1LXx7QPcZrx0JcZCyl9Mx1dYDn2bAOsUF0z6W1eMTNW2sPWvkXRzWry0ifkXF1pV6qT2JI6c7mBae
	brq6GGY+CqhM7myT8ksvBBGFYCQZ/z1bea4+Yh6xUAfnt8uiQiiTUmjm2IwLGjkan6ZjWsz9lZCQX
	0pvpKFYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfTdn-0000000BJiC-36Zd;
	Wed, 28 Feb 2024 23:47:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfTdk-0000000BJhm-11DN
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 23:47:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 39B9661835;
	Wed, 28 Feb 2024 23:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40125C433F1;
	Wed, 28 Feb 2024 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709164026;
	bh=Iw0U/wUM1+yMxiscJOs8z/bCPBSNs/GVj+pC4sHqtTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YX1GuIO7YsgB26124n/+oHjWUsFJ1oJ2S9euupNWVCae+OfN+HfkIbs5nHbRk5kCT
	 PTHrSWF3juaURCSELQ8Q5qHMkdN7uu26KCXlQ+1egAXUji0t8gJNFXLDihuzUOtaRe
	 I/rexLzK7HQk7EaVYv+WjhgNotAxOqA1Gj4Yd+GQi1skTyopsz3wOUHt2kZnQVw5ze
	 7+ab1EHR4G3dfZLVQKMtYdgegdhvKleHZb3B2TVMTXeXhxyoj58O3HFKysbYo4imjR
	 5C2k0OII9Br91OPdw7vmafhyzcGVSzV5bwPKVpUwFQdOlJLdVddZtYR7kPyDKQumBZ
	 pE/I04W3EvUOg==
Message-ID: <9dd3ea59-0394-484d-809c-37cbdce8a6c2@kernel.org>
Date: Wed, 28 Feb 2024 15:47:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] nvme: remove nvme_revalidate_zones
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240228181215.873854-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_154708_363928_F3DF943E 
X-CRM114-Status: GOOD (  12.40  )
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

On 2024/02/28 10:11, Christoph Hellwig wrote:
> Handle setting the zone size / chunk_sectors and max_append_sectors
> limits together with the other ZNS limits, and just open code the
> call to blk_revalidate_zones in the current place.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

[...]

>  static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_command c = { };
> @@ -113,6 +103,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
>  	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);

Not directly related to this patch, but I think that since you moved the max
open & active limits to queue->limits, we really should rename these to
blk_queue_max_open_zones() and blk_queue_max_active_zones() to be consistent
with all the other limits. and may be same for disk_set_zoned() while we are at it.

I can send a patch if you want...

> +	blk_queue_chunk_sectors(ns->queue, ns->head->zsze);
> +	blk_queue_max_zone_append_sectors(ns->queue, ns->ctrl->max_zone_append);
>  free_data:
>  	kfree(id);
>  	return status;

-- 
Damien Le Moal
Western Digital Research


