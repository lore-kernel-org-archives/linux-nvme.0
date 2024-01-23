Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC99AC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUHdq6eq4d7S0Lu2oDlIY8c8gzPhM/pD3Sb93MEi62w=; b=pLYO2ZJRBjgsy9rlRdrgCnzsIU
	fYmi4kr75BlQXktFKtd20gdovBdAHQ5iJwEmD8xo8xy3cKG8RGW0C+UvXdrHEoFRahLmUFAWoG6/6
	9te0PIRUMMkAyfDAr1eIHoQgYcnyexu/w9o/ux8hiVZ3op4y8zvNdFp7oyNHoGPoELl9OKhB+thKa
	PLPKFA/5DsnN/a5cFfe7sQyDo2VaqYTSwq0m3UaW0arPkqkTBB46ngWWA3uNsW2g6QeiiLJXpzJk+
	9JqDbFHskZJuPcrBzAROh4fg7O+kHaczeZz5RYoc74u2l6hqAP0tVR67NBe9BM3QfSIJh1vvRhrh/
	D6DWBS+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS98w-00F7e5-30;
	Tue, 23 Jan 2024 05:16:14 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS98t-00F7d6-2j
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:16:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2FEB3CE2DBB;
	Tue, 23 Jan 2024 05:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D5C433F1;
	Tue, 23 Jan 2024 05:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986969;
	bh=3gjd11VNRFKEeXE8qGU7uHiRry2OiA7AdrPwpMjQSaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hnnyu1kYPQ7J9dya0/IJbWJZmtOgaWI2HIp+its6MYc0Mrh6nXBhoTCFpRBUQ1QvK
	 VD0P6frLT2Up9BpJTn9Nf7CgaUr6aZqnYyhfrd0+6L2Z25JdMLc/fykFkZTcJ7wpYk
	 Ayg75jeU3CADE1pqu4APT+MeRSaCcdYaHPfOJ4bkgBqxidfclAkFxRRyiotqXR4By6
	 F0CHU61kA62ver0vQcZivinyKeo7tI0e55gYxG6Y4YQ2xRBtKEilFPx7iifW54cSqk
	 Kuf9gma/KJRvljDMpCO7vKxSwGLR14lg+/IgBHLgMMM/oTMa2m5KQe5hauehEfX8T4
	 ED9A2ZRr8Q5IQ==
Message-ID: <ec80947b-fe0f-46a2-b7bb-76bf8fb8b510@kernel.org>
Date: Tue, 23 Jan 2024 14:16:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] block: use queue_limits_commit_update in
 queue_discard_max_store
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-8-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_211612_060496_62672DBE 
X-CRM114-Status: GOOD (  17.40  )
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Convert queue_discard_max_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before

s/updated/update
s/max_sectors/max_discard_sectors

> doing so to ensure we don't have request in flight while changing

s/request/requests

> the limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With the typos fixed, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-sysfs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 54e10604ddb1dd..8c8f69d8ba48ee 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -175,7 +175,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
>  				       const char *page, size_t count)
>  {
>  	unsigned long max_discard_bytes;
> +	struct queue_limits lim;
>  	ssize_t ret;
> +	int err;
>  
>  	ret = queue_var_store(&max_discard_bytes, page, count);
>  	if (ret < 0)
> @@ -187,10 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
>  	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
>  		return -EINVAL;
>  
> -	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> -	q->limits.max_discard_sectors =
> -		min_not_zero(q->limits.max_hw_discard_sectors,
> -			     q->limits.max_user_discard_sectors);
> +	blk_mq_freeze_queue(q);
> +	lim = queue_limits_start_update(q);
> +	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> +	err = queue_limits_commit_update(q, &lim);
> +	blk_mq_unfreeze_queue(q);
> +
> +	if (err)
> +		return err;
>  	return ret;
>  }
>  

-- 
Damien Le Moal
Western Digital Research


