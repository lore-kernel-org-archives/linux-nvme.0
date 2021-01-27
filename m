Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 13:13:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B9A207A0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 13:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B9A207A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kyUn4FcgH9AT8AbOS0SZGoNSE+VmSZiAtxfDixfY/d0=; b=PmpMcjKJeskjgk74g6SY7zXsb
	mXvhjxbTjyei2Iyg/VR167YT2YZokTFZr8NAkJkllN9s3nQ+RxlU0/43MrhSzMQ/YyoxaXy+jmBRl
	shAiTNXa6Tk9qleRlFuZNKsHku9eb5bRfzS+kphOruQfu6FD/ykpQj2HM6PZ6aSZfjrwmQPPRrkUs
	QWVEtthSHzOQsT4NEwZqUx+MZIz0RvJYaPg8pVasyaSRFwJ5lA83EaIbbzMORzOZPPKZHwbQ5w36h
	ae3KWl+ev9fYL7QW5qDmvZQ8aDzvUe53hnVnegf3Qj3St1sJHKL/Yf/nrea47PQ/0EGKPrgbz8rvr
	OOvjnzd5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4kcN-0005nR-Ez; Wed, 27 Jan 2021 13:12:19 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4kcH-0005m2-EQ
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 13:12:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CEA72AC4F;
 Wed, 27 Jan 2021 13:12:10 +0000 (UTC)
Subject: Re: [PATCH 2/3] bcache: use bio_set_dev to assign ->bi_bdev
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <20210126143308.1960860-1-hch@lst.de>
 <20210126143308.1960860-3-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <19965f34-ed71-c5c4-cd6b-b4c7ac4d5e38@suse.de>
Date: Wed, 27 Jan 2021 21:12:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126143308.1960860-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_081213_590956_D4ABADD5 
X-CRM114-Status: GOOD (  20.53  )
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/26/21 10:33 PM, Christoph Hellwig wrote:
> Always use the bio_set_dev helper to assign ->bi_bdev to make sure
> other state related to the device is uptodate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>


Coly Li

> ---
>  drivers/md/bcache/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index 058dd80144281e..63e809f38e3f51 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -114,7 +114,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
>  	check = bio_kmalloc(GFP_NOIO, bio_segments(bio));
>  	if (!check)
>  		return;
> -	check->bi_bdev = bio->bi_bdev;
> +	bio_set_dev(check, bio->bi_bdev);
>  	check->bi_opf = REQ_OP_READ;
>  	check->bi_iter.bi_sector = bio->bi_iter.bi_sector;
>  	check->bi_iter.bi_size = bio->bi_iter.bi_size;
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
