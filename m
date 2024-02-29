Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43899C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgFTTZPdOXzH+2jTqpemILfjfVLvNNOA0HHRfoLiu7M=; b=OjKhgJzkz572ni/adwXWUTJ8IJ
	Zcw9zhbYaMjyQgzTFYIBn1it03YOYVhgjbw5zsJIV+hBCu2d2s/NYFHNKAIBXaL77rMelsObifG98
	HiMQbRL3KoA00mJomv/Fe+5bJ0YUk4+ATCCxIW2ciy8xpNFVayKhjfL2dZ7jJrhvlTHnQT5BnJD2r
	/dn92MaYulBo/mFJhPf3mRb7pqUSbvBXxEn0A6EyoJI/ZlyHZuB+UiwMJfI0a1UgBBoPjQkxG1wJ/
	d3KvvkhI60eqf0YBfSc2F+fD5xOP66j4odESRJRMA1vHTH7VkIHwI1iYGZWJUpwr4bGzudlYLn5o2
	ByXpcdbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfge3-0000000DhTI-0xYU;
	Thu, 29 Feb 2024 13:40:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgdz-0000000DhPq-3TO1
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 13:40:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CAEE68BEB; Thu, 29 Feb 2024 14:40:04 +0100 (CET)
Date: Thu, 29 Feb 2024 14:40:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/21] nvme: move common logic into nvme_update_ns_info
Message-ID: <20240229134003.GA7322@lst.de>
References: <20240228181215.873854-1-hch@lst.de> <20240228181215.873854-13-hch@lst.de> <e8a57b1e-7884-497d-b090-4a3967104063@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a57b1e-7884-497d-b090-4a3967104063@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_054016_185637_011A8554 
X-CRM114-Status: GOOD (  18.15  )
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

On Thu, Feb 29, 2024 at 03:30:22PM +0200, Max Gurtovoy wrote:
>> +	/*
>> +	 * If probing fails due an unsupported feature, hide the block device,
>> +	 * but still allow other access.
>> +	 */
>> +	if (ret == -ENODEV) {
>> +		ns->disk->flags |= GENHD_FL_HIDDEN;
>> +		set_bit(NVME_NS_READY, &ns->flags);
>> +		ret = 0;
>> +	}
>> +
>> +	if (!ret && nvme_ns_head_multipath(ns->head)) {
>> +		blk_mq_freeze_queue(ns->head->disk->queue);
>> +		if (!(ns->disk->flags & GENHD_FL_HIDDEN))
>> +			nvme_init_integrity(ns->head->disk, ns->head);
>
> the logic in "nvme_update_ns_info_generic()" today is to hide also 
> ns->head->disk..

Indeed, that got lost.

>
>
>> +		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
>> +		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>> +		nvme_mpath_revalidate_paths(ns);
>> +		blk_stack_limits(&ns->head->disk->queue->limits,
>> +				 &ns->queue->limits, 0);
>> +		disk_update_readahead(ns->head->disk);
>
> we don't call disk_update_readahead() in "nvme_update_ns_info_generic()" 
> today..

Yes, but it's harmless as it just propagates the limits from the
queue_limits to the bdi.  That beeing said I've failed to send out a
last patch that actually removes it by switching to the queue_limits_set
API for the multipath node as well.

