Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE119CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FMpIw+4/bg5d5JM200rhY7E6bZSeI+7NplMoHYYK1Tw=; b=yCSgJ/q7c+1ziR1Kt5gyw++59A
	zxe3gRB4qae3sXRevq7PELwP2vh9Z/UqOtjocT4Xp89wM3/DXsUeBpz0H0cYqZ9/t1gYaIMjjUoNg
	WRG9+jVd0WyHmdM9P8CE3v0VHPzl538B61yDomZcMPu4vWq8J09cXWcMKjn6/jFB8itPiFywdar6s
	6EiKVS1V/bak2jHaEqBM5qHYJrqEqokD05SqRxnNcTIIKGRO5FxcoaM72dP5KyERCmjqch2a4sIkh
	32eqVk7YHXac/uT4fmvK4Fr/Jply/H+0mbsf+ES5BN3thvbkMI/Djg7DGJcRrX0t9MemXrG2qafGX
	ShOr40oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpuGX-0000000F6RV-22VV;
	Thu, 28 Mar 2024 18:14:17 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpuGT-0000000F6Qz-1sBo
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 18:14:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5BWR50w5zlgTGW;
	Thu, 28 Mar 2024 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711649647; x=1714241648; bh=FMpIw+4/bg5d5JM200rhY7E6
	bZSeI+7NplMoHYYK1Tw=; b=iuwosM9KdXWsyq1U30xWAJpj9J7ys9QDClYZFUv7
	zwclHQgfVB3/WXjHtwTvtqmF4Fl24fpxZ+LuVbvrTG8E04kr0zJYBo/jUI4qZTLr
	Cc0u4SHampfYpUNGkRcJgBF2bEDbRAFDzDlxq2A+/VpcrXYs4VJ5GQq+jNXjW3Gw
	A+OGYyYtSbpE0kdvzObZZKFpxrFcTPb17zUN/xbP7XPGpGGAwHz8V82ejRMexCBm
	Wl/XEo7MzOS++EWAaJOOa+vLo3dL+Elwor9hiJVF5vgfFNp5VFsTHcZ0y7mK+5a8
	93Yji5qC9N8GEucum+kH+PKgQnTvHLpKLwbZZuyBP1ntUg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FpCBlwONxWxa; Thu, 28 Mar 2024 18:14:07 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5BWJ1T3tzlgTHp;
	Thu, 28 Mar 2024 18:14:03 +0000 (UTC)
Message-ID: <a474bae3-e505-4d17-a5e4-ed9928b6cbb3@acm.org>
Date: Thu, 28 Mar 2024 11:14:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/30] block: Do not force full zone append completion
 in req_bio_endio()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-2-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_111413_834930_D766B9E7 
X-CRM114-Status: GOOD (  22.18  )
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

On 3/27/24 17:43, Damien Le Moal wrote:
> This reverts commit 748dc0b65ec2b4b7b3dbd7befcc4a54fdcac7988.
> 
> Partial zone append completions cannot be supported as there is no
> guarantees that the fragmented data will be written sequentially in the
> same manner as with a full command. Commit 748dc0b65ec2 ("block: fix
> partial zone append completion handling in req_bio_endio()") changed
> req_bio_endio() to always advance a partially failed BIO by its full
> length, but this can lead to incorrect accounting. So revert this
> change and let low level device drivers handle this case by always
> failing completely zone append operations. With this revert, users will
> still see an IO error for a partially completed zone append BIO.
> 
> Fixes: 748dc0b65ec2 ("block: fix partial zone append completion handling in req_bio_endio()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-mq.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 555ada922cf0..32afb87efbd0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -770,16 +770,11 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
>   		/*
>   		 * Partial zone append completions cannot be supported as the
>   		 * BIO fragments may end up not being written sequentially.
> -		 * For such case, force the completed nbytes to be equal to
> -		 * the BIO size so that bio_advance() sets the BIO remaining
> -		 * size to 0 and we end up calling bio_endio() before returning.
>   		 */
> -		if (bio->bi_iter.bi_size != nbytes) {
> +		if (bio->bi_iter.bi_size != nbytes)
>   			bio->bi_status = BLK_STS_IOERR;
> -			nbytes = bio->bi_iter.bi_size;
> -		} else {
> +		else
>   			bio->bi_iter.bi_sector = rq->__sector;
> -		}
>   	}
>   
>   	bio_advance(bio, nbytes);

Hi Damien,

This patch looks good to me but shouldn't it be separated from this
patch series? I think that will help this patch to get merged sooner.

Thanks,

Bart.

