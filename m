Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B70CE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9zvhqjghZ+ZJgbEJq8Lc3K5ScyyYc9vnxNHsSnST5w=; b=sqLCCt24Bhn4M4FZz0y+Bky7mw
	EB8ryi7E04TDxJw7lbSPxQ4fi0dRZgIvph23epWiDEwd0SBvu3Kof+xWJs6NnluSyhiW3OBuUcsDz
	ewUvHMdSmecFgdQwQtZHAx+6Edz/0Y+n7B6z5ZgZZ1EzxBOCI3aKKJMnFhGejrfL6f81HA8qk0PFw
	EQGn76CTefgXv5aEM9l01p1lmuNohj5ptkWMM/weEAzFubf6uUJvYzR/dTw+W+TyxAlraTMyHC7B3
	NjS8RMP8R0AdBPC1EjaO9P6Iy5WOWs788dYIdqI0JTrvQkQReFXa8OXms/nWzVJBt9kPSv75qUoN9
	6NR93WIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkfQ-00000000v1S-1bIS;
	Mon, 06 Jan 2025 10:49:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkfO-00000000v0y-0ckw
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:49:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 86662A41440;
	Mon,  6 Jan 2025 10:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC793C4CED2;
	Mon,  6 Jan 2025 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736160541;
	bh=rHrPFkcMDrKJSX1xGQ4HM/tkZ2yYSiqYA/+NEKz7qyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pXFO8k8sCJfIXYk7LOUU+Dw+pR+yMrkhiW9riaNycbKdwZh53hG3nMH9f1xJ0XDED
	 ZhYHpJxmNfzNNVtDbc/HcF7q15uFl0V78mT6nvYfRmVhMg+hP5GynxKZrHYy4bcVsD
	 8esHUCvdTxSGIqJvNhuxZ6kB1fPwtpOgs2UMN+mvZu8v5+1Nk7K7YAIw4HwwYrkG0c
	 8ujCJDaahyrvbNN+31z53KqzYWCeiVwJ+RLrzySD3ROFIYRf2EJi2avidGqjjTi9g6
	 6w4u0oGNcGup7r1x5dJZOlmEBtZpn2A7qu4sy0fT507ztw6D9Gz2AE7JH1K6GnPP2n
	 UVrjxgt1PgHDg==
Message-ID: <ddc8d362-2cfe-4267-a900-7ea419b15b01@kernel.org>
Date: Mon, 6 Jan 2025 19:48:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] block: use queue_limits_commit_update in
 queue_attr_store
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106100645.850445-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_024902_258219_39F9E1DA 
X-CRM114-Status: GOOD (  17.98  )
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

On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> Use queue_limits_commit_update to apply a consistent freeze vs limits
> lock order in queue_attr_store.  Also remove taking the sysfs lock
> as it doesn't protect anything here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops. OK. so please disregard my comments on patch 3. This is all fixed here.
May be sqash this patch with patch 3 ?

> ---
>  block/blk-sysfs.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 8d69315e986d..3bac27fcd635 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -687,22 +687,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	if (entry->load_module)
>  		entry->load_module(disk, page, length);
>  
> -	mutex_lock(&q->sysfs_lock);
> -	blk_mq_freeze_queue(q);
>  	if (entry->store_limit) {
>  		struct queue_limits lim = queue_limits_start_update(q);
>  
>  		res = entry->store_limit(disk, page, length, &lim);
>  		if (res < 0) {
>  			queue_limits_cancel_update(q);
> -		} else {
> -			res = queue_limits_commit_update(q, &lim);
> -			if (!res)
> -				res = length;
> +			return res;
>  		}
> -	} else {
> -		res = entry->store(disk, page, length);
> +
> +		res = queue_limits_commit_update_frozen(q, &lim);
> +		if (res)
> +			return res;
> +		return length;
>  	}
> +
> +	mutex_lock(&q->sysfs_lock);
> +	blk_mq_freeze_queue(q);
> +	res = entry->store(disk, page, length);
>  	blk_mq_unfreeze_queue(q);
>  	mutex_unlock(&q->sysfs_lock);
>  	return res;


-- 
Damien Le Moal
Western Digital Research

