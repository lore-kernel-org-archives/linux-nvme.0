Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF294C5AE5A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5VxF7oNSHpN0p4dW+aWKfpSWE9lhmnQfrnm7oVHKck=; b=Y6cb8qQIVpUmgUUl2mA67Ya6N8
	smeq2L9Y3lWObCw8UaLc5haxZZGLv1tZAe5e3i0CF5T8GmSpYJ1CD5FiML6hIpX/A2jn+nGgmCVwF
	Ag2jXNA33KhZiIrV6vwHfZQ0I7YYizrot8gNdbt2t4faHILde3Z0oKDepPhFRrVFz5D8IYFro6DOm
	qhPRDwCbmopD7NSGG8IHXPDJ3JPs6pPwYxTqwhL1Qg+Lfh2dAz9WHu6VETZIZrzobNGzbKFoSayy7
	DGtmI4TN3XAfVnaM/A1oPEG+d5AwqMz7Oe/f4ikl7NQOfEpYxG2y97wSRFrzVpuisGo4ZrNmM2pua
	mQf+lPJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjJuz-0000000Fo1N-2tDt;
	Wed, 28 Aug 2024 14:45:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjJux-0000000Fo0r-2IsZ
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 14:45:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A3D62A40DBE;
	Wed, 28 Aug 2024 14:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953DBC4CECD;
	Wed, 28 Aug 2024 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856302;
	bh=C/owWcqokpG1H1qQ8ELjChlBOTZP8wQl8nYAkusz5SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUs28LMJjS2z9EXeYHwLdxMaS9CJ4uXk+f5yd/xfU1Eq7558tCzdVxh+kORjemX+d
	 As2Gd+y2Vl2x47PiafwrkTdVXcq2qIuYQwPPr4+uvPFS8E4m+BmZCQhBnPqGPoDh8S
	 VFBinZiMJZRvTAzt9Tc7v3igidZIPqV3jrzhXyab0SW2CmyLAZyKcGIy4D8upFvciS
	 jgcSzitReH1zTyiIzxQj54fTbbSXbkZ9pMirNFGvVc4G421sLhekr6Pw9VkmaLkw6s
	 FpHZzU0o6p6cHpkEv9vQhKaUIUMOeyg9NSep7dy7VFObXy2LwVtiONTVWVOnAMXWhF
	 rdu8SnNigJyxg==
Date: Wed, 28 Aug 2024 08:44:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs8360kRPGa1B5xy@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_074503_678254_4CF99158 
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

On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  	struct request_queue *q = req->q;
>  	struct nvme_ns *ns = q->queuedata;
>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> +	bool has_metadata = bdev && meta_buffer && meta_len;

If this is an admin command, then bdev is NULL, so "has_metadata" is
false.

>  	struct bio *bio = NULL;
>  	int ret;
>  
> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;
> +

Since has_metadata is false, we continue on to process this admin
command, but ignore the user's metadata settings. Do we want to return
error there too?

